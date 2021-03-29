//
//  RichTextView.h
//  JHD_iOS
//
//  Created by Gao on 2019/2/13.
//  Copyright © 2019 JHD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RichTextView : UITextView

@property (copy, nonatomic) void (^link)(void);

@end

NS_ASSUME_NONNULL_END
