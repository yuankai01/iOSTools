//
//  VerticallyAlignedLabel.h
//  CpicPeriodicaliPad
//
//  Created by MagicPoint on 13-7-17.
//  Copyright (c) 2013年 magicpoint. All rights reserved.
//

/*
 如何使用该类:在要使用的类头文件中导入#import "VerticallyAlignedLabel.h",并声明属性:@property (nonatomic,retain) VerticallyAlignedLabel *totalPeriodicalLabel;
 然后在.m文件中:初始化的时候调用方法- (id)initWithFrame:(CGRect)frame verticalAlignmentType:(VerticalAlignmentType) alignmentType;选择垂直位置VerticalAlignmentType.
 
 如:VerticallyAlignedLabel *periodicalLabel = [[VerticallyAlignedLabel alloc] initWithFrame:CGRectMake(labelWidth, 0, 100, height / 2) verticalAlignmentType:VerticalAlignmentBottom];
 periodicalLabel.backgroundColor = [UIColor clearColor];
 periodicalLabel.font = [UIFont systemFontOfSize:13];
 periodicalLabel.textAlignment = UITextAlignmentRight;
 periodicalLabel.textColor = [UIColor colorWithRed:120 / 255.0 green:120 / 255.0 blue:120 / 255.0 alpha:1];
 self.totalPeriodicalLabel = periodicalLabel;
 */

#import <UIKit/UIKit.h>

typedef enum VerticalAlignment {
    VerticalAlignmentTop,
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignmentType;

@interface VerticallyAlignedLabel : UILabel

@property (nonatomic, assign) VerticalAlignmentType verticalAlignment;

- (id)initWithFrame:(CGRect)frame verticalAlignmentType:(VerticalAlignmentType) alignmentType;

@end
