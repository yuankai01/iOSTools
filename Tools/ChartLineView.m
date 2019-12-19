//
//  ChartLineView.m
//  JHD_iOS
//
//  Created by Gao on 2019/3/4.
//  Copyright © 2019 JHD. All rights reserved.
//

#import "ChartLineView.h"
@interface CETCColoredControl2 : UIControl

@property(nonatomic, strong)UIColor *color;
@property (strong, nonatomic) UIColor *fillColor;

@end

@implementation CETCColoredControl2

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(1, 1, CGRectGetWidth(self.frame) - 2, CGRectGetHeight(self.frame) - 2) cornerRadius:CGRectGetHeight(self.frame) / 2.0];
    [_color setStroke];
    [self.fillColor setFill];
    
    path.lineWidth = 1.5;
    [path fill];
    [path stroke];
}

@end

#pragma mark - ******************
@interface ChartLineView ()
{
    CGFloat titlePadding;
    CGFloat xGrid;
}

@property (strong, nonatomic) NSMutableArray *pointArray;
@property (strong, nonatomic) NSMutableArray *circleViewArray;
@property (strong, nonatomic) NSMutableArray *pointsTitleArray;

@end

@implementation ChartLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initData];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    titlePadding = 15;
    xGrid = CGRectGetWidth(self.bounds) / self.hGrid;
}

- (void)initData
{
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    // Drawing code
    if (self.pointArray.count <= 0)
    {
        return;
    }
    
    UIBezierPath *path = [self smootPathWithPoints:self.pointArray];
    path.lineWidth = 1.5;
    
    [[UIColor redColor] setStroke];
    [path stroke];
}

- (UIBezierPath *)smootPathWithPoints:(NSArray *)pointArray
{
    if (pointArray.count <= 0) {
        return nil;
    }
    
    UIBezierPath *linePath = [[UIBezierPath alloc] init];
    [linePath moveToPoint:[pointArray[0] CGPointValue]];
    for (int i = 1; i < pointArray.count; i++) {
        [linePath addLineToPoint:[pointArray[i] CGPointValue]];
    }
    
    return linePath;
}

- (CGFloat)getYWithValue:(CGFloat)value
{
    CGFloat maxValue = [[self.valueArray valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat minValue = [[self.valueArray valueForKeyPath:@"@min.floatValue"] floatValue];
    
    CGFloat height = CGRectGetHeight(self.bounds) - titlePadding;
    CGFloat y = height - (value - minValue) * height / (maxValue - minValue) + titlePadding;
    
    return y;
}

//根据返回数据画折线图
- (void)setValueArray:(NSArray *)valueArray
{
    _valueArray = valueArray;
    
    if (self.hGrid <= 0) {
        return;
    }
    
    CGFloat maxValue = [[valueArray valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat minValue = [[valueArray valueForKeyPath:@"@min.floatValue"] floatValue];
    
    [self.pointArray removeAllObjects];
    CGFloat height = CGRectGetHeight(self.bounds) - titlePadding;
    for (int i = 0; i < valueArray.count; i++) {
        CGFloat y = height - ([valueArray[i] floatValue] - minValue) * height / (maxValue - minValue) + titlePadding;
        CGPoint point = CGPointMake(xGrid * i, y);
        [self.pointArray addObject:[NSValue valueWithCGPoint:point]];
    }
    
    [self addCircelPoint];
    [self addPointTitle:valueArray];
    
    [self setNeedsDisplay];
    [self layoutIfNeeded];
}

//添加圆点
- (void)addCircelPoint
{
    [self.circleViewArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.circleViewArray removeAllObjects];
    
    for (NSValue *value in self.pointArray)
    {
        CETCColoredControl2 *control = [[CETCColoredControl2 alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        control.color = JK99TextColor;
        control.fillColor =  [UIColor whiteColor];
        control.backgroundColor = [UIColor clearColor];
        control.center = [value CGPointValue];
        
        [self addSubview:control];
        
        [self.circleViewArray addObject:control];
    }
}

//点对应的数值title
- (void)addPointTitle:(NSArray *)points
{
    [self.pointsTitleArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.pointsTitleArray removeAllObjects];
    
    for (int i = 0; i < points.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
        label.textColor = JK66TextColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        
        CGPoint point = [self.pointArray[i] CGPointValue];
        
        label.center = CGPointMake(point.x + 5, point.y - 15);
        label.text = [NSString stringWithFormat:@"%@",points[i]];
        
        [self addSubview:label];
        [self.pointsTitleArray addObject:label];
    }
}

#pragma mark - 懒加载 *******
- (NSMutableArray *)pointArray
{
    if (!_pointArray) {
        _pointArray = [[NSMutableArray alloc] init];
    }
    
    return _pointArray;
}
- (NSMutableArray *)circleViewArray
{
    if (!_circleViewArray) {
        _circleViewArray = [[NSMutableArray alloc] init];
    }
    
    return _circleViewArray;
}

- (NSMutableArray *)pointsTitleArray
{
    if (!_pointsTitleArray) {
        _pointsTitleArray = [[NSMutableArray alloc] init];
    }
    
    return _pointsTitleArray;
}

@end
