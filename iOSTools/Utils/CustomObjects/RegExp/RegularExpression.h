//
//  RegularExpression.h
//  Colourful
//
//  Created by MagicPoint on 13-8-29.
//  Copyright (c) 2013年 MagicPoint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegularExpression : NSObject

#pragma mark - // 正则表达式 email 校验
- (BOOL)isValidateEmail:(NSString *)emailString;
// 手机号 校验
- (BOOL)isValidateTelphone:(NSString *)telphoneString;
// 年龄校验
- (BOOL)isValidateAge:(NSString *)ageString;
// 用户名校验
- (BOOL)isValidateUserName:(NSString *)userNameString;
// 密码校验
- (BOOL)isValidatePassword:(NSString *)passwordString;

// 信用卡校验
- (BOOL)isValidateCreditCardNum:(NSString *)creditCardNumString;
// 信用卡有效期校验
- (BOOL)isValidateCreditCardValidity:(NSString *)creditCardValidityString;
//是否是正确的有效期格式
-(BOOL)isValidateNum:(NSString *)text;
//是否大于等于当前年份
-(BOOL)isValidateYear:(NSString *)text;
//身份证验证
-(BOOL)isValidateIdCard:(NSString *)strIdCard;

//判断入住日期是否小于当前日期
-(BOOL)isValidateCheckInDate:(NSString *)acheckInDate;
//信用卡有效期和入住时间相比 年月
-(BOOL)isValidateCreditCardVality:(NSString *)creditCardTime CompareWithCheckInDate:(NSString *)checkIndate;
//判断身份证号是否为连续相同的18位数字
-(BOOL)isValidateCardNum:(NSString *)strCardNum;
#pragma mark - 获取输入的正确时间 以及 当前的正确时间 避免时差8小时
-(NSString *)getInputDate:(NSString *)strDate;
-(NSString *)getCurrentDate;
#pragma mark - 转换时间超  timestamp
-(NSString *)turnTimeStamp:(NSString *)timeStamp;
//是否为闰年
-(BOOL)isLeapYear:(NSString *)year;

@end
