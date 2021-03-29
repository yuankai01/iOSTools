//
//  GPDGalleryView.h
//  ThumbPicturesDemo
//
//  Created by Jason Hu on 12-8-6.
//  Copyright (c) 2012年 Magic Point. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"

@protocol GPDGalleryViewDelegate <NSObject>

-(void)galleryImageButtonMethod:(UIButton*)sender;

@end

@interface GPDGalleryView : UIView{
    NSArray *_photos;
}

@property (nonatomic, retain) NSArray *photos;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *thumbArray;
@property (nonatomic, assign) id<GPDGalleryViewDelegate>delegate; 

-(void)performThumbPicturesForInterfaceOrientation:(UIInterfaceOrientation)orientation;

@end
