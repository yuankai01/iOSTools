//
//  CommonMethod.m
//  Colourful
//
//  Created by MagicPoint on 13-9-4.
//  Copyright (c) 2013年 MagicPoint. All rights reserved.
//

#import "CommonMethod.h"

@implementation CommonMethod

#pragma mark - 自定义button
- (UIButton *)buttonWithTitle:(NSString *)title selector:(SEL)selector frame:(CGRect)frame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    button.frame = frame;
    button.backgroundColor = [UIColor clearColor];
    return button;
}

#pragma mark - 拉伸复制一像素图像 横向复制
+ (UIImage *)stretchableImage:(UIImage *)image withLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight
{
    UIImage* newImage = [image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:topCapHeight];
    
    return newImage;
}

+(UIButton *)initCommonButton:(CGRect)frame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    UIImage *image = defineImage(kImageName_RegistLogIn_commonBtn);
    image = [self stretchableImage:image withLeftCapWidth:image.size.width / 2 topCapHeight:0];
    UIImage *imageDown = [self stretchableImage:defineImage(kImageName_RegistLogIn_commonBtn_down) withLeftCapWidth:image.size.width / 2 topCapHeight:0];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:imageDown forState:UIControlStateHighlighted];
    
    return button;
}

+(UIButton *) makeDetailDisclosureButton
{
    UIImage *image = defineImage(kImageName_Common_arrow);
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    button.backgroundColor = [UIColor clearColor];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:defineImage(kImageName_Common_arrowDown) forState:UIControlStateHighlighted];
    
    return button;
}

//只针对 image 和 title 横向 位置 左右对换的 button (title在左,image 在右) 做调整,清除背景颜色
+(UIButton *)customButtonFrame:(CGRect)frame WithImage:(UIImage *)image andDownImge:(UIImage *)downImage withTitle:(NSString *)title andSpacing:(CGFloat)space
{
    //获取图像的宽度
    CGFloat imageWidth = CGImageGetWidth(image.CGImage);
    
    //获取title的宽度
    UIFont *font = defineCustomFontSize(18);
    CGSize size = [title sizeWithFont:font];
    CGFloat titleWidth = size.width;
    
    //button的最小宽度
    CGFloat buttonWidth = imageWidth + titleWidth;
    //添加button背景图片
//    UIImage *rightBtnImg = defineImage(kImageName_NavButton_rightCommon);
//    rightBtnImg = [self stretchableImage:rightBtnImg withLeftCapWidth:rightBtnImg.size.width / 2 topCapHeight:0];
//    UIImage *rightBtnImgDown = [self stretchableImage:defineImage(kImageName_NavButton_rightCommon_down) withLeftCapWidth:rightBtnImg.size.width / 2 topCapHeight:0];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(frame.origin.x,frame.origin.y, buttonWidth, frame.size.height);
    rightBtn.backgroundColor = [UIColor clearColor];
//    [rightBtn setBackgroundImage:rightBtnImg forState:UIControlStateNormal];
//    [rightBtn setBackgroundImage:rightBtnImgDown forState:UIControlStateHighlighted];
    rightBtn.titleLabel.font = font;
    
    //给button添加图像和title
    [rightBtn setImage:image forState:UIControlStateNormal];
    [rightBtn setImage:downImage forState:UIControlStateHighlighted];
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [rightBtn setTitleColor:RGB(255, 168, 0) forState:UIControlStateNormal];
    
//    rightBtn.titleLabel.backgroundColor = [UIColor greenColor];
//    rightBtn.imageView.backgroundColor = [UIColor redColor];
//    rightBtn.backgroundColor = [UIColor grayColor];
    
    //调整图像和title的位置
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, titleWidth + space - 8, 0, space + 8)];
    [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageWidth - space, 0, 0)];
    
    return rightBtn;
}

//针对button 图像在左,字体在右的方法,正常显示
+(UIButton *)customButtonWithLeftImage:(UIImage *)image andRightTitle:(NSString *)title 
{
    //获取图像的宽度
    CGFloat imageWidth = CGImageGetWidth(image.CGImage);
    
    //获取title的宽度
    UIFont *font = defineCustomFontSize(16);
    CGSize size = [title sizeWithFont:font];
    CGFloat titleWidth = size.width;
    
    //button的最小宽度
    CGFloat buttonWidth = imageWidth + titleWidth;
    UIImage *rightBtnImg = defineImage(kImageName_NavButton_rightCommon);
    rightBtnImg = [self stretchableImage:rightBtnImg withLeftCapWidth:rightBtnImg.size.width / 2 topCapHeight:0];
    UIImage *rightBtnImgDown = [self stretchableImage:defineImage(kImageName_NavButton_rightCommon_down) withLeftCapWidth:rightBtnImg.size.width / 2 topCapHeight:0];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, buttonWidth + 2, rightBtnImg.size.height);
    [rightBtn setBackgroundImage:rightBtnImg forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:rightBtnImgDown forState:UIControlStateHighlighted];
    rightBtn.titleLabel.font = font;
    
    //给button添加图像和title
    [rightBtn setImage:image forState:UIControlStateNormal];
    [rightBtn setTitle:title forState:UIControlStateNormal];
    
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -2, 0, 2)];
    [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -2, 0, 2)];
    
    return rightBtn;
}

#pragma mark - 根据label获取label的高度
+(CGFloat)getLabelHeight:(UILabel *)label
{
    //获取高度，获取字符串在指定的size内(宽度超过label的宽度则换行)所需的实际高度.
    CGSize sizeHeight = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    
    return sizeHeight.height;
}

#pragma mark - getEgoImgeViewURLWithStr
+(NSURL *)getEgoImgeViewURLWithStr:(NSString *)str
{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",url_subBaseURL,str];
    NSURL *url = [NSURL URLWithString:strUrl];
    
    return url;
}

#pragma mark - 将时间戳转换为日期,并以字符串格式返回
+(NSString *)dateFromTimeStamp:(NSString *)timeStamp withType:(NSString *)type
{
    NSString *strDate = nil;
    if (timeStamp != (id)[NSNull null] && timeStamp.length != 0 && ![timeStamp isEqualToString:@"null"]) {
        //判断传过来的是否是时间戳还是标准时间格式,如果是时间戳,则转换时间戳,不是则直接赋值
        NSRange range1 = [timeStamp rangeOfString:@"-"];
        NSRange range2 = [timeStamp rangeOfString:@":"];
        NSRange range3 = [timeStamp rangeOfString:@"/"];
        NSRange range4 = [timeStamp rangeOfString:@"年"];
        NSRange range5 = [timeStamp rangeOfString:@"月"];
        NSRange range6 = [timeStamp rangeOfString:@"日"];
        NSDate *date = nil;
        if (range1.location == NSNotFound && range2.location == NSNotFound && range3.location == NSNotFound && range4.location == NSNotFound && range5.location == NSNotFound && range6.location == NSNotFound) {
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            if ([type isEqualToString:@"/"]) {
                [formatter setDateFormat:@"yyyy/MM/dd"];
            }else [formatter setDateFormat:@"yyyy-MM-dd"]; //设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
            
            date = [NSDate dateWithTimeIntervalSince1970:[timeStamp intValue]];//时间戳转换成日期格式关键步
            strDate = [formatter stringFromDate:date];//日期转换成字符串
        }else strDate = timeStamp;
    }
    
    return strDate;
}

#pragma mark - 在字符串A中,获取子字符串B的最后一次出现的位置
+(NSRange)getSubStringLocation:(NSString *)findString inString:(NSString *)string
{
    //要获取的信息:第几个字符串,哪个位置,总共包含几个这样的字符串 == 字典元素个数
//    findString = @"sdsdf";
//    string = @"/sdsdsdsgl/sdgflsf/sdlf/s/";
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSInteger i = 0;i < string.length - findString.length + 1;i++) {
        
        NSString *tempStr = [string substringWithRange:NSMakeRange(i, findString.length)];
        if ([findString isEqualToString:tempStr]) {
            
            NSRange rangeTemp = NSMakeRange(i, findString.length);
            NSValue *value = [NSValue valueWithRange:rangeTemp];
            [array addObject:value];
        }
        
    }
    //获取最后一个子字符串的位置.
    NSValue *value = [array lastObject];
    NSRange range = [value rangeValue];
    
    NSLog(@"range == %@ == nmumber=%d",NSStringFromRange(range),array.count);
    return range;
}

#pragma mark - 沙盒目录
-(void)homeDirectory
{
#pragma mark - 5个常用的沙盒目录
    NSString *homeDirectory = NSHomeDirectory();
    NSLog(@"home == %@\n\n",homeDirectory);
    
    NSArray *docArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPaths = [docArray objectAtIndex:0];
    NSLog(@"documentPaths = %@\n\n",documentPaths);
    
    NSArray *libraryArray = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryPaths = [libraryArray objectAtIndex:0];
    NSLog(@"libraryPaths = %@\n\n",libraryPaths);
    
    NSArray *cacheArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePaths = [cacheArray objectAtIndex:0];
    NSLog(@"cachePaths == %@ \n\n",cachePaths);
    
    NSString *tmpPaths = NSTemporaryDirectory();
    NSLog(@"tmpPaths = %@\n\n",tmpPaths);
    
#pragma mark - 写入文件:数组、字符串
    if (!documentPaths) {
        NSLog(@"Documents 目录未找到!");
    }
    NSArray *array = [[NSArray alloc] initWithObjects:@"内容",@"content", nil];
    NSString *fileDocPaths = [documentPaths stringByAppendingPathComponent:@"content22.text"];//关键步骤，不然生不出文件。后缀名：text/txt/doc/png/jpg
    
    //写入文件的同时并创建了文件，不会自动删除
    [array writeToFile:fileDocPaths atomically:YES];
    
#pragma mark - 读取文件
    NSArray *contentArray = [[NSArray alloc] initWithContentsOfFile:fileDocPaths];
    NSLog(@"读取文件contentArray = %@\n\n",contentArray);
    
#pragma mark - 创建文件目录
    NSFileManager *docFileManager = [NSFileManager defaultManager];
    NSString *docDirectory = [documentPaths stringByAppendingPathComponent:@"file"];//关键步骤，不然生不出文件。
    //创建目录，不会自动删除
    [docFileManager createDirectoryAtPath:docDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    
    //在目录下创建文件
    NSString *filePath1 = [docDirectory stringByAppendingPathComponent:@"file11.txt"];//关键步骤，不然生不出文件。
    
    NSString *contentStr = @"写入内容，write String";
    [docFileManager createFileAtPath:filePath1 contents:[contentStr dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    //上面的方法和下面方法都可以创建文件。
    //    [contentStr writeToFile:filePath1 atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
#pragma mark - 获取目录列表
    NSArray *fileList1 = [docFileManager subpathsAtPath:docDirectory];
    NSLog(@"fileList1 = %@\n\n",fileList1);
    
    NSArray *fileList2 = [docFileManager subpathsOfDirectoryAtPath:docDirectory error:nil];
    NSLog(@"fileList2 = %@\n\n",fileList2);
    
#pragma mark - 更改到待操作的目录下,不用写全路径了
    [docFileManager changeCurrentDirectoryPath:documentPaths];
    NSString *changeFileNamue = @"change221.text";
    NSArray *changeArray = [[NSArray alloc] initWithObjects:@"hello world",@"hello world1", @"hello world2",nil];
    //    [docFileManager createFileAtPath:changeFileNamue contents:changeArray attributes:nil];
    //    [docFileManager createFileAtPath:changeFileNamue contents:[NSKeyedArchiver archivedDataWithRootObject:changeArray] attributes:nil];//文件损坏
    [changeArray writeToFile:changeFileNamue atomically:YES];
    
#pragma mark - 删除指定的单个文件或目录,只要保证path是对应的文件或目录路径就可以了。
    //    [docFileManager removeItemAtPath:documentPaths error:nil];
    //    //stackoverflow 删除目录下的所有文件
    //    NSFileManager* fm = [[NSFileManager alloc] init];
    //    NSDirectoryEnumerator* en = [fm enumeratorAtPath:docDirectory];
    //    NSError* err = nil;
    //    BOOL res;
    //    NSString* file;
    //    while (file = [en nextObject]) {
    //        res = [fm removeItemAtPath:[docDirectory stringByAppendingPathComponent:file] error:&err];
    //        if (!res && err) {
    //            NSLog(@"oops: %@", err);
    //        }
    //    }
    
    [self writeMutableData];
}

#pragma mark - 混合数据的读写 用NSMutableData创建混合数据，然后写到文件里。并按数据的类型把数据读出来.
-(void)writeMutableData
{
    NSString * fileName = @"testFileNSFileManager.txt";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //获取文件路径
    NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
    //待写入的数据
    NSString *temp = @"nihao hello 是多少";//如果是中文，有误，因为[temp length]算长度是，把中文算成一位了，出来的结果有误。
    int dataInt = 1234;
    float dataFloat = 3.14f;
    //创建数据缓冲
    NSMutableData *writer = [[NSMutableData alloc] init];
    //将字符串添加到缓冲中
    [writer appendData:[temp dataUsingEncoding:NSUTF8StringEncoding]];
    //将其他数据添加到缓冲中
    [writer appendBytes:&dataInt length:sizeof(dataInt)];
    [writer appendBytes:&dataFloat length:sizeof(dataFloat)];
    //将缓冲的数据写入到文件中
    [writer writeToFile:path atomically:YES];
    
    [self readMutableData:path withStr:temp];
}

-(void)readMutableData:(NSString *)path withStr:(NSString *)temp
{
    //读取数据：
    int intData;
    float floatData = 0.0;
    NSString *stringData;
    
    NSData *reader = [NSData dataWithContentsOfFile:path];
    
    stringData = [[NSString alloc] initWithData:[reader subdataWithRange:NSMakeRange(0, [temp length])] encoding:NSUTF8StringEncoding];
    
    [reader getBytes:&intData range:NSMakeRange([temp length], sizeof(intData))];
    
    [reader getBytes:&floatData range:NSMakeRange([temp length] + sizeof(intData), sizeof(floatData))];
    
    NSLog(@"stringData:%@ intData:%d floatData:%f", stringData, intData, floatData);
    
}
#pragma mark - NSBundle.路径对应于生成应用程序文件夹内的.app文件，另外三个分别是Documents/Library/tmp文件夹
-(void)readBundle
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"Default" ofType:@"png"];
    NSLog(@"bundle = %@,\n\n path = %@\n\n",bundle.resourcePath,path);
    
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    NSLog(@"image = %@\n\n",image);
}

#pragma mark - NSUserDefaults,生成的文件在Library/Preferences文件夹内，自动命名规则是：CompanyIdentifier.ProductName.plist,即:公司名.工程名.plist,和Bundle ID是一样的,不过Bundle ID没有后缀名 .plist
-(void)saveDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"word" forKey:@"key"];
    [defaults setObject:@"word2" forKey:@"key2"];
    
    [self readDefaults];
}

-(void)readDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"defaults = %@,defaults = %@\n\n",[defaults stringForKey:@"key"],defaults);
}

#pragma mark - 创建一个图形上下文形象
+(UIImage *)imageWithImageSimple: (UIImage *)image scaledToSize:(CGSize)newSize
{
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

@end
