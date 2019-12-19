//
//  CETCWKWebController.m
//  CETCPartyBuilding
//
//  Created by gao on 17/3/28.
//  Copyright © 2017年 Aaron Yu. All rights reserved.
//

#import "CETCWKWebController.h"
#import <WebKit/WebKit.h>

@interface CETCWKWebController () <WKNavigationDelegate,WKUIDelegate>
{
    WKWebView *wkWebView;
}

@end

@implementation CETCWKWebController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [NSURLProtocol registerClass:[CETCURLProtocal class]];
//    [NSURLProtocol wk_registerScheme:@"https"];
    // Do any additional setup after loading the view.

    wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    wkWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    wkWebView.navigationDelegate = self;
    wkWebView.UIDelegate = self;
    wkWebView.allowsBackForwardNavigationGestures = YES;

    if (@available(iOS 11.0, *)) {
        wkWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }

    NSLog(@"wkwebUrl === %@",self.url);
    
    //清除缓存
    if ([[[UIDevice currentDevice] systemVersion]intValue ] >= 9.0) {
//        NSArray * types =@[WKWebsiteDataTypeMemoryCache,WKWebsiteDataTypeDiskCache,WKWebsiteDataTypeLocalStorage,WKWebsiteDataTypeWebSQLDatabases,WKWebsiteDataTypeOfflineWebApplicationCache]; // 9.0之后才有的
//        NSSet *websiteDataTypes = [NSSet setWithArray:types];

        //使用allWebsiteDataTypes会报错误： could not create "/private/var/mobile/Containers/Data/Application/32E4317B-2C5E-45B3-B95D-C3E81609F234/Library/Caches/___IndexedDB", error Error Domain=NSCocoaErrorDomain Code=513 "您没有将文件“___IndexedDB”存储到文件夹“Caches”中的权限。" UserInfo={NSFilePath=/private/var/mobile/Containers/Data/Application/32E4317B-2C5E-45B3-B95D-C3E81609F234/Library/Caches/___IndexedDB, NSUnderlyingError=0x170458d20 {Error Domain=NSPOSIXErrorDomain Code=1 "Operation not permitted"}}
        
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        //// Date from
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        
        //// Execute
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            
            // Done
        }];
        
    }else{
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSLog(@"%@", cookiesFolderPath);
        NSError *errors;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    }
    
    [self loadWebRequest];
    [self.view addSubview:wkWebView];
    
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.indicatorView.center = CGPointMake(WIDTH / 2, HEIGHT / 2);
    self.indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.view addSubview:self.indicatorView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadWebRequest
{
    [wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self.indicatorView startAnimating];
}

- (void)back
{
    if ([wkWebView canGoBack])
    {
        [wkWebView goBack];
    }
    else
    {
        if ([self.navigationController.topViewController isKindOfClass:[CETCWKWebController class]]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark - WKNavigationDelegate *****
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [self.indicatorView startAnimating];
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [self.indicatorView stopAnimating];
    
    if (self.strTitle)
    {
        self.navigationItem.title = self.strTitle;
    }
    
//    [webView evaluateJavaScript:@"document.title" completionHandler:^(id object, NSError * _Nullable error) {
//        NSLog(@"%@",object);
//        self.navigationItem.title = object;
//    }];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    [self.indicatorView stopAnimating];
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    
}

// 在收到响应后，决定是否跳转 下面这句话一定不能少 一少就报错
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    //获取请求的url路径.
//    NSString *requestString = navigationResponse.response.URL.absoluteString;
//    NSLog(@"requestString:%@",requestString);
//    // 遇到要做出改变的字符串
//    NSString *subStr = @"www.baidu.com";
//    if ([requestString rangeOfString:subStr].location != NSNotFound) {
//        NSLog(@"这个字符串中有subStr");
//        //回调的URL中如果含有百度，就直接返回，也就是关闭了webView界面
//        [self.navigationController  popViewControllerAnimated:YES];
//    }
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 在发送请求之前，决定是否跳转 //下面这句话一定不能少，一少就报错
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSLog(@"load url === ");
    
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    
//    WKFrameInfo *sFrame = navigationAction.sourceFrame;//navigationAction的出处
//    WKFrameInfo *tFrame = navigationAction.targetFrame;//navigationAction的目标
//   只有当  tFrame.mainFrame == NO；时，表明这个 WKNavigationAction 将会新开一个页面。
//   才会调用- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures;

    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"error ==== %@",error);
}

#pragma mark - WKUIDelegate *********
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"alert" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
    NSLog(@"%@", message);
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"confirm" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
    
    NSLog(@"%@", message);
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    
    NSLog(@"%@", prompt);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"textinput" message:@"JS调用输入框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor redColor];
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
}

- (void)dealloc
{
//    [NSURLProtocol unregisterClass:[CETCURLProtocal class]];
//    [NSURLProtocol wk_unregisterScheme:@"https"];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
