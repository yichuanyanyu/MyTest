//
//  ZVScrollSider.h
//  scrllSlider
//

#import <UIKit/UIKit.h>

@class ZVScrollSlider;

@protocol ZVScrollSliderDelegate <NSObject>

-(void)ZVScrollSlider:(ZVScrollSlider *)slider ValueChange:(NSInteger)value;

@optional
-(void)ZVScrollSliderDidDelete:(ZVScrollSlider *)slider;
-(void)ZVScrollSliderDidTouch:(ZVScrollSlider *)slider;

@end

@interface ZVScrollSlider : UIView
@property (nonatomic, copy ) NSString *title;
@property (nonatomic, copy ,  readonly) NSString *unit;
@property (nonatomic, assign ,readonly) NSInteger minValue;
@property (nonatomic, assign ,readonly) NSInteger maxValue;
@property (nonatomic, assign) NSInteger step;
@property (nonatomic, weak) id<ZVScrollSliderDelegate> delegate;

@property (nonatomic, assign) CGFloat realValue;
- (void)setRealValue:(CGFloat)realValue Animated:(BOOL)animated;

- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title MinValue:(NSInteger)minValue MaxValue:(NSInteger)maxValue Step:(NSInteger)step Unit:(NSString *)unit HasDeleteBtn:(BOOL)hasDeleteBtn;
+ (CGFloat)heightWithBoundingWidth:(CGFloat )width Title:(NSString *)title;
@end
