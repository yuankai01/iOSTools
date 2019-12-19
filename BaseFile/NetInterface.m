//
//  NetInterface.m
//  Colourful
//
//  Created by MagicPoint on 13-9-26.
//  Copyright (c) 2013年 MagicPoint. All rights reserved.
//

#import "NetInterface.h"

#define kText_Loading @"加载中..."
#define url_baseURL  [NSURL URLWithString:@""]

@implementation NetInterface

static NetInterface *sharedInterface = nil;
+(NetInterface *)sharedNetInterface
{
    @synchronized(self){
        if (sharedInterface == nil) {
            sharedInterface = [[NetInterface alloc] init];
        }
        
        return sharedInterface;
    }
}

-(id)init
{
    self = [super init];
    if (self) {
//        UserInfoModel *info = [[UserInfoModel alloc] init];
//        self.userInfoModel = info;
    }
    
    return self;
}

//********************************************************
#pragma mark - 检测可用的网络环境 当前是否连入3G或wifi。 连接状态实时通知
/*   使用Reachability:已包含在ASIHttpRequest文件夹内
 将该例程中的 Reachability.h 和 Reachability.m 拷贝到你的工程中,然后将 SystemConfiguration.framework 添加进工程,最后加入头文件#import"Reachability.h"
 */
- (BOOL)isNetWorkUseable {
    // 检查网络状态
    BOOL useable = YES;
    //	NSString *netType = nil;
	Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([r currentReachabilityStatus]) {
		case NotReachable:
			// 没有网络连接
            //			netType = @"没有网络连接";把返回类型改成NSString类型，就可以显示网络状态
            useable = NO;
			break;
		case ReachableViaWWAN:
			// 使用3G网络
            //			netType = @"3G";
            useable = YES;
			break;
		case ReachableViaWiFi:
			// 使用WiFi网络
            //			netType = @"WiFi";
            useable = YES;
			break;
    }
	//DLog(@"netType:%@",netType);
    return useable;
}

// 是否wifi
+ (BOOL) IsEnableWIFI {
    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}

// 是否3G
+ (BOOL) IsEnable3G {
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}

//更新网络状态
-(void)updateNetWorkStatus:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if (status == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"AppName"
                                                        message:@"NotReachable"
                                                       delegate:nil
                                              cancelButtonTitle:@"YES" otherButtonTitles:nil];
        [alert show];
    }
}

//首次启动应用程序监测网络状态,该方法写在UIApplicationDelegate的-(void)applicationDidFinishLaunching:(UIApplication *)application方法中.
-(void)ss
{
    // 监测网络情况
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateNetWorkStatus:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    Reachability * hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [hostReach startNotifier];
}

#pragma mark - // 显示隐藏状态栏网络图标
- (void)showStatusBarNetworkActivity {
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES; // to stop it, set this to NO
}

- (void)hideStatusBarNetworkActivity {
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
}

#pragma mark - // 显示 网络动画
- (void)showHudProgress {
    if (_isShowMBHud == NO) {
        // 为NO，及时改为YES。
        _isShowMBHud = YES;
        //        return;
    }
    
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    
    if (_mbHud == nil) {
        _mbHud = [[MBProgressHUD alloc] initWithView:window];
        _mbHud.removeFromSuperViewOnHide = YES;
        [window addSubview:_mbHud];
        [window bringSubviewToFront:_mbHud];
        _mbHud.delegate = self;
        _mbHud.labelText = kText_Loading;
        [_mbHud show:YES];
        
        //        _mbHudCount = 1;
        //        return;
    }
    // count +1
    _mbHudCount += 1;
    //	[_mbHud showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

- (void)hideHudProgress {
    // count -1;
    _mbHudCount -= 1;
    
    if (_mbHud && _mbHudCount <= 0) {
        [_mbHud removeFromSuperview];
        _mbHud = nil;
        
        _mbHudCount = 0;
    }
    
    if (_isShowMBHud==NO) {
        // 为NO，及时改为YES。
        _isShowMBHud = YES;
    }
}

#pragma mark - 获取应用程序名称和版本号
-(CGFloat)getAppVersionFromLocation
{
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    NSString* versionNum =[infoDict objectForKey:@"CFBundleVersion"];
    NSString*appName =[infoDict objectForKey:@"CFBundleDisplayName"];
    NSString*text =[NSString stringWithFormat:@"%@ %@",appName,versionNum];
    CGFloat locVersion = [versionNum floatValue];
//    DLog(@"version == %@,== locVersion = %f",text,locVersion);
    return locVersion;
}

-(CGFloat)getAppVersionFromWebServer:(NSString *)strUrl
{
#pragma mark -//POST请求
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strUrl]];
    [request setRequestMethod:@"POST"];
    
    request.delegate = self;
    [request setTimeOutSeconds:5];
    
    /*设置超时自动重试最大次数为2*/
    [request setNumberOfTimesToRetryOnTimeout:1];
    
    [request startSynchronous];
    
    //    [self hideHudProgress];
    NSDictionary *dic = [self parserJsonDataToDictionary:request];
    NSDictionary *versionInfo = [dic objectForKey:@"iPhone"];
    NSString *version = [versionInfo objectForKey:@"version"];
    NSString *appUrl = [versionInfo objectForKey:@"url"];
    CGFloat webVersion = [version floatValue];
//    DLog(@"webVersionfloat === %@ == %f = %@",version,webVersion,appUrl);
    return webVersion;
}

// JSON数据并转换为字典类型  解析从服务器返回的JSON数据 添加第三方库文件SBJSON  添加头文件 #import "SBJsonParser.h"
- (NSDictionary *)parserJsonDataToDictionary:(ASIFormDataRequest *)response
{
    NSError *error = response.error;
    NSData *responseData = [response responseData];
    NSString *responseUTF8String = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSDictionary *jsonDic = [jsonParser objectWithString:responseUTF8String error:&error];
    return jsonDic;
}

//字典或其他对象转换为字符串 添加第三方库文件SBJSON 头文件中添加 #import "SBJsonWriter.h"
- (NSString *)jsonStringFromObject:(id)object {
    if (!object || [object isEqual:[NSNull null]]) {
        return nil;
    }
    
    NSError *error = nil;
    SBJsonWriter *json = [[SBJsonWriter alloc] init];
    NSString *items = [json stringWithObject:object error:&error];//SBJson库中方法
    
    if (error) {
        NSLog(@"\n json to String error == %@ ",error.description);
        return nil;
    }
    return items;
}

#pragma mark -// 网络请求
//请求网络接口 POST 请求 添加第三方库文件ASIHttpRequest 头文件中添加  #import "ASIFormDataRequest.h"
- (ASIFormDataRequest *)requestInterfaceID:(NSString *)requestID andRequestDictionary:(NSDictionary *)requestDic
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:requestDic];
    [dictionary setObject:@"1" forKey:@"UILang"];
    //密码加密传送
    NSString *password = [dictionary objectForKey:@"UserPwd"];
    NSString *newPassword = [dictionary objectForKey:@"UserPwdNew"];
    if (password.length != 0 && password.length != 32) {
        NSString *passwordMD5 = [MD5 md5:password];
        [dictionary setObject:passwordMD5 forKey:@"UserPwd"];
    }
    //重置密码 / 更改登录密码
    if (newPassword.length != 0 && newPassword.length != 32 ) {
        NSString *newPasswordMD5 = [MD5 md5:newPassword];
        [dictionary setObject:newPasswordMD5 forKey:@"UserPwdNew"];
    }
    
    ASIFormDataRequest *response = [ASIFormDataRequest requestWithURL:url_baseURL];
    
    //字典转换为字符串,然后以键值对发送POST请求
    NSString *strRequestDic = [self jsonStringFromObject:dictionary];
    [response setPostValue:strRequestDic forKey:@"RequestData"];
    [response setPostValue:requestID forKey:@"RequestID"];
    [response setRequestMethod:@"POST"];
    
    [response startSynchronous];
    
//    DLog(@"requestID = %@,== \n requestData = %@ ,==\n ResponseSring == %@",requestID,dictionary,[response responseString]);

    return response;
}

#pragma mark - 以NSDictionary的格式保存和读取数据:NSArray、NSString、NSData类似
-(void)saveDictionary:(NSDictionary *)dic inDirectory:(NSString *)directory withRequestID:(NSString *)requestID
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [paths objectAtIndex:0];
    NSString *fileName = nil;
    
    //如果目录不为空,就创建目录，并在该目录下创建文件并写入数据，否则直接在document目录下创建文件并写入数据
    if (directory) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *directoryName = [docPath stringByAppendingPathComponent:directory];
        [fileManager createDirectoryAtPath:directoryName withIntermediateDirectories:YES attributes:nil error:nil];
        //在创建的目录下写入数据
        fileName = [directoryName stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",requestID]];
        [dic writeToFile:fileName atomically:YES];
        
    }else
    {
        //直接在document目录下创建文件并写入数据
        fileName = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",requestID]];
        [dic writeToFile:fileName atomically:YES];
    }
}

//读取数据并返回
-(NSDictionary *)readDictionaryFromDirectory:(NSString *)directory withRequestID:(NSString *)requestID
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [paths objectAtIndex:0];
    NSString *fileName = nil;
    NSDictionary *dic = nil;
    
    if (directory) {
        //在创建的目录下读取数据
        NSString *directoryName = [docPath stringByAppendingPathComponent:directory];
        fileName = [directoryName stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",requestID]];
        
//        dic = [NSDictionary dictionaryWithContentsOfFile:fileName];
    }else
    {
        //直接在document目录下读取数据
        fileName = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",requestID]];
    }
    dic = [NSDictionary dictionaryWithContentsOfFile:fileName];
    
    return dic;
}

#pragma mark - 保存和读取NSData数据
-(void)saveData:(NSData *)data  InDirectory:(NSString *)directory withRequestID:(NSString *)requestId
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *fileName = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"data_%@",requestId]];
    
    [data writeToFile:fileName atomically:YES];
    
    [self readDataFromDirectory:nil withRequestID:requestId];
    
}

//读取数据并返回
-(NSData *)readDataFromDirectory:(NSString *)directory withRequestID:(NSString *)requestID
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *fileName = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"data_%@",requestID]];
    
    NSData *data = [NSData dataWithContentsOfFile:fileName];
    return data;
}

#pragma mark - 保存和读取NSString数据
-(void)saveString:(NSString *)string  InDirectory:(NSString *)directory withRequestID:(NSString *)requestId
{
    NSString *fileName = [self getSandBoxPath:requestId];
    
    [string writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

//读取数据并返回
-(NSString *)readNSStringFromDirectory:(NSString *)directory withRequestID:(NSString *)requestID
{
    NSString *fileName = [self getSandBoxPath:requestID];
    
    NSString *string = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    return string;
}

#pragma mark - 获取沙盒目录路径
-(NSString *)getSandBoxPath:(NSString *)file
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *fileName = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"data_%@",file]];
    
    return fileName;
}

@end
