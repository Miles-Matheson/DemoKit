//
//  PayWebView.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/7/11.
//

#import "PayWebView.h"
#import "QY_ResultBase.h"
#import "AiPayWebView.h"

#import <WebKit/WebKit.h>

@interface PayWebView() <AiPayWebViewDelegate>

@property (nonatomic, strong) AiPayWebView *AiPayWebView;
- (IBAction)PayWebBackAction:(id)sender;

@end


@implementation PayWebView

- (id)init{
    self = [super init];
    NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
    self = [[bundle loadNibNamed:@"PayWebView" owner:nil options:nil] lastObject];
    if (self)
    {

    }
    return self;
}

 - (AiPayWebView *)AiPayWebView
 {
     if (!_AiPayWebView)
     {
         //创建WebView对象展示H5网页
         _AiPayWebView = [[AiPayWebView alloc] init];
         _AiPayWebView.scalesPageToFit = YES;
         _AiPayWebView.dataDetectorTypes = YES;
         _AiPayWebView.webViewDelegate = self;
         
         //适配屏幕尺寸
         UIViewAutoresizing autoresizingMask;
         autoresizingMask = UIViewAutoresizingFlexibleWidth;
         autoresizingMask |= UIViewAutoresizingFlexibleHeight;
         //_AiPayWebView.autoresizingMask = autoresizingMask;
     }
     return _AiPayWebView;
 }

- (IBAction)PayWebBackAction:(id)sender {
    [self PaySuccess];
}

- (void)UpdatePayWebView:(NSString *)urlString
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Notification_HFPaySUccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReceivePayNotification:) name:@"Notification_HFPaySUccess" object:nil];

    //创建WebView的请求对象
    //NSLog(@" urlString ========= %@", urlString);
    NSMutableURLRequest *request = nil;
    NSURL *url = [NSURL URLWithString:urlString];
    request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    request.timeoutInterval = 30.0f;
    //[request setValue:@"pdby.qianyugame.com://" forHTTPHeaderField:@"Referer"];
    
    [self addSubview:self.AiPayWebView];
    [self sendSubviewToBack:self.AiPayWebView];
    [self.AiPayWebView setFrame:CGRectMake(0, 0, self.nScreenW, self.nScreenH)];
    [self.AiPayWebView loadRequest:request];
}

//移除webview
- (void)RemovePayWebView
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Notification_HFPaySUccess" object:nil];
    [self.AiPayWebView setWebViewDelegate:nil];
    [self.AiPayWebView removeFromSuperview];
    self.AiPayWebView = nil;
}

//通知回调
- (void)ReceivePayNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    NSString *url = [userInfo[@"url"] absoluteString];
    if ([url hasPrefix:@"pdby://"]) {
        [self PaySuccess];
    }
}

#pragma mark - AiPayWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //在此处截取链接获取支付结果
    NSString *absoluteString = request.URL.absoluteString;
    //NSLog(@" absoluteString ========= %@", absoluteString);
    if ([absoluteString hasPrefix:@"http://payback.return"]) {
        //NSLog(@" ====== 在此处提示支付成功的支付结果 ====== ");
        [self PaySuccess];
        return NO;
    } else if ([absoluteString hasPrefix:@"http://payback.cancel"]) {
        //NSLog(@" ====== 在此处提示支付取消的支付结果 ====== ");
        [self PayFailed];
        return NO;
    } else if ([absoluteString hasPrefix:@"http://payback"]) {
        //NSLog(@" ====== 在此处提示支付失败的支付结果 ====== ");
        [self PayFailed];
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //NSLog(@" ====== webViewDidStartLoad ====== ");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //NSLog(@" ====== webViewDidFinishLoad ====== ");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //NSLog(@" ====== didFailLoadWithError ====== ");
    if(error)
    {
        //NSLog(error);
    }
}

//查询是否支付成功
- (void)PaySuccess
{
    if ([self.delegate respondsToSelector:@selector(PaySuccessDelegate)])
    {
        [self RemovePayWebView];
        [self.delegate PaySuccessDelegate];
    }
}

//支付失败
- (void)PayFailed
{
    if ([self.delegate respondsToSelector:@selector(PayFailedDelegate)])
    {
        [self RemovePayWebView];
        [self.delegate PayFailedDelegate];
    }
}


@end
