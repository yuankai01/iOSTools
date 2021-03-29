//
//  CETCImageScrollVC.h
//  CETCPatientCommunity
//
//  Created by xuyang on 2017/5/25.
//  Copyright © 2017年 Aaron Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CETCImageScrollVC : UICollectionViewController

@property (strong, nonatomic)NSArray *images;
@property (assign, nonatomic)NSInteger selectIndex;

@end
