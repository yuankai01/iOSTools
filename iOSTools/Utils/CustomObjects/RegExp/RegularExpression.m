//
//  RegularExpression.m
//  Colourful
//
//  Created by MagicPoint on 13-8-29.
//  Copyright (c) 2013年 MagicPoint. All rights reserved.
//

#import "RegularExpression.h"

@implementation RegularExpression

#pragma mark - 正则表达式
#pragma mark -  email 校验
- (BOOL)isValidateEmail:(NSString *)emailString {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [regExPredicate evaluateWithObject:emailString] ;
}

#pragma mark - 手机号 校验
- (BOOL)isValidateTelphone:(NSString *)telphoneString {
    NSString *telRegex = @"(((15[012356789]{1})|(18[02356789]{1})|(13[0-9]{1})|(14[57]{1}))+[0-9]{8})";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex];
    return [regExPredicate evaluateWithObject:telphoneString];
}

#pragma mark -  年龄校验
- (BOOL)isValidateAge:(NSString *)ageString {
    NSString *telRegex = @"([0-9]{1,2})";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex];
    return [regExPredicate evaluateWithObject:ageString];
}

#pragma mark -  用户名校验
- (BOOL)isValidateUserName:(NSString *)userNameString {
    NSString *userNameRegex = @"[A-Z0-9a-z_\u4e00-\u9fa5]{6,16}";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", userNameRegex];
    return [regExPredicate evaluateWithObject:userNameString] ;
}

#pragma mark -  密码校验
- (BOOL)isValidatePassword:(NSString *)passwordString {
    NSString *passwordRegex = @"[A-Z0-9a-z_]{6,16}";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [regExPredicate evaluateWithObject:passwordString] ;
}

//#pragma mark - 密码大小写英文字母和数字
//+ (BOOL)isValidatePassword:(NSString *)string
//{
//    NSString *regex = @"^\\d+[a-zA-Z]+$";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
//    
//    return [predicate evaluateWithObject:string];
//}

#pragma mark - 信用卡校验
- (BOOL)isValidateCreditCardNum:(NSString *)creditCardNumString {
    NSString *creditCardNumRegex = @"[0-9]{16}";
    //    NSString *creditCardNumRegex = @"^(3|4|5|6)\\d{14,15}$";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", creditCardNumRegex];
    return [regExPredicate evaluateWithObject:creditCardNumString] ;
}

#pragma mark -  信用卡有效期校验
- (BOOL)isValidateCreditCardValidity:(NSString *)creditCardValidityString {
    //    NSString *creditCardValidityRegex = @"^((0[1-9])|(1[0-2]))\\d{2}$";
    NSString *creditCardValidityRegex = @"^((1[3-9])|([2-9][0-9]))((0[1-9])|(1[0-2]))$";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", creditCardValidityRegex];
    return [regExPredicate evaluateWithObject:creditCardValidityString] ;
}

#pragma mark - 是否是正确的有效期格式
-(BOOL)isValidateNum:(NSString *)text
{
    NSString *numRegex = @"^\\d{2}((0[1-9])|(1[0-2]))$";
    NSPredicate *regExpredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numRegex];
    return [regExpredicate evaluateWithObject:text];
}

#pragma mark - 是否大于等于当前年份 或 月份
-(BOOL)isValidateYear:(NSString *)text
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setDateFormat:@"yy"];
    NSString *strCurrentYear = [formatter stringFromDate:[NSDate date]];
    
    //month
    NSDateFormatter *formatterMonth = [[NSDateFormatter alloc] init];
    [formatterMonth setDateStyle:NSDateFormatterMediumStyle];
    [formatterMonth setDateFormat:@"MM"];
    NSString *strCurMonth = [formatterMonth stringFromDate:[NSDate date]];
    
    BOOL boolValue = YES;
    if (text.length >= 3) {
        NSString *substr = [text substringToIndex:2];
        NSString *subMonth = [text substringFromIndex:2];
        if ([strCurrentYear caseInsensitiveCompare:substr] == NSOrderedDescending) {
            boolValue = YES;
        }else if ([strCurrentYear caseInsensitiveCompare:substr] == NSOrderedSame && [strCurMonth caseInsensitiveCompare:subMonth] == NSOrderedDescending)
        {
            boolValue = YES;
        }else
            boolValue = NO;
    }
    return boolValue;
}

#pragma mark - 身份证验证
-(BOOL)isValidateIdCard:(NSString *)strIdCard
{
    NSString *idCard = @"((11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65)[0-9]{4})+(([1|2][0-9]{3}[0|1][0-9][0-3][0-9][0-9]{3}+[Xx0-9])|([0-9]{2}[0|1][0-9][0-3][0-9][0-9]{3}))";
    
    NSPredicate *idCardTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",idCard];
    
    return [idCardTest evaluateWithObject:strIdCard];
}

#pragma mark - 判断入住日期是否小于当前日期
-(BOOL)isValidateCheckInDate:(NSString *)acheckInDate
{
    
    //此方法可以得到输入的正确日期和时间
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    dateFormater.timeZone = GTMzone;// 是关键.
    NSDate *checkInDate = [dateFormater dateFromString:acheckInDate];
    NSString *checkIndateStr = [dateFormater stringFromDate:checkInDate];
    DLog(@"checkinDate == %@ == %@",checkInDate,checkIndateStr);
    
    //此方法可以得到当前的正确日期和时间
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSString *currentDateStr = [dateFormater stringFromDate:localeDate];
    DLog(@"enddate=%@=== %@",localeDate,currentDateStr);
    
    BOOL boolValue = YES;
    if ([currentDateStr caseInsensitiveCompare:checkIndateStr] == NSOrderedDescending) {
        boolValue = YES;
    }else boolValue = NO;
    
    return boolValue;
}

#pragma mark - 判断入住时间是否在信用卡有效期范围内
-(BOOL)isValidateCreditCardVality:(NSString *)creditCardTime CompareWithCheckInDate:(NSString *)checkIndate
{
    
    NSString *checkInYear = [checkIndate substringWithRange:NSMakeRange(2, 2)];
    NSString *checkInMonth = [checkIndate substringWithRange:NSMakeRange(5, 2)];
    NSString *creditCardYear = [creditCardTime substringWithRange:NSMakeRange(0, 2)];
    NSString *creditCardMonth = [creditCardTime substringWithRange:NSMakeRange(2, 2)];
    //    DLog(@"yearMonth = %@,%@%@,%@",checkInYear,checkInMonth,creditCardYear,creditCardMonth);
    
    BOOL boolValue = YES;
    if ([checkInYear caseInsensitiveCompare:creditCardYear] == NSOrderedDescending) {
        boolValue = YES;
    }else if ([checkInYear caseInsensitiveCompare:creditCardYear] == NSOrderedSame && [checkInMonth caseInsensitiveCompare:creditCardMonth] == NSOrderedDescending)
    {
        boolValue = YES;
    }else
        boolValue = NO;
    
    return boolValue;
}

#pragma mark - 判断身份证号是否为连续相同的18位数字
-(BOOL)isValidateCardNum:(NSString *)strCardNum
{
    NSString *idCard = @"^(0{18})|(1{18})|(2{18})|(3{18})|(4{18})|(5{18})|(6{18})|(7{18})|(8{18})|(9{18})$";
    
    NSPredicate *idCardTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",idCard];
    
    return [idCardTest evaluateWithObject:strCardNum];
    
}

#pragma mark - 获取输入的正确时间 以及 当前的正确时间 避免时差8小时
-(NSString *)getInputDate:(NSString *)strDate
{
    //此方法可以得到输入的正确日期和时间 不相差8小时
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    dateFormater.timeZone = GTMzone;// 是关键.
    
    NSDate *checkInDate = [dateFormater dateFromString:strDate];
    NSString *checkIndateStr = [dateFormater stringFromDate:checkInDate];
    NSLog(@"checkinDate == %@ == %@",checkInDate,checkIndateStr);
    
    return checkIndateStr;
}

//获取的当前时间NSDate date与实际相差8个小时解决方案
-(NSString *)getCurrentDate
{
    //此方法可以得到当前的正确日期和时间
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    dateFormater.timeZone = GTMzone;// 是关键.
    
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    NSString *currentDateStr = [dateFormater stringFromDate:localeDate];
    NSLog(@"enddate=%@=== %@",localeDate,currentDateStr);
    return currentDateStr;
}

#pragma mark - 转换时间戳  timestamp
-(NSString *)turnTimeStamp:(NSString *)timeStamp
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"]; //设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSDate * timeStampDate = [NSDate dateWithTimeIntervalSince1970:[timeStamp intValue]];//时间戳转换成日期格式关键步
    //日期转换成字符串
    NSString *timeStampStr = [formatter stringFromDate:timeStampDate];
    NSLog(@"时间戳:== %@ == %@",timeStampDate,timeStampStr);
    return timeStampStr;
}

//判断是否为闰年
-(BOOL)isLeapYear:(NSString *)year
{
    NSInteger y = [year integerValue];
    BOOL isLeapYear = NO;
    if(y % 400 == 0 || (y % 4 == 0 && y % 100 != 0))
    {
        isLeapYear = YES;
        
    }else isLeapYear = NO;
    
    return isLeapYear;
}

@end
