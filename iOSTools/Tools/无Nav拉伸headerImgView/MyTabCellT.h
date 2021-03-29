//
//  MyTabCellT.h
//  FarbenOffice
//
//  Created by Gao on 2019/12/19.
//  Copyright © 2019 Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTabCellT : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *msgNumLab;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImgView;

@end

NS_ASSUME_NONNULL_END
