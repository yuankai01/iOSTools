//
//  NSArray+Addition.m
//  SweepStreet
//
//  Created by Bonnie on 15/11/2.
//  Copyright (c) 2015年 helloworld. All rights reserved.
//

#import "NSArray+Addition.h"

@implementation NSArray (Addition)
- (id)objectAtIndexCheck:(NSUInteger)index
{
    if (index >= [self count]) {
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}
@end
