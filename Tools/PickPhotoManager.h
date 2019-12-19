//
//  PickPhotoManager.h
//  JHD_iOS
//
//  Created by Gao on 2019/1/21.
//  Copyright © 2019 JHD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PickPhotoManager : NSObject

@property (copy, nonatomic) void (^selectImageInfo)(NSDictionary *info);

- (instancetype)initWithController:(UIViewController *)controller;
-(void)pickPhotoWithSourceType:(UIImagePickerControllerSourceType)souseType;

@end

NS_ASSUME_NONNULL_END
