//
//  AppLanguage.m
//  Buffet
//
//  Created by magicmac on 12-11-2.
//  Copyright (c) 2012年 magicpoint. All rights reserved.
//

#import "AppLanguage.h"

@implementation AppLanguage

#pragma mark - // 获取系统语言
/**
  *得到本机现在用的语言
  * en:英文  zh-Hans:简体中文   zh-Hant:繁体中文    ja:日本  ......
 */
+ (NSString*)getPreferredLanguage
{
	NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    //    NSLog(@" \n NSUserDefaults == %@ \n ",defs);
	NSArray* languages = [defs objectForKey:@"AppleLanguages"];
	NSString* preferredLang = [languages objectAtIndex:0];
    //	NSLog(@"Preferred Language:%@", preferredLang);
	return preferredLang;
}

+ (CurrentLanguage)getCurrentLanguage {
    
    CurrentLanguage lan;
    NSString *language = [self getPreferredLanguage];
    if ([language isEqualToString:@"zh-Hans"]) {
        lan = SimpleChinese;
    }
    else {
        lan = English;
    }
    return lan;
}

@end
