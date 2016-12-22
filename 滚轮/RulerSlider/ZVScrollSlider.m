//
//  ZVScrollSider.m
//  scrllSlider

#define dialColorGrayscale 0.789 //刻度的颜色灰度
#define textColorGrayscale 0.629 //文字的颜色灰度
#define textRulerFont [UIFont systemFontOfSize:9]

#define dialGap 10
#define dialLong 18
#define dialShort 9
#define dialGapKedu 5 // 显示每大格显示几个

#import "ZVScrollSlider.h"

#pragma mark - -------------------------------蛋疼的分割线--------------------------------

@interface ZVRulerView : UIView
@property (nonatomic, assign) NSInteger minValue;
@property (nonatomic, assign) NSInteger maxValue;
@property (nonatomic, copy) NSString *unit;
@end

@implementation ZVRulerView

/**
 *  绘制标尺view
 *
 *  @param rect rect
 */
-(void)drawRect:(CGRect)rect
{
    //计算位置
    CGFloat startX = 0;
    
    CGFloat lineCenterX = dialGap;
    CGFloat shortLineY = rect.size.height - dialShort;
    CGFloat longLineY = rect.size.height - dialLong;
    CGFloat bottomY = rect.size.height;
    
    if (self.maxValue == 0)
    {
        self.maxValue = 500;
    }
    CGFloat step = (self.maxValue - self.minValue)/dialGapKedu;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor darkGrayColor].CGColor);
    //CGContextSetRGBStrokeColor(context, dialColorGrayscale, dialColorGrayscale, dialColorGrayscale, 1);//设置线的颜色, 如果不设置默认是黑色的
    CGContextSetLineWidth(context, 0.5);//设置线的宽度, 默认是1像素
    CGContextSetLineCap(context, kCGLineCapButt);
    for (NSInteger i = 0; i<= dialGapKedu; i++)
    {
        if (i%dialGapKedu == 0)
        {
            CGContextMoveToPoint(context,startX + lineCenterX*i, longLineY);//起使点
            NSString *Num = [NSString stringWithFormat:@"%.f%@",i*step + self.minValue,self.unit];
            if ([Num floatValue]>50000)
            {
                Num = [NSString stringWithFormat:@"%.f万%@",[Num floatValue]/5000.f,self.unit];
            }
            
            NSDictionary *attribute = @{NSFontAttributeName:textRulerFont,NSForegroundColorAttributeName:[UIColor colorWithWhite:textColorGrayscale alpha:1]};
            CGFloat width = [Num boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:attribute context:nil].size.width;
            [Num drawInRect:CGRectMake(startX + lineCenterX*i-width/2, longLineY-14, width, 14) withAttributes:attribute];
        }
        else
        {
            CGContextMoveToPoint(context,startX +  lineCenterX*i, shortLineY);//起使点
        }
        CGContextAddLineToPoint(context,startX +  lineCenterX*i, bottomY);
        CGContextStrokePath(context);//开始绘制
    }
}

@end

#pragma mark - -------------------------------蛋疼的分割线--------------------------------

@interface ZVFooterRulerView : UIView
@property (nonatomic, assign) NSInteger maxValue;
@property (nonatomic, copy) NSString *unit;
@end

@implementation ZVFooterRulerView

-(void)drawRect:(CGRect)rect
{
    CGFloat longLineY = rect.size.height - dialLong;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, dialColorGrayscale, dialColorGrayscale, dialColorGrayscale, 1);//设置线的颜色, 如果不设置默认是黑色的
    //        CGContextSetLineWidth(context, 2.0);//设置线的宽度, 默认是1像素
    CGContextSetLineCap(context, kCGLineCapButt);

    CGContextMoveToPoint(context,0, longLineY);//起使点
    NSString *Num = [NSString stringWithFormat:@"%ld%@",(long)self.maxValue,self.unit];
    if ([Num floatValue]>50000)
    {
        Num = [NSString stringWithFormat:@"%.f万%@",[Num floatValue]/5000.f,self.unit];
    }
        
    NSDictionary *attribute = @{NSFontAttributeName:textRulerFont,NSForegroundColorAttributeName:[UIColor colorWithWhite:textColorGrayscale alpha:1]};
    CGFloat width = [Num boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:attribute context:nil].size.width;
    [Num drawInRect:CGRectMake(0-width/2, longLineY-14, width, 14) withAttributes:attribute];
    CGContextAddLineToPoint(context,0, rect.size.height);
    CGContextStrokePath(context);//开始绘制
}

@end

#pragma mark - -------------------------------蛋疼的分割线--------------------------------
@interface ZVHeaderRulerView : UIView
@property (nonatomic, assign) NSInteger minValue;
@property (nonatomic, copy) NSString *unit;
@end

@implementation ZVHeaderRulerView

-(void)drawRect:(CGRect)rect
{
    CGFloat longLineY = rect.size.height - dialLong;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, dialColorGrayscale, dialColorGrayscale, dialColorGrayscale, 1);//设置线的颜色, 如果不设置默认是黑色的
    //        CGContextSetLineWidth(context, 2.0);//设置线的宽度, 默认是1像素
    CGContextSetLineCap(context, kCGLineCapButt);

    CGContextMoveToPoint(context,rect.size.width, longLineY);//起使点
    NSString *Num = [NSString stringWithFormat:@"%ld%@",(long)self.minValue,self.unit];
    if ([Num floatValue]>50000)
    {
        Num = [NSString stringWithFormat:@"%.f万%@",[Num floatValue]/5000.f,self.unit];
    }
        
    NSDictionary *attribute = @{NSFontAttributeName:textRulerFont,NSForegroundColorAttributeName:[UIColor colorWithWhite:textColorGrayscale alpha:1]};
    CGFloat width = [Num boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:attribute context:nil].size.width;
    [Num drawInRect:CGRectMake(rect.size.width-width/2, longLineY-14, width, 14) withAttributes:attribute];
    CGContextAddLineToPoint(context,rect.size.width, rect.size.height);
    CGContextStrokePath(context);//开始绘制
}

@end

#pragma mark - -------------------------------蛋疼的分割线--------------------------------

@interface ZVScrollSlider ()<UIScrollViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UILabel          *titleLabel;
@property (nonatomic, strong) UITextField      *valueTF;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIImageView      *redLine;
@property (nonatomic, strong) UIImageView      *bottomLine;

@property (nonatomic, assign) NSInteger              stepNum;
@property (nonatomic, assign) NSInteger              value;
@property (nonatomic, assign) BOOL             scrollByHand;

@end

@implementation ZVScrollSlider

-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title MinValue:(NSInteger)minValue MaxValue:(NSInteger)maxValue Step:(NSInteger)step Unit:(NSString *)unit HasDeleteBtn:(BOOL)hasDeleteBtn
{
    if(self = [super initWithFrame:frame])
    {
        //readOnly设置
        self.title = title;
        _minValue = minValue;
        _maxValue = maxValue;
        _step = step;
        _stepNum = (_maxValue-_minValue)/_step/dialGapKedu;
        _unit = unit;
        _scrollByHand = NO;
        
        //名称Label
        CGFloat height            = [_title boundingRectWithSize:CGSizeMake(frame.size.width-10-18-6-15, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        _titleLabel               = [[UILabel alloc]initWithFrame:CGRectMake(10+18+6, 40, frame.size.width-10-18-6-15, height)];
        if (!hasDeleteBtn)
        {
            self.titleLabel.frame = CGRectMake(15, 40, frame.size.width-30, height);
        }
        self.titleLabel.font          = [UIFont systemFontOfSize:14];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.text          = _title;
        self.titleLabel.textColor     = [UIColor blackColor];
        [self addSubview:self.titleLabel];
        
        //输入框
        _valueTF                          = [[UITextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLabel.frame)+10, frame.size.width, 20)];
        self.valueTF.defaultTextAttributes    = @{NSUnderlineColorAttributeName:[UIColor orangeColor],
                                           NSUnderlineStyleAttributeName:@(1),
                                           NSFontAttributeName:[UIFont systemFontOfSize:18],
                                           NSForegroundColorAttributeName:[UIColor orangeColor]};
        self.valueTF.textAlignment            = NSTextAlignmentCenter;
        self.valueTF.delegate                 = self;
        self.valueTF.keyboardType             = UIKeyboardTypeNumberPad;
        
        self.valueTF.attributedPlaceholder    = [[NSAttributedString alloc]initWithString:@"滑动标尺或输入"
                                                                           attributes:@{NSUnderlineColorAttributeName:[UIColor lightGrayColor],
                                                                                        NSUnderlineStyleAttributeName:@(1),
                                                                                        NSFontAttributeName:[UIFont systemFontOfSize:12],
                                                                                        NSForegroundColorAttributeName:[UIColor grayColor]}];
        [self addSubview:_valueTF];
        
        //标尺
        UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        _collectionView  =[[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_valueTF.frame), self.bounds.size.width, 50) collectionViewLayout:flowLayout];
        self.backgroundColor = [UIColor whiteColor];
        self.collectionView.backgroundColor = [UIColor redColor];
        
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"systemCell"];
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"custemCell"];
        
        self.collectionView.bounces = NO;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        [self addSubview:self.collectionView];
        
        _redLine = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-0.5, CGRectGetMaxY(_valueTF.frame)+5, 1, 45)];
        self.redLine.backgroundColor = [UIColor orangeColor];
        [self addSubview:self.redLine];
        
        _bottomLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-0.5, self.bounds.size.width, 0.5)];
        self.bottomLine.backgroundColor = [UIColor grayColor];
        [self addSubview:self.bottomLine];
    }
    return self;
}

+(CGFloat)heightWithBoundingWidth:(CGFloat )width Title:(NSString *)title
{
    CGFloat height  = [title boundingRectWithSize:CGSizeMake(width-10-18-6-15, CGFLOAT_MAX)
                                          options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
                                          context:nil].size.height;
    return 40+height+10+20+50;
}

#pragma setter
-(void)setRealValue:(CGFloat)realValue
{
    [self setRealValue:realValue Animated:NO];
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = _title;
}

-(void)setRealValue:(CGFloat)realValue Animated:(BOOL)animated
{
    _realValue = realValue;
    [self.valueTF resignFirstResponder];
    self.valueTF.text = [NSString stringWithFormat:@"%ld",(long)(self.realValue * self.step)];
    [self.collectionView setContentOffset:CGPointMake((NSInteger)realValue*dialGap, 0) animated:animated];
    if (self.delegate && [self.delegate respondsToSelector:@selector(ZVScrollSlider:ValueChange:)])
    {
        [self.delegate ZVScrollSlider:self ValueChange:realValue * self.step];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    // 每次点击输入框 clear
    [self setRealValue:0 Animated:NO];
    textField.text = @"";
    return YES;
}

#pragma UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *newStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([newStr integerValue] > self.maxValue) {
        
        self.valueTF.text = [NSString stringWithFormat:@"%ld",(long)self.maxValue];
        [self performSelector:@selector(didChangeValue) withObject:nil afterDelay:0];
        return NO;
    }  else {
        
        // 首次输入0或者删除为0的时候不显示
        if ([newStr integerValue] == 0) {
            
            if ([textField.text integerValue] != 0) {
                return YES;
            }
            return NO;
        }
        
        self.scrollByHand = NO;
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(didChangeValue) withObject:nil afterDelay:1];
        return YES;
    }
}

-(void)didChangeValue
{
    CGFloat valueStep = [self.valueTF.text floatValue] / self.step;
    CGFloat valueStepYu = [self.valueTF.text integerValue] % self.step;
    
    if ([self.valueTF.text floatValue] >= 500) {
        
        if (valueStepYu != 0) {
				
            // [self.valueTF resignFirstResponder];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"输入必须是500的整数倍" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            
        } else {
            
            [self setRealValue:valueStep Animated:YES];
        }
    }
}

 /*
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    if ([textField.text floatValue] < 500) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"输入必须是500的整数倍" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        [self setRealValue:0 Animated:YES];
    }
    // [textField canResignFirstResponder];
    return YES;
}
 */

#pragma mark UICollectionViewDataSource & Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2 + self.stepNum;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 0 || indexPath.item == self.stepNum + 1)
    {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"systemCell" forIndexPath:indexPath];
        
        UIView *halfView = [cell.contentView viewWithTag:9527];
        if (!halfView)
        {
            if (indexPath.item == 0)
            {
                halfView = [[ZVHeaderRulerView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, 50)];
                ZVHeaderRulerView *header = (ZVHeaderRulerView *)halfView;
                header.backgroundColor = [UIColor whiteColor];
                header.minValue = self.minValue;
                header.unit = self.unit;
                [cell.contentView addSubview:header];
            }
            else
            {
                halfView = [[ZVFooterRulerView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, 50)];
                ZVFooterRulerView *footer = (ZVFooterRulerView *)halfView;
                footer.backgroundColor = [UIColor whiteColor];
                footer.maxValue = self.maxValue;
                footer.unit = self.unit;
                [cell.contentView addSubview:footer];
            }
        }
        
        return cell;
    }
    else
    {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"custemCell" forIndexPath:indexPath];
        ZVRulerView *ruleView = (ZVRulerView *)[cell.contentView viewWithTag:9527];
        if (!ruleView)
        {
            ruleView                 = [[ZVRulerView alloc]initWithFrame:CGRectMake(0, 0, dialGap*dialGapKedu, 50)];
            ruleView.backgroundColor = [UIColor whiteColor];
            ruleView.tag             = 9527;
            ruleView.unit            = self.unit;
            [cell.contentView addSubview:ruleView];
        }
        ruleView.minValue = self.step * dialGapKedu *(indexPath.item-1);
        ruleView.maxValue = self.step * dialGapKedu *indexPath.item;
        [ruleView setNeedsDisplay];
        
        return cell;
    }
}

-(CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 0 || indexPath.item == self.stepNum+1)
    {
        return CGSizeMake(self.frame.size.width/2, 50.f);
    }
    else
    {
        return CGSizeMake(dialGap*dialGapKedu, 50.f); // 修改此处可以调整刻度线
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    if (point.y < self.frame.size.height-50-20)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(ZVScrollSliderDidTouch:)])
        {
            [self.delegate ZVScrollSliderDidTouch:self];
        }
    }
}

#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollByHand)
    {
        int value = scrollView.contentOffset.x/(dialGap);
        self.valueTF.text = [NSString stringWithFormat:@"%d",value * self.step];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.scrollByHand = YES;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)//拖拽时没有滑动动画
    {
        [self setRealValue:round(scrollView.contentOffset.x/(dialGap)) Animated:YES];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self setRealValue:round(scrollView.contentOffset.x/(dialGap)) Animated:YES];
}

@end