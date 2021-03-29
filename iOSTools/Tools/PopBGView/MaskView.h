//
//  MaskView.h
//  JHD_iOS
//
//  Created by Gao on 2019/2/28.
//  Copyright © 2019 JHD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MaskView : UIView

@property (nonatomic,copy) void (^touchView) (void);

+ (MaskView *)showView:(UIView *)view;
+ (void)hidden;

@end

NS_ASSUME_NONNULL_END
