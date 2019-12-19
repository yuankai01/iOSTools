//
//  ImageTextField.h
//  FarbenOffice
//
//  Created by Gao on 2019/12/19.
//  Copyright © 2019 Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTextField : UITextField

@property(nonatomic, strong)NSString *icon;
@property(nonatomic, strong)NSString *highlightIcon;

- (id)initWithFrame:(CGRect) frame iconName:(NSString *)imageName highlightIcon:(NSString *)hImageName withLine:(BOOL)withLine;
- (id)initLineWithFrame:(CGRect)frame iconName:(NSString *)imageName;

@end

