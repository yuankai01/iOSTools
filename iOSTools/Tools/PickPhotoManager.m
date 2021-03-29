//
//  PickPhotoManager.m
//  JHD_iOS
//
//  Created by Gao on 2019/1/21.
//  Copyright © 2019 JHD. All rights reserved.
//

#import "PickPhotoManager.h"

#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

@interface PickPhotoManager () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIViewController *presentCtrl;
}

@end

@implementation PickPhotoManager

- (instancetype)initWithController:(UIViewController *)controller
{
    self = [super init];
    if (self) {
        presentCtrl = controller;
    }
    
    return self;
}

-(void)pickPhotoWithSourceType:(UIImagePickerControllerSourceType)souseType
{
    if(![UIImagePickerController isSourceTypeAvailable:souseType])
    {
        return;
    }

    if (souseType == UIImagePickerControllerSourceTypeCamera)
    {
        [self takeCamera];
    }
    else
    {
        [self takePhoto];
    }
}

//拍照
- (void)takeCamera
{
    //相机权限
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)])
    {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (authStatus)
        {
            case AVAuthorizationStatusRestricted:
            case AVAuthorizationStatusDenied:
            {
                [self openSystemSet];
                break;
            }
              
            case AVAuthorizationStatusNotDetermined:
            case AVAuthorizationStatusAuthorized:
            {
                [self allowPickPhotoWithSourceType:UIImagePickerControllerSourceTypeCamera];
                break;
            }
            default:
                break;
        }
    }
    else
    {
        [self allowPickPhotoWithSourceType:UIImagePickerControllerSourceTypeCamera];
    }
}

//手机相册
- (void)takePhoto
{
    //相册权限
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    
    switch (authStatus) {
        case PHAuthorizationStatusRestricted:
        case PHAuthorizationStatusDenied:
            [self openSystemSet];
            break;
        case PHAuthorizationStatusNotDetermined:
//        {
//            // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
//            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
//                if (granted) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [self takePhoto];
//                    });
//                }
//            }];
//        }
//            break;
        case PHAuthorizationStatusAuthorized:
            [self allowPickPhotoWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            break;
        default:
            break;
    }
}

//系统设置：打开相机、相册
- (void)openSystemSet
{
    // 无相机权限 做一个友好的提示
    [AlertSheetController showAlertTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" buttonTitles:@[@"设置"] viewController:presentCtrl selectBlock:^(NSInteger selectIndex, NSString *title) {
        // 去设置界面，开启相机访问权限
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:nil];
    }];
}

- (void)allowPickPhotoWithSourceType:(UIImagePickerControllerSourceType)souseType
{
    NSString *type = @"image";

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.navigationBar.tintColor = [UIColor blackColor];
    picker.delegate = self;
    picker.sourceType = souseType;
    picker.allowsEditing = NO;
    picker.navigationBar.translucent = NO;

    NSArray *sourceTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
    for (NSString *str in sourceTypes)
    {
        if ([str hasSuffix:type])
        {
            [picker setMediaTypes:[NSArray arrayWithObjects:str, nil]];
            break;
        }
    }
    
    [presentCtrl presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *strType = [info valueForKey:UIImagePickerControllerMediaType];

    if (self.selectImageInfo)
    {
        [picker dismissViewControllerAnimated:YES completion:^{
            if ([strType hasSuffix:@"image"])
            {
                if (self.selectImageInfo)
                {
                    self.selectImageInfo(info);
                }
            }
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
