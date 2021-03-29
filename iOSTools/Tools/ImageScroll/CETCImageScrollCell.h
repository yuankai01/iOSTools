//
//  CETCImageScrollCell.h
//  CETCPatientCommunity
//
//  Created by xuyang on 2017/5/25.
//  Copyright © 2017年 Aaron Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLPhoto.h"

typedef void (^CommonBlock)(void); //普通block

@interface CETCImageScrollCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet LLPhoto *scrollView;

@property (copy, nonatomic)CommonBlock imageTouchBlock;

- (void)setImageUrl:(NSString *)imageUrl;

@end
