//
//  UIView+Copy.m
//  FarbenOffice
//
//  Created by Gao on 2019/12/30.
//  Copyright © 2019 Gao. All rights reserved.
//

#import "UIView+Copy.h"

@implementation UIView (Copy)

+ (UILabel *)copyLabel:(UILabel *)label
{
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject: label];
    UILabel* copy = [NSKeyedUnarchiver unarchiveObjectWithData: archivedData];
    return copy;
}

+ (UIButton *)copyButton:(UIButton *)button
{
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject: button];
    UIButton* copy = [NSKeyedUnarchiver unarchiveObjectWithData: archivedData];
    return copy;
}

@end
