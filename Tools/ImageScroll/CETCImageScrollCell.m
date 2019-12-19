//
//  CETCImageScrollCell.m
//  CETCPatientCommunity
//
//  Created by xuyang on 2017/5/25.
//  Copyright © 2017年 Aaron Yu. All rights reserved.
//

#import "CETCImageScrollCell.h"

@interface CETCImageScrollCell ()<UIGestureRecognizerDelegate,UIScrollViewDelegate,LLPhotoDelegate>

@end

@implementation CETCImageScrollCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.scrollView.ll_delegate = self;
}

#pragma mark - data
- (void)setImageUrl:(NSString *)imageUrl
{
    [self.scrollView setLl_image:imageUrl];
}

#pragma mark - actions
- (void)singleClickWithPhoto:(LLPhoto *)photo
{
    if (self.imageTouchBlock) {
        self.imageTouchBlock();
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.scrollView.zoomScale = 1.0;
    self.scrollView.contentSize = self.scrollView.bounds.size;
}
@end
