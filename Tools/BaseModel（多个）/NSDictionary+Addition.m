//
//  NSDictionary+Addition.m
//  Xiaopo
//
//  Created by lixiaopo on 14-12-21.
//  Copyright (c) 2014年 Xiaopo. All rights reserved.
//

#import "NSDictionary+Addition.h"

@implementation NSDictionary (Addition)
//返回数组的value
-(NSArray *)arrayForKey:(NSString *)key
{
    NSMutableArray *result = [NSMutableArray array];
    if (([key length] > 0) &&
        self[key]
        && ([NSNull null] != self[key])) {
        [result addObjectsFromArray:self[key]];
    }
    return result;
}

// 返回字符串的value
- (NSString *)strForKey:(NSString *)key
{
    NSString *result = @"";
    if (self[key] && ([NSNull null] != self[key])) {
        result = [NSString stringWithFormat:@"%@",self[key]];
    }
    return result;
}

//返回float的value
- (float)floatForKey:(NSString *)key
{
    float result = 0;
    if (self[key] && ([NSNull null] != self[key])) {
        result = [self[key] floatValue];
    }
    return result;
}

//返回double的value
- (double)doubleForKey:(NSString *)key
{
    float result = 0;
    if (self[key] && ([NSNull null] != self[key])) {
        result = [self[key] doubleValue];
    }
    return result;
}

// 返回uint64的value
- (uint64_t)uint64ForKey:(NSString *)key
{
    uint64_t result = 0;
    if (self[key] && ([NSNull null] != self[key])) {
        result = [self[key] uint64Value];
    }
    return result;
}

// 返回bool的value
- (BOOL)boolForKey:(NSString *)key
{
    BOOL result = NO;
    if (self[key] && ([NSNull null] != self[key])) {
        result = [self[key] boolValue];
    }
    return result;
}

// 返回int的value
- (int)intForKey:(NSString *)key
{
    int result = 0;
    if (self[key] && ([NSNull null] != self[key])) {
        result = [self[key] intValue];
    }
    return result;
}

@end

@implementation NSMutableDictionary (ExtendedDictionary)

- (void)addObject:(id)anObject forKey:(id <NSCopying>)aKey
{
    if (anObject && ![anObject isKindOfClass:[NSNull class]] && aKey) {
        
        [self setObject:anObject forKey:aKey];
    }
}

@end
