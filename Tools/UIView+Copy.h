//
//  UIView+Copy.h
//  FarbenOffice
//
//  Created by Gao on 2019/12/30.
//  Copyright © 2019 Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Copy)

+ (UILabel *)copyLabel:(UILabel *)label;
+ (UIButton *)copyButton:(UIButton *)button;

@end

NS_ASSUME_NONNULL_END
