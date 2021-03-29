//
//  NSString+Extension.m
//  JHD_iOS
//
//  Created by Gao on 2019/1/20.
//  Copyright © 2019 JHD. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

+  (BOOL)isBlankString:(NSString *)aStr
{
    if (!aStr) {
        return YES;
    }
    if ([aStr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [aStr stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    
    return NO;
}

@end
