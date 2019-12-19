//
//  UIView+Dimensions.m
//  Colourful
//
//  Created by Gao on 13-11-18.
//  Copyright (c) 2013年 MagicPoint. All rights reserved.
//

#import "UIView+Dimensions.h"

@implementation UIView (Dimensions)

//定义了dynamic就不需要设置set方法了
@dynamic minX , minY , midX , midY , maxX , maxY ,
localMaxX,localMaxY,localMidX,localMidY,localMinX,localMinY ;

#pragma mark - x
-(void)setX:(CGFloat)x
{
    CGRect frame = self.frame ;
    frame.origin.x = x;
    self.frame = frame ;
}

-(CGFloat)x
{
    return self.frame.origin.x ;
}

#pragma mark - y
-(void)setY:(CGFloat)y
{
    CGRect frame = self.frame ;
    frame.origin.y = y ;
    self.frame = frame ;
}

-(CGFloat)y
{
    return self.frame.origin.y ;
}

#pragma mark - width
-(void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame ;
    frame.size.width = width ;
    self.frame = frame ;
}

-(CGFloat)width
{
    return self.frame.size.width ;
}

#pragma mark - height
-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame ;
    frame.size.height = height ;
    self.frame = frame ;
}

-(CGFloat)height
{
    return self.frame.size.height ;
}

#pragma mark - centerX
- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

#pragma mark - centerY
- (CGFloat)centerY {
    return self.center.y;
}


- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

#pragma mark - origin
-(void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame ;
    frame.origin = origin ;
    self.frame = frame ;
}

-(CGPoint)origin
{
    return self.frame.origin ;
}

#pragma mark - size
-(void)setSize:(CGSize)size
{
    CGRect frame = self.frame ;
    frame.size = size ;
    self.frame = frame ;
}

-(CGSize)size
{
    return self.frame.size ;
}

#pragma mark - maxX *************
-(CGFloat)maxX
{
    return CGRectGetMaxX(self.frame) ;//和self.frame.origin.x + self.frame.size.width相等
}

-(CGFloat)maxY
{
    return CGRectGetMaxY(self.frame) ;//和self.frame.origin.y + self.frame.size.height相等
}

#pragma mark - minX
-(CGFloat)minX
{
    return CGRectGetMinX(self.frame) ;//和self.frame.origin.x相等
}

-(CGFloat)minY
{
    return CGRectGetMinY(self.frame) ;//和self.frame.origin.y相等
}

#pragma mark - midX
-(CGFloat)midX
{
    //    return self.center.x ;
    return CGRectGetMidX(self.frame) ;
}

-(CGFloat)midY
{
    //    return self.center.y ;
    return CGRectGetMidY(self.frame) ;
}

#pragma mark - localMinX ************
- (CGFloat)localMinX

{
    return CGRectGetMinX(self.bounds) ;
}

- (CGFloat)localMinY
{
    return CGRectGetMinY(self.bounds) ;
}

#pragma mark - localMidX
- (CGFloat)localMidX
{
    return CGRectGetMidX(self.bounds) ;
}

- (CGFloat)localMidY
{
    return CGRectGetMidY(self.bounds) ;
}

#pragma mark - localMaxX
- (CGFloat)localMaxX
{
    return CGRectGetMaxX(self.bounds) ;
}

- (CGFloat)localMaxY
{
    return CGRectGetMaxY(self.bounds) ;
}

///////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenX {
    CGFloat x = 0;
    for (UIView *view = self; view; view = view.superview){
        x += view.x;
    }
    return x;
}


///////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenY {
    CGFloat y = 0;
    for (UIView *view = self; view; view = view.superview){
        y += view.y;
    }
    return y;
}

///////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewX {
    CGFloat x = 0;
    for (UIView *view = self; view; view = view.superview){
        x += view.x;
        
        if ([view isKindOfClass:[UIScrollView class]]){
            UIScrollView *scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}

///////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewY {
    CGFloat y = 0;
    for (UIView *view = self; view; view = view.superview){
        y += view.y;
        
        if ([view isKindOfClass:[UIScrollView class]]){
            UIScrollView *scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y - [UIApplication sharedApplication].statusBarFrame.size.height;
}


///////////////////////////////////////////////////////////////////////////
- (CGRect)screenFrame {
    return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}

///////////////////////////////////////////////////////////////////////////
- (UIView*)descendantOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls])
        return self;
    
    for (UIView *child in self.subviews){
        UIView *it = [child descendantOrSelfWithClass:cls];
        if (it)
            return it;
    }
    
    return nil;
}

///////////////////////////////////////////////////////////////////////////
- (UIView*)ancestorOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls]){
        return self;
    } else if (self.superview){
        return [self.superview ancestorOrSelfWithClass:cls];
    } else {
        return nil;
    }
}

///////////////////////////////////////////////////////////////////////////
- (void)removeAllSubviews {
    while (self.subviews.count){
        UIView *child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (UIImage *) imageByRenderingView:(CGRect)f
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, scale);
    else
        UIGraphicsBeginImageContext(self.bounds.size);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	return  UIGraphicsGetImageFromCurrentImageContext();
    
}

///////////////////////////////////////////////////////////////////////////
- (CGPoint)offsetFromView:(UIView*)otherView {
    CGFloat x = 0, y = 0;
    for (UIView *view = self; view && view != otherView; view = view.superview){
        x += view.x;
        y += view.y;
    }
    return CGPointMake(x, y);
}

#pragma mark - move and scaling
// Move via offset
- (void) moveBy: (CGPoint) delta
{
	CGPoint newcenter = self.center;
	newcenter.x += delta.x;
	newcenter.y += delta.y;
	self.center = newcenter;
}

// Scaling
- (void) scaleBy: (CGFloat) scaleFactor
{
	CGRect newframe = self.frame;
	newframe.size.width *= scaleFactor;
	newframe.size.height *= scaleFactor;
	self.frame = newframe;
}

// Ensure that both dimensions fit within the given size by scaling down
- (void) fitInSize: (CGSize) aSize
{
	CGFloat scale;
	CGRect newframe = self.frame;
	
	if (newframe.size.height && (newframe.size.height > aSize.height))
	{
		scale = aSize.height / newframe.size.height;
		newframe.size.width *= scale;
		newframe.size.height *= scale;
	}
	
	if (newframe.size.width && (newframe.size.width >= aSize.width))
	{
		scale = aSize.width / newframe.size.width;
		newframe.size.width *= scale;
		newframe.size.height *= scale;
	}
	
	self.frame = newframe;
}

@end
