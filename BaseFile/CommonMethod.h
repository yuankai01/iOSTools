//
//  CommonMethod.h
//  Colourful
//
//  Created by MagicPoint on 13-9-4.
//  Copyright (c) 2013年 MagicPoint. All rights reserved.
/*
 导入宏定义文件
 */

#import <Foundation/Foundation.h>

@interface CommonMethod : NSObject

#pragma mark - 拉伸复制一像素图像
+ (UIImage *)stretchableImage:(UIImage *)image withLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight;
+(UIButton *)initCommonButton:(CGRect)frame;

+(UIButton *) makeDetailDisclosureButton;
//只针对 image 和 title 横向 位置的 button 做调整,清除背景颜色
+(UIButton *)customButtonFrame:(CGRect)frame WithImage:(UIImage *)image andDownImge:(UIImage *)downImage withTitle:(NSString *)title andSpacing:(CGFloat)space;

//针对button 图像在左,字体在右的方法,正常显示
+(UIButton *)customButtonWithLeftImage:(UIImage *)image andRightTitle:(NSString *)title;
#pragma mark - 根据label获取label的高度
+(CGFloat)getLabelHeight:(UILabel *)label;

#pragma mark - getEgoImgeViewURLWithStr
+(NSURL *)getEgoImgeViewURLWithStr:(NSString *)str;
#pragma mark - 将时间戳转换为日期,并以字符串格式返回
+(NSString *)dateFromTimeStamp:(NSString *)timeStamp withType:(NSString *)type;
#pragma mark - 在字符串A中,获取子字符串B的最后一次出现的位置
+(NSRange)getSubStringLocation:(NSString *)findString inString:(NSString *)string;

@end
