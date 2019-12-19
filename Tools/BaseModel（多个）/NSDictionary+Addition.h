//
//  NSDictionary+Addition.h
//  Xiaopo
//
//  Created by lixiaopo on 14-12-21.
//  Copyright (c) 2014年 Xiaopo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Addition)
//返回数组的value
-(NSArray *)arrayForKey:(NSString *)key;

// 返回字符串的value
- (NSString *)strForKey:(NSString *)key;
// 返回uint64的value
- (uint64_t)uint64ForKey:(NSString *)key;
// 返回bool的value
- (BOOL)boolForKey:(NSString *)key;
// 返回int的value
- (int)intForKey:(NSString *)key;
//返回float的value
- (float)floatForKey:(NSString *)key;
//返回double的value
- (double)doubleForKey:(NSString *)key;

@end

@interface NSMutableDictionary (ExtendedDictionary)

- (void)addObject:(id)anObject forKey:(id <NSCopying>)aKey;

@end
