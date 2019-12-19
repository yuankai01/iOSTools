//
//  DownloadHelper.h
//  CpicPeriodicaliPad
//
//  Created by magicmac on 12-9-27.
//  Copyright (c) 2012年 magicpoint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadHelper : NSObject

// 将文件大小的字符串 转换成 以 M 为单位的double类型数据
+ (double)getFileSizeToMBytesFromString:(NSString *)size;
+ (double)getFileSizeToMBytesFromDouble:(double )size;

//将文件大小转化成M单位或者B单位
+(NSString *)getFileSizeString:(NSString *)size;
//经文件大小转化成不带单位ied数字
+(float)getFileSizeNumber:(NSString *)size;

+(NSString *)getTargetFloderPath;//得到实际文件存储文件夹的路径
+(NSString *)getTempFolderPath;//得到临时文件存储文件夹的路径
+(BOOL)isExistFile:(NSString *)fileName;//检查文件名是否存在

//传入文件总大小和当前大小，得到文件的下载进度
+(double) getProgress:(float)totalSize currentSize:(float)currentSize;

@end
