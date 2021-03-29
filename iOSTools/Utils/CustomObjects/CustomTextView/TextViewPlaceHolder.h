//
//  TextViewPlaceHolder.h
//  new
//
//  Created by MagicPoint on 13-1-24.
//  Copyright (c) 2013年 MagicPoint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewPlaceHolder : UITextView

@property(nonatomic, retain)NSString*placeholder;
/**
The color of the placeholder.

The default is `[UIColor lightGrayColor]`.
*/
@property(nonatomic, retain)UIColor*placeholderColor;

@end
