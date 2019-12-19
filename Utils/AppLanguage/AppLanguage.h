//
//  AppLanguage.h
//  Buffet
//
//  Created by magicmac on 12-11-2.
//  Copyright (c) 2012年 magicpoint. All rights reserved.
//

#import <Foundation/Foundation.h>

// 当前语言环境
typedef enum currentLanguage {
    SimpleChinese = 0,
    English
}CurrentLanguage;


@interface AppLanguage : NSObject

#pragma mark - // 获取系统语言
/**
  *得到本机现在用的语言
  * en:英文  zh-Hans:简体中文   zh-Hant:繁体中文    ja:日本  ......
 */
+ (NSString*)getPreferredLanguage;
+ (CurrentLanguage)getCurrentLanguage;


@end
