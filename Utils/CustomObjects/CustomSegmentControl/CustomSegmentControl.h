//
//  CustomSegmentControl.h
//  Buffet
//
//  Created by apple on 12-11-14.
//  Copyright (c) 2012年 magicpoint. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomSegmentButton : UIButton
@property (nonatomic,copy) NSString * normalImageName;
@property (nonatomic,copy) NSString * highLightImageName;
@end

@protocol CustomSegmentControlDelegate;

@interface CustomSegmentControl : UIView

@property (nonatomic,assign) id<CustomSegmentControlDelegate> delegate;

@property (nonatomic,retain) NSArray * itemsArray;

@property (nonatomic,assign) NSInteger selectIndex;

//@property (nonatomic,retain) NSMutableArray * imagesArray;

// 初始化方法。
- (id)initWithFrame:(CGRect)frame Items:(NSArray*)itemsArray;
@end

@protocol CustomSegmentControlDelegate <NSObject>
@optional
-(void)segmentControl:(CustomSegmentControl*)segmentControl selectedSegmentIndex:(NSInteger)number;
@end