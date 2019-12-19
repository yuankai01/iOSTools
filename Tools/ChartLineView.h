//
//  ChartLineView.h
//  JHD_iOS
//
//  Created by Gao on 2019/3/4.
//  Copyright © 2019 JHD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChartLineView : UIView

@property (strong, nonatomic) NSArray *valueArray;
@property (assign, nonatomic) NSInteger hGrid;  //水平方向分几部分
@property (assign, nonatomic) NSInteger vGrid;  //垂直方向分几部分

- (CGFloat)getYWithValue:(CGFloat)value;

@end

NS_ASSUME_NONNULL_END
