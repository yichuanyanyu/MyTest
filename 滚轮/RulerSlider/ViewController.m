//
//  ViewController.m
//  RulerSlider
//

#import "ViewController.h"
#import "ZVScrollSlider.h"

@interface ViewController ()<ZVScrollSliderDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *title = @"投资";
    
    CGFloat sliderHeight = [ZVScrollSlider heightWithBoundingWidth:self.view.bounds.size.width Title:title];
    ZVScrollSlider *productSlider  = [[ZVScrollSlider alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, sliderHeight)
                                                                    Title:title
                                                                 MinValue:0
                                                                 MaxValue:50000
                                                                     Step:500
                                                                     Unit:@""
                                                             HasDeleteBtn:NO];
    // productSlider.realValue = 50; // MaxValue/Step 比例可以知道首先存放位置
    productSlider.delegate = self;
    [self.view addSubview:productSlider];
    
    /*
    ZVScrollSlider *monthSlider = [[ZVScrollSlider alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(productSlider.frame), self.view.bounds.size.width, sliderHeight)
                                                                 Title:@"月份"
                                                              MinValue:0
                                                              MaxValue:120
                                                                  Step:1
                                                                  Unit:@"月"
                                                          HasDeleteBtn:NO];
    [self.view addSubview:monthSlider];
     */
}

- (void)ZVScrollSlider:(ZVScrollSlider *)slider ValueChange:(NSInteger)value {
    
    NSLog(@"---value -- : %ld",value);
}


@end
