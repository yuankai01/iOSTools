//
//  UIView+Dimensions.h
//  Colourful
//
//  Created by Gao on 13-11-18.
//  Copyright (c) 2013年 MagicPoint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Dimensions)

@property (nonatomic) CGFloat x ;
@property (nonatomic) CGFloat y ;
@property (nonatomic) CGFloat width ;
@property (nonatomic) CGFloat height ;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@property (nonatomic) CGSize  size ;
@property (nonatomic) CGPoint origin ;

// frame
@property (nonatomic) CGFloat maxX ;
@property (nonatomic) CGFloat maxY ;
@property (nonatomic) CGFloat minX ;
@property (nonatomic) CGFloat minY ;
@property (nonatomic) CGFloat midX ;
@property (nonatomic) CGFloat midY ;

// bounds
@property (nonatomic) CGFloat localMinX ;
@property (nonatomic) CGFloat localMinY ;
@property (nonatomic) CGFloat localMidX ;
@property (nonatomic) CGFloat localMidY ;
@property (nonatomic) CGFloat localMaxX ;
@property (nonatomic) CGFloat localMaxY ;

/**
 * Return the x coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenX;

/**
 * Return the y coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenY;

/**
 * Return the x coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewX;

/**
 * Return the y coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewY;

/**
 * Return the view frame on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGRect screenFrame;

- (void)removeAllSubviews;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;

@end
