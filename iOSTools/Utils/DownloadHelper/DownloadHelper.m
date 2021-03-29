//
//  DownloadHelper.m
//  CpicPeriodicaliPad
//
//  Created by magicmac on 12-9-27.
//  Copyright (c) 2012年 magicpoint. All rights reserved.
//

#import "DownloadHelper.h"

@implementation DownloadHelper


+ (double)getFileSizeToMBytesFromString:(NSString *)size {
    double sizeD = size.doubleValue;
     return sizeD/1024/1024;
}

+ (double)getFileSizeToMBytesFromDouble:(double )size {
    return size/1024/1024;
}

+(NSString *)getFileSizeString:(NSString *)size
{
    if([size floatValue]>=1024*1024)//大于1M，则转化成M单位的字符串
    {
        return [NSString stringWithFormat:@"%fM",[size floatValue]/1024/1024];
    }
    else if([size floatValue]>=1024&&[size floatValue]<1024*1024) //不到1M,但是超过了1KB，则转化成KB单位
    {
        return [NSString stringWithFormat:@"%fK",[size floatValue]/1024];
    }
    else//剩下的都是小于1K的，则转化成B单位
    {
        return [NSString stringWithFormat:@"%fB",[size floatValue]];
    }
}

+(float)getFileSizeNumber:(NSString *)size
{
    NSInteger indexM=[size rangeOfString:@"M"].location;
    NSInteger indexK=[size rangeOfString:@"K"].location;
    NSInteger indexB=[size rangeOfString:@"B"].location;
    if(indexM<1000)//是M单位的字符串
    {
        return [[size substringToIndex:indexM] floatValue]*1024*1024;
    }
    else if(indexK<1000)//是K单位的字符串
    {
        return [[size substringToIndex:indexK] floatValue]*1024;
    }
    else if(indexB<1000)//是B单位的字符串
    {
        return [[size substringToIndex:indexB] floatValue];
    }
    else//没有任何单位的数字字符串
    {
        return [size floatValue];
    }
}

+(NSString *)getDocumentPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

+(NSString *)getTargetFloderPath
{
    return [self getDocumentPath];
}

+(NSString *)getTempFolderPath
{
    return [[self getDocumentPath] stringByAppendingPathComponent:@"Temp"];
}

+(BOOL)isExistFile:(NSString *)fileName
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:fileName];
}

+(double)getProgress:(float)totalSize currentSize:(float)currentSize
{
    return currentSize/totalSize;
}


@end
