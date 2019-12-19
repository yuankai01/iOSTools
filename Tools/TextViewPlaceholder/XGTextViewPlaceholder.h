//
//  XGTextViewPlaceholder.h
//  XGVaccine
//
//  Created by Aaron Yu on 15/6/3.
//  Copyright (c) 2015年 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XGTextViewPlaceholder : UITextView
{
    NSString *placeholder;
    UIColor *placeholderColor;
@private
    UILabel *placeHolderLabel;
}

@property (nonatomic, retain) UILabel *placeHolderLabel;
@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

+ (float)heightForTextView: (UITextView *)textView WithText: (NSString *) strText;

@end
