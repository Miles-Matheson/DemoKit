//
//  LoginViewController.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/13.
//

#import "QY_LoginController.h"
#import "LoginContainer.h"
#import "LoginView.h"
#import "FoundView.h"
#import "RegistView.h"
#import "QuickRegistView.h"
#import "SaveToPhotoAlbum.h"
#import "BaseMaskView.h"
#import "LoginLoadView.h"
#import "AuthenticationView.h"

#import "QY_ApplicationModel.h"
#import "QY_AuthenticationModel.h"
#import "QY_LoginModel.h"
#import "KeyController.h"
#import "QY_CommonController.h"

#import <Photos/Photos.h>
#import <OneLoginSDK/OneLoginSDK.h>

#define CHANGE_TIME     0.5     //切换账号事件

@interface QY_LoginController ()<LoginViewDelegate,FoundViewDelegate,RegistViewDelegate,QuickRegistViewDelegate,SaveToPhotoAlbumDelegate,OneLoginDelegate,LoginLoadViewDelegate,AuthenticationViewDelegate>

@property (nonatomic, strong) BaseMaskView *BaseMaskView;
@property (nonatomic, strong) LoginContainer *LoginContainer;
@property (nonatomic, strong) LoginView *LoginView;
@property (nonatomic, strong) FoundView *FoundView;
@property (nonatomic, strong) RegistView *RegistView;
@property (nonatomic, strong) QuickRegistView *QuickRegistView;
@property (nonatomic, strong) SaveToPhotoAlbum *SaveToPhotoAlbum;
@property (nonatomic, strong) LoginLoadView *LoginLoadView;
@property (nonatomic, strong) AuthenticationView *AuthenticationView;
@property (nonatomic, strong) NSNotification *Notification;
@property (nonatomic, strong) NSDictionary *UserInfo;

@property (nonatomic, assign) BOOL bChanging;
@property (nonatomic, assign) BOOL bLoginLoad;
@property (nonatomic, assign) BOOL bInit;
@property (nonatomic, assign) BOOL bFirst;
@property (nonatomic, assign) BOOL playerStatus;    //用户的实名认证状态
@property (nonatomic, assign) BOOL skipCertification;   //是否可以跳过实名认证
@property (nonatomic, assign) BOOL certification;   //是否开启实名认证
@property (nonatomic, assign) BOOL kickOutSwitch;   //额外参数

@end

@implementation QY_LoginController

static id _instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return  _instance;
}

+ (instancetype)sharedLoginController
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

#pragma mark - 懒加载
- (BaseMaskView *)BaseMaskView
{
    if (!_BaseMaskView)
    {
        _BaseMaskView = [[BaseMaskView alloc] init];
        [_BaseMaskView setBackgroundColor:[UIColor clearColor]];
        [_BaseMaskView setFrame:CGRectMake(0, 0, self.nScreenW, self.nScreenH)];
    }
    return _BaseMaskView;
}

- (LoginContainer *)LoginContainer
{
    if (!_LoginContainer)
    {
        CGFloat nItemR = self.nScreenW >= self.nScreenH? 0.9 * self.nScreenH : 0.9 * self.nScreenW;
        nItemR = nItemR > 400 ? 400 : nItemR;
        _LoginContainer = [[LoginContainer alloc] init];
        [_LoginContainer setFrame:CGRectMake(0, 0, nItemR, nItemR)];
        [_LoginContainer setCenter:CGPointMake(self.nScreenW/2.0, self.nScreenH/2.0)];
    }
    return _LoginContainer;
}

- (LoginView *)LoginView
{
    if (!_LoginView)
    {
        _LoginView = [[LoginView alloc] init];
        [_LoginContainer insertSubview:_LoginView atIndex:1];
        CGSize SuperSize = _LoginView.superview.frame.size;
        [_LoginView setFrame:CGRectMake(0, 0, SuperSize.width, SuperSize.height)];
        [_LoginView setDelegate:self];
    }
    return _LoginView;
}

- (FoundView *)FoundView
{
    if (!_FoundView)
    {
        _FoundView = [[FoundView alloc] init];
        [_LoginContainer insertSubview:_FoundView atIndex:1];
        CGSize SuperSize = _FoundView.superview.frame.size;
        [_FoundView setFrame:CGRectMake(0, 0, SuperSize.width, SuperSize.height)];
        [_FoundView setDelegate:self];
    }
    return _FoundView;
}

- (RegistView *)RegistView
{
    if (!_RegistView)
    {
        _RegistView = [[RegistView alloc] init];
        [_LoginContainer insertSubview:_RegistView atIndex:1];
        CGSize SuperSize = _RegistView.superview.frame.size;
        [_RegistView setFrame:CGRectMake(0, 0, SuperSize.width, SuperSize.height)];
        [_RegistView setDelegate:self];
    }
    return _RegistView;
}

- (QuickRegistView *)QuickRegistView
{
    if (!_QuickRegistView)
    {
        _QuickRegistView = [[QuickRegistView alloc] init];
        [_LoginContainer insertSubview:_QuickRegistView atIndex:1];
        CGSize SuperSize = _QuickRegistView.superview.frame.size;
        [_QuickRegistView setFrame:CGRectMake(0, 0, SuperSize.width, SuperSize.height)];
        [_QuickRegistView setDelegate:self];
    }
    return _QuickRegistView;
}

- (SaveToPhotoAlbum *)SaveToPhotoAlbum
{
    if (!_SaveToPhotoAlbum)
    {
        _SaveToPhotoAlbum = [[SaveToPhotoAlbum alloc] init];
        [_LoginContainer insertSubview:_SaveToPhotoAlbum atIndex:1];
        CGSize SuperSize = _SaveToPhotoAlbum.superview.frame.size;
        [_SaveToPhotoAlbum setFrame:CGRectMake(0, 0, SuperSize.width, SuperSize.height)];
        [_SaveToPhotoAlbum setDelegate:self];
    }
    return _SaveToPhotoAlbum;
}

- (LoginLoadView *)LoginLoadView
{
    if (!_LoginLoadView)
    {
        _LoginLoadView = [[LoginLoadView alloc] init];
        [_LoginContainer insertSubview:_LoginLoadView atIndex:2];
        CGSize SuperSize = _LoginLoadView.superview.frame.size;
        [_LoginLoadView setFrame:CGRectMake(0.2*SuperSize.width, 0.275*SuperSize.height, 0.6*SuperSize.width, 0.5*SuperSize.height)];
        [_LoginLoadView setDelegate:self];
    }
    return _LoginLoadView;
}

- (AuthenticationView *)AuthenticationView
{
    if (!_AuthenticationView)
    {
        _AuthenticationView = [[AuthenticationView alloc] init];
        [_LoginContainer insertSubview:_AuthenticationView atIndex:1];
        CGSize SuperSize = _AuthenticationView.superview.frame.size;
        [_AuthenticationView setFrame:CGRectMake(0, 0, SuperSize.width, SuperSize.height)];
        [_AuthenticationView setDelegate:self];
    }
    return _AuthenticationView;
}


/**  @登登录容器  */
/**  初始化
 *   登录
 *   注册
 *   快速注册
 *   找回密码
 */
- (void)InitAppLicationWithShowView
{
    [self InitController];
    //第一次登录
    if (!self.bInit)
    {
        self.bInit = YES;
        NSString *ologinKey = [[KeyController sharedKeyController] GetOneLoginKey];
        [OneLogin registerWithAppID:ologinKey];
        [OneLogin setDelegate:self];
        
        QY_ApplicationModel *vm = [[QY_ApplicationModel alloc] init];
        vm.appId = [[KeyController sharedKeyController] GetAppId];
        vm.requestTs = [[KeyController sharedKeyController] GetNowTimetamp];
        vm.noLoad = YES;
        __weak typeof(self) weakSelf = self;
        [vm doAppLicationCompleted:^(QY_ResultBase * _Nonnull result) {
            if (result.success)
            {
                NSDictionary *valueDict = result.result;
                [[KeyController sharedKeyController] SetAppLicationInit:valueDict];
                weakSelf.bFirst = [[valueDict objectForKey:@"firstLogin"] boolValue];
                [weakSelf LoginChoose];
            }
            else
            {
                [[QY_CommonController sharedComController] showErrorWithStatus:result.msg];
            }
        }];
    }
    else
    {
        [self LoginChoose];
    }
}

//登录 一键登录 or 普通登录
- (void)LoginChoose
{
    NSArray *userList = [[KeyController sharedKeyController] GetUserList];
    NSDictionary *myInfo = [[KeyController sharedKeyController] GetUserInfo];
    //当前没有数据，且下拉列表没数据，则需要一键登录
    if (!myInfo && [userList count] == 0)
    {
        [self SetPrefetchPhone];
    }
    else
    {
        [self InitLoginView];
    }
}


- (void)SetPrefetchPhone
{
    __weak typeof(self) weakSelf = self;
    [[QY_CommonController sharedComController] showWithStatus:@""];
    [OneLogin preGetTokenWithCompletion:^(NSDictionary * _Nonnull sender) {
        [[QY_CommonController sharedComController] dismiss];
        NSNumber *status = [sender objectForKey:@"status"];
        if (status && [@(200) isEqualToNumber:status]) {
            [weakSelf GetTokenSuccess];
            //NSLog(@"[预取号成功] === \n\n%@\n\n", sender);
        } else {
            [weakSelf InitLoginView];
            //NSLog(@"[预取号失败] === \n\n%@\n\n", sender);
        }
    }];
}

- (void)GetTokenSuccess
{
    __weak typeof(self) weakSelf = self;
    UIViewController *unityController = [[KeyController sharedKeyController] GetMainController];
    [OneLogin requestTokenWithViewController:unityController viewModel:NULL completion:^(NSDictionary * _Nullable result) {
        if (result.count > 0 && result[@"status"] && 200 == [result[@"status"] integerValue]) {
            //NSString *appID = result[@"appID"];
            NSString *token = result[@"token"];
            NSString *processID = result[@"processID"];
            [[KeyController sharedKeyController] SetLoginName:processID];
            [weakSelf RequireLoginByProcessID:processID withToken:token];
        }
        else
        {
            NSString *msg = @"";
            NSString *errCode   = [result objectForKey:@"errorCode"];
            if ([@"-20302" isEqualToString:errCode] || [@"-20303" isEqualToString:errCode])
            {
                return;
            }
            else if ([@"-20202" isEqualToString:errCode])
            {
                msg = @"检测到未开启蜂窝网络";
            }
            else if ([@"-20203" isEqualToString:errCode])
            {
                msg = @"不支持的运营商类型";
            }
            else
            {
                msg = @"获取数据失败，请稍后再试";
            }
            [[QY_CommonController sharedComController] showErrorWithStatus:msg];
            [OneLogin dismissAuthViewController:nil];
        }
    }];
}

//一键登录 代理 切换帐号
- (void)userDidSwitchAccount
{
    [self InitLoginView];
    [OneLogin dismissAuthViewController:nil];
}

//一键登录 代理 返回
- (void)userDidDismissAuthViewController
{
    [self InitLoginView];
    [OneLogin dismissAuthViewController:nil];
}


/**  @一键登录 -- processID token */
- (void)RequireLoginByProcessID:(NSString *)processID withToken:(NSString *)token
{
    QY_LoginModel *vm = [[QY_LoginModel alloc] init];
    vm.processID = processID;
    vm.token = token;
    vm.appId = [[KeyController sharedKeyController] GetAppId];
    vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
    vm.noLoad = YES;
    __weak typeof(self) weakSelf = self;
    [vm doOneLoginCompleted:^(QY_ResultBase * _Nonnull result) {
        if (result.success)
        {
            [[KeyController sharedKeyController] SetLoginName:processID];
            NSDictionary *valueDict = result.result;
            [[KeyController sharedKeyController] UpdateUserInfo:valueDict];
            [[QY_CommonController sharedComController] showSuccessWithStatus:@"登录成功"];
            weakSelf.bFirst = NO;
            [weakSelf LoginSuccess:valueDict];
            [OneLogin dismissAuthViewController:nil];
        }
        else
        {
            [[QY_CommonController sharedComController] showErrorWithStatus:result.msg];
        }
    }];
}


- (void)InitLoginView
{
    UIViewController *unityController = [[KeyController sharedKeyController] GetMainController];
    [unityController.view addSubview:self.BaseMaskView];
    [self.BaseMaskView setCenter:unityController.view.center];
    [self.BaseMaskView addSubview:self.LoginContainer];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillChangeFrameNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    BOOL bAutoLogin = [[KeyController sharedKeyController] GetAutoLogin];
    NSDictionary *myInfo = [[KeyController sharedKeyController] GetUserInfo];
    //一键快速注册
    if(!bAutoLogin && !myInfo && self.bFirst)
    {
        [self BackQuickRegistDelegate];
        [self OneQuickRegistShow:YES];
    }
    //登录页面
    else
    {
        [self BackLoginDelegate];
        [self OneQuickRegistShow:NO];
    }
}


/**  @移除loginview */
- (void)RemoveLoginView
{
    [self.LoginView setDelegate:nil];
    [self.FoundView setDelegate:nil];
    [self.RegistView setDelegate:nil];
    [self.QuickRegistView setDelegate:nil];
    [self.SaveToPhotoAlbum setDelegate:nil];
    [self.LoginLoadView setDelegate:nil];
    [self.AuthenticationView setDelegate:nil];
    
    [self.LoginView DestroyView];
    [self.FoundView DestroyView];
    [self.RegistView DestroyView];
    [self.QuickRegistView DestroyView];
    [self.LoginContainer DestroyView];
    [self.BaseMaskView DestroyView];
    [self.SaveToPhotoAlbum DestroyView];
    [self.LoginLoadView DestroyView];
    [self.AuthenticationView DestroyView];
    
    self.LoginView = nil;
    self.FoundView = nil;
    self.RegistView = nil;
    self.QuickRegistView = nil;
    self.LoginContainer = nil;
    self.BaseMaskView = nil;
    self.SaveToPhotoAlbum = nil;
    self.LoginLoadView = nil;
    self.AuthenticationView = nil;
    
    self.UserInfo = nil;
    self.Notification = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillChangeFrameNotification
                                                  object:nil];
}

/**  @登录成功进入游戏 */
- (void)EnterGameSuccess
{
    NSDictionary *result = self.UserInfo;
    if (self.LoginCallBack)
    {
        NSString *appId = [[KeyController sharedKeyController] GetAppId];
        NSMutableDictionary *resultMutDict = [NSMutableDictionary dictionary];
        [resultMutDict setValue:appId forKey:@"appId"];
        [resultMutDict setValue:result[@"mgMemId"] forKey:@"uid"];
        [resultMutDict setValue:result[@"token"] forKey:@"token"];
        [resultMutDict setValue:result[@"userName"] forKey:@"userName"];
        self.LoginCallBack(resultMutDict);
    }
    [self RemoveLoginView];
}

/**  @登录成功LoginSuccess */
- (void)LoginSuccess:(NSDictionary *)result
{
    __weak typeof(self) weakSelf = self;
    weakSelf.UserInfo = result;
    weakSelf.playerStatus = [result[@"playerStatus"] boolValue];
    weakSelf.skipCertification = [result[@"skipCertification"] boolValue];
    weakSelf.certification = [result[@"certification"] boolValue];
    weakSelf.kickOutSwitch = [result[@"kickOutSwitch"] boolValue];
    [[KeyController sharedKeyController] UpdateUserInfo:result];
    [weakSelf UpdateUserAuthentication];
    
    /*
    AuthViewModel *vm = [[AuthViewModel alloc] init];
    vm.noLoad = YES;
    vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
    vm.appId = [[KeyController sharedKeyController] GetAppId];
    vm.uid = [[KeyController sharedKeyController] GetUserUid];
    vm.token = [[KeyController sharedKeyController] GetUserToken];
    //查询实名认证状态
    [vm doAuthenticationCompleted:^(BaseResult * _Nonnull result) {
        if(result.success)
        {
            NSDictionary *valueDict = result.result;
            weakSelf.playerStatus = [valueDict[@"playerStatus"] boolValue];
            weakSelf.skipCertification = [valueDict[@"skipCertification"] boolValue];
            weakSelf.certification = [valueDict[@"certification"] boolValue];
            weakSelf.kickOutSwitch = [valueDict[@"kickOutSwitch"] boolValue];
            [weakSelf UpdateUserAuthentication];
        }
        else
        {
            [[ComController sharedComController] showErrorWithStatus:result.msg];
        }
    }];
     */
}

#pragma mark - 页面切换
/**  @代理 切换登录页面 */
- (void)BackLoginDelegate
{
    [self.FoundView ViewDidDisappear];
    [self.RegistView ViewDidDisappear];
    [self.QuickRegistView ViewDidDisappear];
    [self.SaveToPhotoAlbum ViewDidDisappear];
    [self.LoginLoadView ViewDidDisappear];
    [self.AuthenticationView ViewDidDisappear];
    [self.LoginView ViewDidAppear:NO];
    
    //更新登录信息
    NSArray *userList = [[KeyController sharedKeyController] GetUserList];
    NSDictionary *myInfo = [[KeyController sharedKeyController] GetUserInfo];
    [self.LoginView UpdateUserList:myInfo withUserList:userList];
}

/**  @代理 切换找回密码 */
- (void)BackFoundPasswordDelegate
{
    [self.LoginView ViewDidDisappear];
    [self.FoundView ViewDidAppear:YES];
    NSString *qqService = [[KeyController sharedKeyController] GetServiceQQ];
    NSString *phoneService = [[KeyController sharedKeyController] GetServicePhone];
    [self.FoundView SetServiceInfo:qqService withPhone:phoneService];
}

/**  @代理 切换注册页面 */
- (void)BackRegistDelegate
{
    [self.LoginView ViewDidDisappear];
    [self.QuickRegistView ViewDidDisappear];
    [self.SaveToPhotoAlbum ViewDidDisappear];
    [self.LoginLoadView ViewDidDisappear];
    [self.RegistView ViewDidAppear:YES];
    [self.RegistView UpdateRandomUserName];
}

/**  @代理 切换快速注册 */
- (void)BackQuickRegistDelegate
{
    [self.LoginView ViewDidDisappear];
    [self.FoundView ViewDidDisappear];
    [self.RegistView ViewDidDisappear];
    [self.QuickRegistView ViewDidAppear:YES];
}

/**  @跳转 截图到相册 */
- (void)TurnToSaveAlbumView:(NSString *)name withPassword:(NSString *)password;
{
    [self.LoginView ViewDidDisappear];
    [self.RegistView ViewDidDisappear];
    [self.QuickRegistView ViewDidDisappear];
    [self.SaveToPhotoAlbum ViewDidAppear:YES];
    [self.LoginLoadView ViewDidDisappear];
    [self.SaveToPhotoAlbum UpdateUserInfo:name withPassword:password];
}

/**  @显示 一键快速注册按钮 */
- (void)OneQuickRegistShow:(BOOL)bShow
{
    [self.LoginView OneQuickRegistShow:bShow];
    [self.RegistView OneQuickRegistShow:bShow];
    [self.QuickRegistView OneQuickRegistShow:bShow];
}


/**  @打开 实名认证页面 */
- (void)OpenAuthenticationView
{
    [self.LoginView ViewDidDisappear];
    [self.FoundView ViewDidDisappear];
    [self.RegistView ViewDidDisappear];
    [self.QuickRegistView ViewDidDisappear];
    [self.SaveToPhotoAlbum ViewDidDisappear];
    [self.LoginLoadView ViewDidDisappear];
    [self.AuthenticationView ViewDidAppear:YES];
}
#pragma mark - LoginViewDelegate
/**  @代理 退出登录页面 */
- (void)QuitActionDelegate
{
    [self RemoveLoginView];
}

/**  @代理 登录 -- uid token */
- (void)RequireLoginByToken:(NSString *)passport withUid:(NSString *)uid withToken:(NSString *)token;
{
    //打开LoginLoad界面
    [[KeyController sharedKeyController] SetLoginName:passport];
    [self SetLoginLoadState:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CHANGE_TIME * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        QY_LoginModel *vm = [[QY_LoginModel alloc] init];
        vm.uid = uid;
        vm.token = token;
        vm.appId = [[KeyController sharedKeyController] GetAppId];
        vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
        vm.noLoad = YES;
        __weak typeof(self) weakSelf = self;
        [vm doAutoLoginCompleted:^(QY_ResultBase * _Nonnull result) {
            if (!weakSelf.bLoginLoad)
            {
                return;
            }
            else
            {
                [weakSelf SetLoginLoadState:NO];
            }
            if (result.success)
            {
                [[KeyController sharedKeyController] SetLoginName:passport];
                NSDictionary *valueDict = result.result;
                [[KeyController sharedKeyController] UpdateUserInfo:valueDict];
                [[QY_CommonController sharedComController] showSuccessWithStatus:@"登录成功"];
                weakSelf.bFirst = NO;
                [weakSelf LoginSuccess:valueDict];
            }
            else
            {
                [[QY_CommonController sharedComController] showErrorWithStatus:result.msg];
            }
        }];
    });
}

/**  @代理 登录 -- 账号 密码 */
- (void)RequireLogin:(NSString *)passport withPassword:(NSString *)password
{
    if ([passport isEqualToString:@""] || [password isEqualToString:@""])
    {
        [[QY_CommonController sharedComController] showErrorWithStatus:@"用户名和密码都不能为空"];
    }
    else
    {
        //打开LoginLoad界面
        [[KeyController sharedKeyController] SetLoginName:passport];
        [self SetLoginLoadState:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CHANGE_TIME * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            QY_LoginModel *vm = [[QY_LoginModel alloc] init];
            vm.passport = passport;
            vm.password = password;
            vm.appId = [[KeyController sharedKeyController] GetAppId];
            vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
            vm.noLoad = YES;
            __weak typeof(self) weakSelf = self;
            [vm doLoginCompleted:^(QY_ResultBase * _Nonnull result) {
                if (!weakSelf.bLoginLoad)
                {
                    return ;
                }
                else
                {
                    [weakSelf SetLoginLoadState:NO];
                }
                
                if (result.success)
                {
                    [[KeyController sharedKeyController] SetLoginName:passport];
                    NSDictionary *valueDict = result.result;
                    [[KeyController sharedKeyController] UpdateUserInfo:valueDict];
                    [[QY_CommonController sharedComController] showSuccessWithStatus:@"登录成功"];
                    weakSelf.bFirst = NO;
                    [weakSelf LoginSuccess:valueDict];
                }
                else
                {
                    [[QY_CommonController sharedComController] showErrorWithStatus:result.msg];
                }
            }];
        });
    }
}

/**  @代理 移除下拉列表数据 */
- (void)RemoveUserListDelegate:(NSInteger)indexCell
{
    //TODO
    NSArray *userList = [[KeyController sharedKeyController] RemoveUserListByIndex:indexCell];
    [self.LoginView UpdateUserList:NULL withUserList:userList];
}

/**  @一键快速注册 */
- (void)OneQuickRegistDelegate
{
    QY_LoginModel *vm = [[QY_LoginModel alloc] init];
    vm.appId = [[KeyController sharedKeyController] GetAppId];
    vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
    __weak typeof(self) weakSelf = self;
    [vm doOneQuickRegistCompleted:^(QY_ResultBase * _Nonnull result) {
        if (result.success)
        {
            NSDictionary *valueDict = result.result;
            [[KeyController sharedKeyController] UpdateUserInfo:valueDict];
            [[QY_CommonController sharedComController] showSuccessWithStatus:@"注册成功"];
            //储存用户名和密码 方便保存到相册
            weakSelf.bFirst = NO;
            weakSelf.UserInfo = valueDict;
            NSString *name = valueDict[@"userName"];
            NSString *password = valueDict[@"password"];
            [weakSelf OneQuickRegistShow:NO];
            [weakSelf TurnToSaveAlbumView:name withPassword:password];
        }
        else
        {
            [[QY_CommonController sharedComController] showErrorWithStatus:result.msg];
        }
    }];
}

/**  @自动登录 */
- (void)AutoLoginDelegate
{
    BOOL bAutoLogin = [[KeyController sharedKeyController] GetAutoLogin];
    NSDictionary *userInfo = [[KeyController sharedKeyController] GetUserInfo];
    NSString *uid = [NSString stringWithFormat:@"%@",userInfo[@"pid"]];
    NSString *token = userInfo[@"token"];
    NSString *nick = [[KeyController sharedKeyController] GetLoginName];
    if(bAutoLogin && uid && token)
    {
        [self RequireLoginByToken:nick withUid:uid withToken:token];
    }
}

#pragma mark - RegistViewDelegate
/**  @代理 注册 --  账号 密码*/
- (void)RequireRegist:(NSString *)name withPassword:(NSString *)password
{
    if ([name isEqualToString:@""] || [password isEqualToString:@""])
    {
        [[QY_CommonController sharedComController] showErrorWithStatus:@"用户名和密码都不能为空"];
    }
    else
    {
        [[KeyController sharedKeyController] SetLoginName:name];
        QY_LoginModel *vm = [[QY_LoginModel alloc] init];
        vm.userName = name;
        vm.password = password;
        vm.appId = [[KeyController sharedKeyController] GetAppId];
        vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
        __weak typeof(self) weakSelf = self;
        [vm doRegistCompleted:^(QY_ResultBase * _Nonnull result) {
            if (result.success)
            {
                [[KeyController sharedKeyController] SetLoginName:name];
                NSDictionary *valueDict = result.result;
                [[KeyController sharedKeyController] UpdateUserInfo:valueDict];
                [[QY_CommonController sharedComController] showSuccessWithStatus:@"注册成功"];
                //储存用户名和密码 方便保存到相册
                weakSelf.bFirst = NO;
                weakSelf.UserInfo = valueDict;
                [weakSelf OneQuickRegistShow:NO];
                [weakSelf TurnToSaveAlbumView:name withPassword:password];
            }
            else
            {
                [[QY_CommonController sharedComController] showErrorWithStatus:result.msg];
            }
        }];
    }
}

/**  @代理 请求更新用户名 */
- (void)RequireRandomUserName
{
    QY_LoginModel *vm = [[QY_LoginModel alloc] init];
    vm.appId = [[KeyController sharedKeyController] GetAppId];
    vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
    __weak typeof(self) weakSelf = self;
    [vm doRandomUserNameCompleted:^(QY_ResultBase * _Nonnull result) {
        if (result.success)
        {
            NSString *userName = result.result;
            [weakSelf.RegistView SetRandomUserName:userName];
        }
        else
        {
            [[QY_CommonController sharedComController] showErrorWithStatus:result.msg];
        }
    }];
}

#pragma mark - QuickRegistViewDelegate
/**  @代理 快速注册 发送验证码 */
- (void)RequireSendCodeOfQuickRegist:(NSString *)mobile
{
    if ([mobile isEqualToString:@""])
    {
        [[QY_CommonController sharedComController] showErrorWithStatus:@"手机号不能为空"];
    }
    else
    {
        QY_LoginModel *vm = [[QY_LoginModel alloc] init];
        vm.mobile = mobile;
        vm.appId = [[KeyController sharedKeyController] GetAppId];
        vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
        __weak typeof(self) weakSelf = self;
        [vm doSendSmsOfRegistCompleted:^(QY_ResultBase * _Nonnull result) {
            if (result.success)
            {
                //发送验证码 倒计时
                [weakSelf.QuickRegistView RegetSendCodeAction:[NSNumber numberWithInt:60]];
                [[QY_CommonController sharedComController] showSuccessWithStatus:@"发送成功"];
            }
            else
            {
                [[QY_CommonController sharedComController] showErrorWithStatus:result.msg];
            }
        }];
    }
}

/**  @代理 快速注册 -- 手机号码 密码 验证码 */
- (void)RequireQuickRegist:(NSString *)mobile withPassword:(NSString *)password withCode:(NSString *)smsCode
{
    if ([mobile isEqualToString:@""] || [password isEqualToString:@""] || [smsCode isEqualToString:@""])
    {
        [[QY_CommonController sharedComController] showErrorWithStatus:@"手机号、验证码和密码都不能为空"];
    }
    else
    {
        [[KeyController sharedKeyController] SetLoginName:mobile];
        QY_LoginModel *vm = [[QY_LoginModel alloc] init];
        vm.mobile = mobile;
        vm.password = password;
        vm.smsCode = smsCode;
        vm.appId = [[KeyController sharedKeyController] GetAppId];
        vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
        __weak typeof(self) weakSelf = self;
        [vm doQuickRegistCompleted:^(QY_ResultBase * _Nonnull result) {
            if (result.success)
            {
                [[KeyController sharedKeyController] SetLoginName:mobile];
                NSDictionary *valueDict = result.result;
                [[KeyController sharedKeyController] UpdateUserInfo:valueDict];
                [[QY_CommonController sharedComController] showSuccessWithStatus:@"注册成功"];
                weakSelf.bFirst = NO;
                [weakSelf OneQuickRegistShow:NO];
                [weakSelf LoginSuccess:valueDict];
            }
            else
            {
                [[QY_CommonController sharedComController] showErrorWithStatus:result.msg];
            }
        }];
    }
}

#pragma mark - FoundViewDelegate
/**  @代理 找回密码 发送验证码 */
- (void)RequireSendCodeOfFoundPassword:(NSString *)mobile
{
    if ([mobile isEqualToString:@""])
    {
        [[QY_CommonController sharedComController] showErrorWithStatus:@"用户名或手机号不能为空"];
    }
    else
    {
        QY_LoginModel *vm = [[QY_LoginModel alloc] init];
        vm.mobile = mobile;
        vm.appId = [[KeyController sharedKeyController] GetAppId];
        vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
        __weak typeof(self) weakSelf = self;
        [vm doSendSmsOfFoundCompleted:^(QY_ResultBase * _Nonnull result) {
            if (result.success)
            {
                //发送验证码 倒计时
                [weakSelf.FoundView RegetSendCodeAction:[NSNumber numberWithInt:60]];
                [[QY_CommonController sharedComController] showSuccessWithStatus:result.msg];
            }
            else
            {
                [[QY_CommonController sharedComController] showErrorWithStatus:result.msg];
            }
        }];
    }
}

/**  @代理 找回密码 -- 手机号码 验证码 新密码 */
- (void)RequireFound:(NSString *)mobile withPassword:(NSString *)password withCode:(NSString *)code
{
    if ([mobile isEqualToString:@""] || [password isEqualToString:@""] || [code isEqualToString:@""])
    {
        [[QY_CommonController sharedComController] showErrorWithStatus:@"手机号、验证码和密码都不能为空"];
    }
    else
    {
        [[KeyController sharedKeyController] SetLoginName:mobile];
        QY_LoginModel *vm = [[QY_LoginModel alloc] init];
        vm.mobile = mobile;
        vm.smsCode = code;
        vm.password = password;
        vm.appId = [[KeyController sharedKeyController] GetAppId];
        vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
        __weak typeof(self) weakSelf = self;
        [vm doFoundPasswordCompleted:^(QY_ResultBase * _Nonnull result) {
            if (result.success)
            {
                [[KeyController sharedKeyController] SetLoginName:mobile];
                NSDictionary *valueDict = result.result;
                [[KeyController sharedKeyController] UpdateUserInfo:valueDict];
                [[QY_CommonController sharedComController] showSuccessWithStatus:@"修改成功"];
                [weakSelf LoginSuccess:valueDict];
            }
            else
            {
                [[QY_CommonController sharedComController] showErrorWithStatus:result.msg];
            }
        }];
    }
}

#pragma mark - SaveToPhotoAlbumDelegate
/**  @代理 注册成功 */
- (void)RegistSuccessDelegate
{
    [self LoginSuccess:self.UserInfo];
}

/**  @代理 保存到相册 */
- (void)SaveToPhotoAlbumDelegate
{
    __weak typeof(self) weakSelf = self;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        [weakSelf HandleSaveToPhotoAlbumEvent:status];
    }];
}

/**  @保存账号密码为图片到相册中 */
- (void)HandleSaveToPhotoAlbumEvent:(PHAuthorizationStatus)status
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (status == PHAuthorizationStatusAuthorized)
        {
            UIImage *image = [[QY_CommonController sharedComController] imageFromView:self.LoginContainer];
            [weakSelf SaveImageToPhotoAlbum:weakSelf withImage:image];
            [weakSelf LoginSuccess:weakSelf.UserInfo];
        }
        else
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您需要在设置－照片中开启允许读取和写入功能" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alert addAction:[UIAlertAction actionWithTitle:@"设置" style:0 handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }]];
            UIViewController *unityController = [[KeyController sharedKeyController] GetMainController];
            [unityController presentViewController:alert animated:YES completion:nil];
        }
    });
}

/** @保存到相册 */
- (void)SaveImageToPhotoAlbum:(id)weakSelf withImage:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, weakSelf, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

/** @保存到相册结果 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error == nil)
    {
        [[QY_CommonController sharedComController] showSuccessWithStatus:@"存入相册成功"];
    }
    else
    {
        [[QY_CommonController sharedComController] showErrorWithStatus:@"存入相册失败"];
    }
}

#pragma mark - 监听键盘高度
/**  @代理 更新键盘 */
- (void)UpdateKeyboardState;
{
    if (self.Notification)
    {
        [self keyboardWillChangeFrame:self.Notification];
    }
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification{
    if (self.bChanging) {
        return;
    } else {
        self.bChanging = YES;
    }
    self.Notification = notification;
    NSDictionary *userInfo = notification.userInfo;
    CGFloat durationTime = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat nKeyboardY = keyboardFrame.origin.y;
    CGFloat yDiff = 0;
    CGFloat pCenter = 0;
    if (nKeyboardY + 5 < self.nScreenH)
    {
        UITextField *textField = [[QY_CommonController sharedComController] GetTextFieldFirstResponder:self.LoginContainer];
        if (textField)
        {
            UIViewController *unityController = [[KeyController sharedKeyController] GetMainController];
            CGRect pRect = [self.LoginContainer convertRect:self.LoginContainer.bounds toView:unityController.view];
            pCenter = pRect.origin.y + (pRect.size.height / 2.0) - (self.nScreenH / 2.0);
            CGRect rect = [textField convertRect:textField.bounds toView:unityController.view];
            if (nKeyboardY >= (rect.origin.y + rect.size.height))
            {
                self.bChanging = NO;
                return;
            }
            else
            {
                yDiff = nKeyboardY - rect.origin.y - rect.size.height;
            }
        }
    }
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:durationTime animations:^{
        weakSelf.bChanging = NO;
        [weakSelf.LoginContainer setCenter:CGPointMake((weakSelf.nScreenW / 2.0), (weakSelf.nScreenH / 2.0 + yDiff + pCenter))];
    }];
}

#pragma mark - LoginLoad
/**  @设置LoginLoad状态 */
- (void)SetLoginLoadState:(BOOL)bState;
{
    self.bLoginLoad = bState;
    if (bState)
    {
        [self.LoginLoadView ViewDidAppear:NO];
        [self.LoginLoadView UpdateLoginLoad];
        [[QY_CommonController sharedComController] dismiss];
    }
    else
    {
        [self.LoginLoadView ViewDidDisappear];
    }
}

/**  @代理 点击切换按钮 */
- (void)ClickChangeDelegate;
{
    [self SetLoginLoadState:NO];
}

#pragma mark - 实名认证
- (void)UpdateUserAuthentication
{
    //未开启实名认证(不需要进行实名认证)
    if(!self.certification || self.playerStatus)
    {
        [self EnterGameSuccess];
    }
    //进行实名认证
    else
    {
        //[self OpenAuthenticationView];
        [self EnterGameSuccess];
    }
}

/**  @实名认证代理 返回按钮 */
- (void)UpdateBackDelegate
{
    [[KeyController sharedKeyController] SetAutoLogin:NO];
    [self BackLoginDelegate];
}

/**  @实名认证代理 关闭按钮 */
- (void)UpdateCloseDelegate
{
    if(self.skipCertification)
    {
        [self EnterGameSuccess];
    }
    else
    {
        [self UpdateBackDelegate];
    }
}

/**  @代理 实名认证 -- 姓名 身份证*/
- (void)AuthAction:(NSString *)userName withNumber:(NSString *)userNumber
{
    if (userName == nil || userNumber == nil)
    {
        [[QY_CommonController sharedComController] showErrorWithStatus:@"姓名和身份证都不能为空"];
    }
    else if ([userName isEqualToString:@""] || [userNumber isEqualToString:@""])
    {
        [[QY_CommonController sharedComController] showErrorWithStatus:@"姓名和身份证都不能为空"];
    }
    else
    {
        __weak typeof(self) weakSelf = self;
        QY_AuthenticationModel *vm = [[QY_AuthenticationModel alloc] init];
        vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
        vm.appId = [[KeyController sharedKeyController] GetAppId];
        vm.uid = [[KeyController sharedKeyController] GetUserUid];
        vm.token = [[KeyController sharedKeyController] GetUserToken];
        vm.realName = userName;
        vm.idCardNo = userNumber;
        [vm doCertificationCompleted:^(QY_ResultBase * _Nonnull result) {
            if(result.success)
            {
                [weakSelf EnterGameSuccess];
                [[QY_CommonController sharedComController] showSuccessWithStatus:@"认证成功"];
            }
            else
            {
                [[QY_CommonController sharedComController] showErrorWithStatus:result.msg];
            }
        }];
    }
}

@end
