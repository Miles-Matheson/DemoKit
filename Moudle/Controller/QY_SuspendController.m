//
//  SuspendController.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/24.
//

#import "QY_SuspendController.h"
#import "SuspendView.h"
#import "SuspendLogo.h"

#import "KeyController.h"
#import "QY_CommonController.h"

@interface QY_SuspendController()<SuspendLogoDelegate,SuspendViewDelegate>

@property (nonatomic, strong) SuspendView *SuspendView;
@property (nonatomic, strong) SuspendLogo *SuspendLogo;

@end

@implementation QY_SuspendController

static id _instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return  _instance;
}

+ (instancetype)sharedSuspendController
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return  _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

/**  @初始化SuspendView */
- (void)InitSuspendView
{
    CGFloat nItemH = self.nScreenW >= self.nScreenH? 0.13 * self.nScreenH : 0.13 * self.nScreenW;
    CGFloat nItemW = 3.4 * nItemH;
    CGFloat nItemX = 0;
    CGFloat nItemY = 15;
    if (self.SuspendView == nil)
    {
        UIViewController *unityController = [[KeyController sharedKeyController] GetMainController];
        self.SuspendView = [[SuspendView alloc] initWithFrame:CGRectMake(nItemX, nItemY, nItemW, nItemH)];
        [unityController.view addSubview:self.SuspendView];
        [self.SuspendView setDelegate:self];
    }
    
    if (self.SuspendLogo == nil)
    {
        UIViewController *unityController = [[KeyController sharedKeyController] GetMainController];
        self.SuspendLogo = [[SuspendLogo alloc] initWithFrame:CGRectMake(nItemX, nItemY, nItemH, nItemH)];
        [unityController.view addSubview:self.SuspendLogo];
        [self.SuspendLogo setDelegate:self];
    }
    
    [self InitController];
    [self ShowSuspendController];
    [self.SuspendView HideSuspendView];
    [self.SuspendLogo UpdateSuspendState]; 
}

/**  @销毁SuspendView */
- (void)DestroySuspendView
{
    if (self.SuspendLogo != nil && self.SuspendView != nil)
    {
        [self.SuspendLogo RemoveSuspendState];
        [self.SuspendLogo setDelegate:nil];
        [self.SuspendView setDelegate:nil];
        
        [self.SuspendView DestroyView];
        [self.SuspendLogo DestroyView];
        
        self.SuspendView = nil;
        self.SuspendLogo = nil;
    }
}

/**  @隐藏SuspendView */
- (void)HideSuspendController
{
    if (self.SuspendView != nil && self.SuspendLogo != nil)
    {
        [self.SuspendLogo ViewDidDisappear];
        [self.SuspendView ViewDidDisappear];
    }
}

/**  @显示SuspendView */
- (void)ShowSuspendController
{
    if (self.SuspendLogo != nil)
    {
        [self.SuspendLogo ViewDidAppear:YES];
    }
}

#pragma mark - SuspendLogoDelegate
/**  @代理 隐藏SuspendView */
- (void)HideSuspendViewDelegate
{
    [self.SuspendView HideSuspendView];
}

/**  @代理 更新SuspendView状态 */
- (void)UpdateSuspendViewDelegate:(CGRect)bRect
{
    [self.SuspendView UpdateSuspendState:bRect];
}

#pragma mark - SuspendViewDelegate
/**  @代理 显示账号管理 */
- (void)ShowAccountViewDelegate
{
    if (self.AccountShow)
    {
        self.AccountShow(YES);
    }
}

/**  @代理 隐藏悬浮图标 */
- (void)HideSuspendControllerDelegate
{
    [self HideSuspendController];
    //[self DestroySuspendView];
}


@end
