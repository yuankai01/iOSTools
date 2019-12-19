//
//  JHTitleTextFiledCell.h
//  JHD_iOS
//
//  Created by Gao on 2019/1/13.
//  Copyright © 2019 JHD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHTitleTextFiledCell : UITableViewCell 

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UITextField *contentTF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabLeading;

@property (assign, nonatomic) CGFloat maxLength;

@property (copy, nonatomic) void (^tfDidEnd)(NSString *text);

@end

NS_ASSUME_NONNULL_END
