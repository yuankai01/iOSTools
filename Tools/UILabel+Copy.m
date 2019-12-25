//
//  UILabel+Copy.m
//  FarbenOffice
//
//  Created by Gao on 2019/12/25.
//  Copyright © 2019 Gao. All rights reserved.
//

#import "UILabel+Copy.h"

@implementation UILabel (Copy)

+ (UILabel *)copyLabel:(UILabel *)label
{
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject: label];
    UILabel* copy = [NSKeyedUnarchiver unarchiveObjectWithData: archivedData];
    return copy;
}

@end
