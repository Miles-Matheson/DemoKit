//
//  HFAPI.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/7/3.
//

#import "QianYuAPI.h"
#import "QY_PayController.h"
#import "QY_LoginController.h"
#import "QY_AccountController.h"
#import "QY_SuspendController.h"
#import "KeyController.h"

@implementation QianYuAPI

#pragma mark - 开放接口
/** 初始化SDK 并 打开登录页面 */
+ (void)OpenLoginView:(UIViewController *)MainController withCompleted:(GameCallBack)onCompleted;
{
    [[KeyController sharedKeyController] SetMainController:MainController];
    QY_LoginController *loginController = [[QY_LoginController alloc] init];
    [loginController InitAppLicationWithShowView];
    [loginController setLoginCallBack:^(NSDictionary * _Nonnull resDictionary) {
        BOOL bFlag = [[KeyController sharedKeyController] GetSuspendState];
        if (bFlag)
        {
            [QianYuAPI InitSuspendView];
        }
        onCompleted(resDictionary);
    }];
}

/** 登出 */
+ (void)LoginOutEvent
{
    BOOL bLogin = [[KeyController sharedKeyController] GetUserLogin];
    if (bLogin)
    {
        [[KeyController sharedKeyController] LoginOutAccount];
        [[QY_SuspendController sharedSuspendController] DestroySuspendView];
    }
}

/** 打开支付页面 */
+ (void)OpenPayView:(NSDictionary *)params withCompleted:(GameCallBack)onCompleted;
{
    BOOL bLogin = [[KeyController sharedKeyController] GetUserLogin];
    if (bLogin)
    {
        QY_PayController *payController = [[QY_PayController alloc] init];
        [payController InitPayView:params];
        [payController setPayCallBack:^(NSDictionary * _Nonnull resDictionary) {
            onCompleted(resDictionary);
        }];
    }
}

/** 打开账号管理 */
+ (void)OpenAccountView:(NSInteger)nType;
{
    BOOL bLogin = [[KeyController sharedKeyController] GetUserLogin];
    if (bLogin)
    {
        [QianYuAPI HideSuspendView];
        QY_AccountController *accountController = [[QY_AccountController alloc] init];
        [accountController InitAccountView:nType];
        [accountController setSuspendShow:^(BOOL state) {
            if (state)
            {
                [QianYuAPI ShowSuspendView];
            }
            else
            {
                [QianYuAPI LoginOutEvent];
            }
        }];
    }
}

/** 初始化悬浮图标 */
+ (void)InitSuspendView
{
    BOOL bLogin = [[KeyController sharedKeyController] GetUserLogin];
    if (bLogin)
    {
        QY_SuspendController *suspendController = [[QY_SuspendController alloc] init];
        [suspendController InitSuspendView];
        [suspendController setAccountShow:^(BOOL state) {
            if (state)
            {
                [QianYuAPI OpenAccountView:0];
            }
        }];
    }
}

/** 显示悬浮图标 */
+ (void)ShowSuspendView
{
    BOOL bLogin = [[KeyController sharedKeyController] GetUserLogin];
    if (bLogin)
    {
        [[QY_SuspendController sharedSuspendController] ShowSuspendController];
    }
}

/** 隐藏悬浮图标 */
+ (void)HideSuspendView
{
    BOOL bLogin = [[KeyController sharedKeyController] GetUserLogin];
    if (bLogin)
    {
        [[QY_SuspendController sharedSuspendController] HideSuspendController];
    }
}

/** 支付URL */
+ (void)HandleOpenURL:(NSURL *)url
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_HFPaySUccess" object:nil userInfo:@{@"url":url}];
}

/** 上报数据 */
+ (void)ReportGameData:(NSDictionary *)params;
{
    BOOL bLogin = [[KeyController sharedKeyController] GetUserLogin];
    if (bLogin)
    {
        QY_AccountController *accountController = [[QY_AccountController alloc] init];
        [accountController ReportGameData:params];
    }
}

/** 复制到黏贴版 */
+ (void)CopyTextToClipboard:(NSString *)text
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = text;
}


@end
