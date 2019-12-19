//
//  JHBaseModel.m
//  JHD_iOS
//
//  Created by Gao on 2019/1/19.
//  Copyright © 2019 JHD. All rights reserved.
//

#import "JHBaseModel.h"

@implementation JHBaseModel

- (id)initWithDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        [self setAttributesFromDictionary:dic];
    }
    
    return self;
}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {
    
    aDictionary = [self removeNullFromDictionary:aDictionary];
    
    [self setValuesForKeysWithDictionary:aDictionary];
}

// 删除Dictionary中的NSNull
- (NSDictionary *)removeNullFromDictionary:(NSDictionary *)dic
{
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    for (NSString *strKey in dic.allKeys) {
        NSValue *value = dic[strKey];
        // 剩余的非NSNull类型的数据保存进字典
        if (![value isKindOfClass:NSNull.class]) {
            mdic[strKey] = dic[strKey];
        }
    }
    return [NSDictionary dictionaryWithDictionary:mdic];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

//有些属性 为空了我后续用到经常会崩溃 下面这个方法把<null>转为空字符串
-(void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:keyedValues];
    NSArray *valueArray = [dic allKeys];
    for (NSString *key in valueArray) {
        if ([[dic objectForKey:key] isEqual:[NSNull null]]) {
            [dic setObject:@"" forKey:key];
        }
    }
    
    [super setValuesForKeysWithDictionary:dic];
}

- (NSString *)description
{
    NSMutableString *des = [NSMutableString string];
    
    unsigned int allCount;
    
    objc_property_t *properties = class_copyPropertyList([self class], &allCount);
    
    for (int i = 0; i < allCount; i ++) {
        @autoreleasepool {
            objc_property_t property = properties[i];
            NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            id propertyValue = [self valueForKey:propertyName];
            
            if (nil == propertyValue || [NSNull null] == (NSNull *)propertyValue) {
                propertyValue = @"";
            }
            
            if (i < allCount - 1) {
                [des appendFormat:@"%@:'%@',",propertyName,propertyValue];
            }else
            {
                [des appendFormat:@"%@:'%@'",propertyName,propertyValue];
            }
        }
    }
    
    return des;
}

@end

@implementation NSDictionary (Model)

#pragma mark - model转化为字典
+ (NSDictionary *)dictionaryFromObject:(NSObject *)object
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([object class], &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:cName];
        NSObject *value = [object valueForKey:name];//valueForKey返回的数字和字符串都是对象
        
        if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
            //string , bool, int ,NSinteger
            [dic setObject:value forKey:name];
            
        } else if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
            //字典或字典
            [dic setObject:[self arrayOrDicWithObject:(NSArray*)value] forKey:name];
            
        } else if (value == nil) {
            //null
            //[dic setObject:[NSNull null] forKey:name];//这行可以注释掉?????
            
        } else {
            //model
            [dic setObject:[self dictionaryFromObject:value] forKey:name];
        }
    }
    
    return [dic copy];
}

//将可能存在model数组转化为普通数组
+ (id)arrayOrDicWithObject:(id)origin {
    if ([origin isKindOfClass:[NSArray class]]) {
        //数组
        NSMutableArray *array = [NSMutableArray array];
        for (NSObject *object in origin) {
            if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) {
                //string , bool, int ,NSinteger
                [array addObject:object];
                
            } else if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]]) {
                //数组或字典
                [array addObject:[self arrayOrDicWithObject:(NSArray *)object]];
                
            } else {
                //model
                [array addObject:[self dictionaryFromObject:object]];
            }
        }
        
        return [array copy];
        
    } else if ([origin isKindOfClass:[NSDictionary class]]) {
        //字典
        NSDictionary *originDic = (NSDictionary *)origin;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for (NSString *key in originDic.allKeys) {
            id object = [originDic objectForKey:key];
            
            if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) {
                //string , bool, int ,NSinteger
                [dic setObject:object forKey:key];
                
            } else if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]]) {
                //数组或字典
                [dic setObject:[self arrayOrDicWithObject:object] forKey:key];
                
            } else {
                //model
                [dic setObject:[self dictionaryFromObject:object] forKey:key];
            }
        }
        
        return [dic copy];
    }
    
    return [NSNull null];
}

@end
