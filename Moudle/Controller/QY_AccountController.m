//
//  AccountController.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/19.
//

#import "QY_AccountController.h"
#import "AccountContainer.h"
#import "AccountView.h"
#import "NewBindView.h"
#import "BindView.h"
#import "ChangeBindView.h"
#import "ChangePasswordView.h"
#import "ChangePasswordMobileView.h"
#import "ChangeAccountView.h"
#import "BaseMaskView.h"
#import "SaveToPhotoAlbumTwo.h"

#import "KeyController.h"
#import "QY_CommonController.h"
#import "QY_AccountModel.h"
#import "QY_LoginModel.h"
#import <Photos/Photos.h>

@interface QY_AccountController()<AccountViewDelegate,NewBindViewDelegate,BindViewDelegate,ChangeBindViewDelegate,ChangePasswordViewDelegate,ChangePasswordMobileViewDelegate,ChangeAccountViewDelegate,SaveToPhotoAlbumTwoDelegate>

@property (nonatomic, strong) BaseMaskView *BaseMaskView;
@property (nonatomic, strong) AccountContainer *AccountContainer;
@property (nonatomic, strong) AccountView *AccountView;
@property (nonatomic, strong) NewBindView *NewBindView;
@property (nonatomic, strong) BindView *BindView;
@property (nonatomic, strong) ChangeBindView *ChangeBindView;
@property (nonatomic, strong) ChangePasswordView *ChangePasswordView;
@property (nonatomic, strong) ChangePasswordMobileView *ChangePasswordMobileView;
@property (nonatomic, strong) ChangeAccountView *ChangeAccountView;
@property (nonatomic, strong) SaveToPhotoAlbumTwo *SaveToPhotoAlbumTwo;
@property (nonatomic, strong) NSNotification *Notification;

@property (nonatomic, assign) BOOL bChanging;
@property (nonatomic, assign) NSInteger nType;

@end

@implementation QY_AccountController

static id _instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
static dispatch_once_t onceToken;
dispatch_once(&onceToken, ^{
    _instance = [super allocWithZone:zone];
});
return  _instance;
}

+ (instancetype)sharedAccountController
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

- (AccountContainer *)AccountContainer
{
if (!_AccountContainer)
{
    CGFloat nItemR = self.nScreenW >= self.nScreenH? 0.9 * self.nScreenH : 0.9 * self.nScreenW;
    nItemR = nItemR > 400 ? 400 : nItemR;
    _AccountContainer = [[AccountContainer alloc] init];
    [_AccountContainer setFrame:CGRectMake(0, 0, nItemR, nItemR)];
    [_AccountContainer setCenter:CGPointMake(self.nScreenW/2.0, self.nScreenH/2.0)];
}
return _AccountContainer;
}

- (AccountView *)AccountView
{
if (!_AccountView)
{
    _AccountView = [[AccountView alloc] init];
    [_AccountContainer addSubview:_AccountView];
    CGSize SuperSize = _AccountView.superview.frame.size;
    [_AccountView setFrame:CGRectMake(0, 0, SuperSize.width, SuperSize.height)];
    [_AccountView setDelegate:self];
}
return _AccountView;
}

- (NewBindView *)NewBindView
{
if (!_NewBindView)
{
    _NewBindView = [[NewBindView alloc] init];
    [_AccountContainer addSubview:_NewBindView];
    CGSize SuperSize = _NewBindView.superview.frame.size;
    [_NewBindView setFrame:CGRectMake(0, 0, SuperSize.width, SuperSize.height)];
    [_NewBindView setDelegate:self];
}
return _NewBindView;
}

- (BindView *)BindView
{
if (!_BindView)
{
    _BindView = [[BindView alloc] init];
    [_AccountContainer addSubview:_BindView];
    CGSize SuperSize = _BindView.superview.frame.size;
    [_BindView setFrame:CGRectMake(0, 0, SuperSize.width, SuperSize.height)];
    [_BindView setDelegate:self];
}
return _BindView;
}

- (ChangeBindView *)ChangeBindView
{
if (!_ChangeBindView)
{
    _ChangeBindView = [[ChangeBindView alloc] init];
    [_AccountContainer addSubview:_ChangeBindView];
    CGSize SuperSize = _ChangeBindView.superview.frame.size;
    [_ChangeBindView setFrame:CGRectMake(0, 0, SuperSize.width, SuperSize.height)];
    [_ChangeBindView setDelegate:self];
}
return _ChangeBindView;
}

- (ChangePasswordView *)ChangePasswordView
{
if (!_ChangePasswordView)
{
    _ChangePasswordView = [[ChangePasswordView alloc] init];
    [_AccountContainer addSubview:_ChangePasswordView];
    CGSize SuperSize = _ChangeBindView.superview.frame.size;
    [_ChangePasswordView setFrame:CGRectMake(0, 0, SuperSize.width, SuperSize.height)];
    [_ChangePasswordView setDelegate:self];
}
return _ChangePasswordView;
}

- (ChangePasswordMobileView *)ChangePasswordMobileView
{
if (!_ChangePasswordMobileView)
{
    _ChangePasswordMobileView = [[ChangePasswordMobileView alloc] init];
    [_AccountContainer addSubview:_ChangePasswordMobileView];
    CGSize SuperSize = _ChangePasswordMobileView.superview.frame.size;
    [_ChangePasswordMobileView setFrame:CGRectMake(0, 0, SuperSize.width, SuperSize.height)];
    [_ChangePasswordMobileView setDelegate:self];
}
return _ChangePasswordMobileView;
}

- (ChangeAccountView *)ChangeAccountView
{
if (!_ChangeAccountView)
{
    _ChangeAccountView = [[ChangeAccountView alloc] init];
    [_AccountContainer addSubview:_ChangeAccountView];
    CGSize SuperSize = _ChangeAccountView.superview.frame.size;
    [_ChangeAccountView setFrame:CGRectMake(0, 0, SuperSize.width, SuperSize.height)];
    [_ChangeAccountView setDelegate:self];
}
return _ChangeAccountView;
}

- (SaveToPhotoAlbumTwo *)SaveToPhotoAlbumTwo
{
    if (!_SaveToPhotoAlbumTwo)
    {
        _SaveToPhotoAlbumTwo = [[SaveToPhotoAlbumTwo alloc] init];
        [_AccountContainer addSubview:_SaveToPhotoAlbumTwo];
        CGSize SuperSize = _SaveToPhotoAlbumTwo.superview.frame.size;
        [_SaveToPhotoAlbumTwo setFrame:CGRectMake(0, 0, SuperSize.width, SuperSize.height)];
        [_SaveToPhotoAlbumTwo setDelegate:self];
    }
    return _SaveToPhotoAlbumTwo;
}

/**  @账号管理容器
*   初始化主界面
*   普通用户绑定手机号
*   手机用户验证手机号
*   手机用户修改手机号
*   普通用户修改密码
*   手机用户修改密码
*/
- (void)InitAccountView:(NSInteger)nType;
{
    self.nType = nType;
    [self InitController];
    UIViewController *unityController = [[KeyController sharedKeyController] GetMainController];
    [unityController.view addSubview:self.BaseMaskView];
    [self.BaseMaskView setCenter:unityController.view.center];
    [self.BaseMaskView addSubview:self.AccountContainer];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    if (nType == BindPhone || nType == ChangePhone) {
        [self JumpBindViewDelegate];
    }
    else {
        [self BackAccountDelegate];
    }
}

/**  @移除accountview */
- (void)RemoveAccountView
{
    [self.AccountView setDelegate:nil];
    [self.NewBindView setDelegate:nil];
    [self.BindView setDelegate:nil];
    [self.ChangeBindView setDelegate:nil];
    [self.ChangePasswordView setDelegate:nil];
    [self.ChangePasswordMobileView setDelegate:nil];
    [self.ChangeAccountView setDelegate:nil];
    [self.SaveToPhotoAlbumTwo setDelegate:nil];

    [self.AccountView DestroyView];
    [self.NewBindView DestroyView];
    [self.BindView DestroyView];
    [self.ChangeBindView DestroyView];
    [self.ChangePasswordView DestroyView];
    [self.ChangePasswordMobileView DestroyView];
    [self.ChangeAccountView DestroyView];
    [self.AccountContainer DestroyView];
    [self.SaveToPhotoAlbumTwo DestroyView];
    [self.BaseMaskView DestroyView];

    self.SaveToPhotoAlbumTwo = nil;
    self.AccountView = nil;
    self.NewBindView = nil;
    self.BindView = nil;
    self.ChangeBindView = nil;
    self.ChangePasswordView = nil;
    self.ChangePasswordMobileView = nil;
    self.ChangeAccountView = nil;
    self.AccountContainer = nil;
    self.BaseMaskView = nil;

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillChangeFrameNotification
                                                  object:nil];
}

#pragma mark - 页面切换
/**  @代理 返回账号管理页面 */
- (void)BackAccountDelegate
{
    //新绑定手机号的返回
    if(self.nType == BindPhone || self.nType == ChangePhone) {
        [self QuitActionDelegate];
        return;
    }
    
    //根据手机号 更新 登录页面信息
    NSString *user_name = [[KeyController sharedKeyController] GetUserName];
    NSString *user_mobile = [[KeyController sharedKeyController] GetUserMobile];
    [self.AccountView UpdateBindModeByMobile:user_mobile withName:user_name];
    NSString *qqService = [[KeyController sharedKeyController] GetServiceQQ];
    NSString *phoneService = [[KeyController sharedKeyController] GetServicePhone];
    [self.AccountView SetServiceInfo:qqService withPhone:phoneService];

    [self.AccountView ViewDidAppear:YES];
    [self.AccountView UpdateChangePasswordState];
    [self.NewBindView ViewDidDisappear];
    [self.BindView ViewDidDisappear];
    [self.ChangeBindView ViewDidDisappear];
    [self.ChangePasswordView ViewDidDisappear];
    [self.ChangePasswordMobileView ViewDidDisappear];
    [self.ChangeAccountView ViewDidDisappear];
    [self.SaveToPhotoAlbumTwo ViewDidDisappear];
}

/**  @代理 跳转绑定页面 */
- (void)JumpBindViewDelegate
{
NSString *user_mobile = [[KeyController sharedKeyController] GetUserMobile];
//新绑定手机号
if (user_mobile == nil)
{
    [self.NewBindView ViewDidAppear:YES];
    [self.AccountView ViewDidDisappear];
    [self.SaveToPhotoAlbumTwo ViewDidDisappear];
}
//变更手机号
else
{
    [self.BindView ViewDidAppear:YES];
    [self.BindView UpdateBindViewByMobile:user_mobile];
    [self.AccountView ViewDidDisappear];
    [self.SaveToPhotoAlbumTwo ViewDidDisappear];
}
}

/**  @代理 跳转修改密码页面 */
- (void)JumpChangePasswordViewDelegate
{
    [self.ChangePasswordView ViewDidAppear:YES];
    [self.ChangePasswordView UpdateChangePasswordState];
    [self.AccountView ViewDidDisappear];
    [self.SaveToPhotoAlbumTwo ViewDidDisappear];

    /*
    NSString *user_mobile = [[KeyController sharedKeyController] GetUserMobile];
    if (user_mobile == nil)
    {
        [self.ChangePasswordView ViewDidAppear:YES];
        [self.AccountView ViewDidDisappear];
    }
    else
    {
        [self.ChangePasswordMobileView ViewDidAppear:YES];
        [self.ChangePasswordMobileView UpdateChangePasswordMobileViewByMobile:user_mobile];
        [self.AccountView ViewDidDisappear];
    }
    */
}

/**  @代理 返回绑定手机号页面 */
- (void)BackBindViewDelegate
{
    [self.BindView ViewDidAppear:YES];
    [self.ChangeBindView ViewDidDisappear];
    [self.SaveToPhotoAlbumTwo ViewDidDisappear];
}

/**  @跳转 手机用户变更手机号 二次验证 */
- (void)JumpToChangeBindView:(NSString *)code
{
    [self.ChangeBindView ViewDidAppear:YES];
    [self.ChangeBindView PassMobileCodeAction:code];
    [self.BindView ViewDidDisappear];
    [self.SaveToPhotoAlbumTwo ViewDidDisappear];
}

#pragma mark - AccountViewDelegate
/**  @代理 关闭账号管理页面 */
- (void)QuitActionDelegate
{
    [self RemoveAccountView];
    if (self.SuspendShow)
    {
        self.SuspendShow(YES);
    }
}

/**  @代理 退出账号 */
- (void)LoginOutDelegate
{
    [self RemoveAccountView];
    if (self.SuspendShow)
    {
        self.SuspendShow(NO);
    }
}

#pragma mark - NewBindViewDelegate
/**  @代理 发送验证码 */
- (void)SendCodeOfNewBind:(NSString *)mobile
{
if ([mobile isEqualToString:@""])
{
    [[QY_CommonController sharedComController] showErrorWithStatus:@"手机号不能为空"];
}
else
{
    QY_AccountModel *vm = [[QY_AccountModel alloc] init];
    vm.mobile = mobile;
    vm.appId = [[KeyController sharedKeyController] GetAppId];
    vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
    vm.uid = [[KeyController sharedKeyController] GetUserUid];
    vm.token = [[KeyController sharedKeyController] GetUserToken];
    __weak typeof(self) weakSelf = self;
    [vm doSendCodeOfUserBindMobileCompleted:^(QY_ResultBase * _Nonnull result) {
        if (result.success)
        {
            [weakSelf.NewBindView RegetSendCodeAction:[NSNumber numberWithInt:60]];
            [[QY_CommonController sharedComController] showSuccessWithStatus:@"发送成功"];
        }
        else
        {
            [[QY_CommonController sharedComController] showErrorWithStatus:result.msg];
        }
    }];
}
}

/**  @代理 绑定新手机号 */
- (void)NewBindNewMobile:(NSString *)mobile withCode:(NSString *)code
    {
    if ([mobile isEqualToString:@""] || [code isEqualToString:@""])
    {
        [[QY_CommonController sharedComController] showErrorWithStatus:@"手机号和验证码都不能为空"];
    }
    else
    {
        QY_AccountModel *vm = [[QY_AccountModel alloc] init];
        vm.appId = [[KeyController sharedKeyController] GetAppId];
        vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
        vm.uid = [[KeyController sharedKeyController] GetUserUid];
        vm.token = [[KeyController sharedKeyController] GetUserToken];
        vm.mobile = mobile;
        vm.smsCode = code;
        __weak typeof(self) weakSelf = self;
        [vm doBindMobileOfUserCompleted:^(QY_ResultBase * _Nonnull result) {
            if (result.success)
            {
                NSDictionary *valueDict = result.result;
                BOOL isDefault = [[valueDict objectForKey:@"isDefaultAccount"] boolValue];
                if (!isDefault) {
                    [[KeyController sharedKeyController] SetLoginName:[valueDict objectForKey:@"userName"]];
                }
                [[KeyController sharedKeyController] UpdateUserInfo:valueDict];
                [[QY_CommonController sharedComController] showSuccessWithStatus:@"绑定成功"];
                [weakSelf TurnToSaveAlbumVieWithDefault:isDefault];
            }
            else
            {
                [[QY_CommonController sharedComController] showErrorWithStatus:result.msg];
            }
        }];
    }
}

#pragma mark - BindViewDelegate
/**  @代理 发送验证码 */
- (void)SendCodeOfBindDelegate
{
QY_AccountModel *vm = [[QY_AccountModel alloc] init];
vm.appId = [[KeyController sharedKeyController] GetAppId];
vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
vm.uid = [[KeyController sharedKeyController] GetUserUid];
vm.token = [[KeyController sharedKeyController] GetUserToken];
__weak typeof(self) weakSelf = self;
[vm doSendCodeOfMobileOldCompleted:^(QY_ResultBase * _Nonnull result) {
    if (result.success)
    {
        [weakSelf.BindView RegetSendCodeAction:[NSNumber numberWithInt:60]];
        [[QY_CommonController sharedComController] showSuccessWithStatus:@"发送成功"];
    }
    else
    {
        [[QY_CommonController sharedComController] showErrorWithStatus:result.msg];
    }
}];
}

/**  @代理 绑定新手机号 */
- (void)ReadyToBindNewMobile:(NSString *)code
{
if ([code isEqualToString:@""])
{
    [[QY_CommonController sharedComController] showErrorWithStatus:@"验证码不能为空"];
}
else
{
    QY_AccountModel *vm = [[QY_AccountModel alloc] init];
    vm.appId = [[KeyController sharedKeyController] GetAppId];
    vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
    vm.uid = [[KeyController sharedKeyController] GetUserUid];
    vm.token = [[KeyController sharedKeyController] GetUserToken];
    vm.smsCode = code;
    __weak typeof(self) weakSelf = self;
    [vm doBindMobileOfMobileOldCompleted:^(QY_ResultBase * _Nonnull result) {
        if (result.success)
        {
            [weakSelf JumpToChangeBindView:code];
            [[QY_CommonController sharedComController] showSuccessWithStatus:@"验证成功"];
        }
        else
        {
            [[QY_CommonController sharedComController] showErrorWithStatus:result.msg];
        }
    }];
}
}

#pragma mark - ChangeBindViewDelegate
/**  @代理 发送验证码 */
- (void)SendCodeOfChangeBind:(NSString *)mobile withOldCode:(NSString *)oCode
{
if ([mobile isEqualToString:@""])
{
    [[QY_CommonController sharedComController] showErrorWithStatus:@"手机号不能为空"];
}
else
{
    QY_AccountModel *vm = [[QY_AccountModel alloc] init];
    vm.appId = [[KeyController sharedKeyController] GetAppId];
    vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
    vm.uid = [[KeyController sharedKeyController] GetUserUid];
    vm.token = [[KeyController sharedKeyController] GetUserToken];
    vm.mobile = mobile;
    vm.smsCode = oCode;
    __weak typeof(self) weakSelf = self;
    [vm doSendCodeOfMobileNewCompleted:^(QY_ResultBase * _Nonnull result) {
        if (result.success)
        {
            [weakSelf.ChangeBindView RegetSendCodeAction:[NSNumber numberWithInt:60]];
            [[QY_CommonController sharedComController] showSuccessWithStatus:@"发送成功"];
        }
        else
        {
            [[QY_CommonController sharedComController] showErrorWithStatus:result.msg];
        }
    }];
}
}
/**  @代理 绑定新手机号 */
- (void)ChangeBindNewMobile:(NSString *)mobile withNickName:(NSString *)nickname withOldCode:(NSString *)oCode withNewCode:(NSString *)nCode
{
    if ([mobile isEqualToString:@""] || [nCode isEqualToString:@""])
    {
        [[QY_CommonController sharedComController] showErrorWithStatus:@"手机号和验证码都不能为空"];
    }
    else
    {
        QY_AccountModel *vm = [[QY_AccountModel alloc] init];
        vm.appId = [[KeyController sharedKeyController] GetAppId];
        vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
        vm.uid = [[KeyController sharedKeyController] GetUserUid];
        vm.token = [[KeyController sharedKeyController] GetUserToken];
        vm.nickName = nickname;
        vm.nMobile = mobile;
        vm.smsCode = oCode;
        vm.nSmsCode = nCode;
        __weak typeof(self) weakSelf = self;
        [vm doBindMobileOfMobileNewCompleted:^(QY_ResultBase * _Nonnull result) {
            if (result.success)
            {
                NSDictionary *valueDict = result.result;
                BOOL isDefault = [[valueDict objectForKey:@"isDefaultAccount"] boolValue];
                if (!isDefault) {
                    [[KeyController sharedKeyController] SetLoginName:[valueDict objectForKey:@"userName"]];
                }
                [[KeyController sharedKeyController] UpdateUserInfo:valueDict];
                [[QY_CommonController sharedComController] showSuccessWithStatus:@"修改成功"];
                [weakSelf TurnToSaveAlbumVieWithDefault:isDefault];
            }
            else
            {
                [[QY_CommonController sharedComController] showErrorWithStatus:result.msg];
            }
        }];
    }
}

#pragma mark - ChangePasswordViewDelegate
/**  @代理 修改密码 */
- (void)ChangePassword:(NSString *)oPassword withNew:(NSString *)nPassword withReNew:(NSString *)sPassword
{
BOOL bEmptyPassword = [[KeyController sharedKeyController] GetUserEmptyPassword];
if ((bEmptyPassword == YES) && ([nPassword isEqualToString:@""] || [sPassword isEqualToString:@""]))
{
    [[QY_CommonController sharedComController] showErrorWithStatus:@"密码不能为空"];
}
else if ((bEmptyPassword == NO) && ([oPassword isEqualToString:@""] || [nPassword isEqualToString:@""] || [sPassword isEqualToString:@""]))
{
    [[QY_CommonController sharedComController] showErrorWithStatus:@"密码不能为空"];
}
else if (![nPassword isEqualToString:sPassword])
{
    [[QY_CommonController sharedComController] showErrorWithStatus:@"两次新密码不一致"];
}
else
{
    QY_AccountModel *vm = [[QY_AccountModel alloc] init];
    vm.appId = [[KeyController sharedKeyController] GetAppId];
    vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
    vm.uid = [[KeyController sharedKeyController] GetUserUid];
    vm.token = [[KeyController sharedKeyController] GetUserToken];
    vm.oPassword = (bEmptyPassword == YES)? @"" : oPassword;
    vm.nPassword = nPassword;
    __weak typeof(self) weakSelf = self;
    [vm doChangePasswordOfUserCompleted:^(QY_ResultBase * _Nonnull result) {
        if (result.success)
        {
            NSDictionary *valueDict = result.result;
            [[KeyController sharedKeyController] UpdateUserInfo:valueDict];
            [weakSelf BackAccountDelegate];
            [[QY_CommonController sharedComController] showSuccessWithStatus:@"修改成功"];
        }
        else
        {
            [[QY_CommonController sharedComController] showErrorWithStatus:result.msg];
        }
    }];
}
}

#pragma mark - ChangePasswordMobileViewDelegate
/**  @代理 发送验证码 */
- (void)SendCodeOfChangePasswordOfMobile
{
QY_AccountModel *vm = [[QY_AccountModel alloc] init];
vm.appId = [[KeyController sharedKeyController] GetAppId];
vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
vm.uid = [[KeyController sharedKeyController] GetUserUid];
vm.token = [[KeyController sharedKeyController] GetUserToken];
__weak typeof(self) weakSelf = self;
[vm doSendCodeOfMobileToChangePasswordCompleted:^(QY_ResultBase * _Nonnull result) {
    if (result.success)
    {
        [weakSelf.ChangePasswordMobileView RegetSendCodeAction:[NSNumber numberWithInt:60]];
        [[QY_CommonController sharedComController] showSuccessWithStatus:@"发送成功"];
    }
    else
    {
        [[QY_CommonController sharedComController] showErrorWithStatus:result.msg];
    }
}];
}

/**  @代理 手机用户 修改密码 */
- (void)ChangePasswordOfMobile:(NSString *)code withPassword:(NSString *)password
{
    if ([code isEqualToString:@""] || [password isEqualToString:@""])
    {
        [[QY_CommonController sharedComController] showErrorWithStatus:@"验证码和新密码都不能为空"];
    }
    else
    {
        QY_AccountModel *vm = [[QY_AccountModel alloc] init];
        vm.appId = [[KeyController sharedKeyController] GetAppId];
        vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
        vm.uid = [[KeyController sharedKeyController] GetUserUid];
        vm.token = [[KeyController sharedKeyController] GetUserToken];
        vm.smsCode = code;
        vm.password = password;
        __weak typeof(self) weakSelf = self;
        [vm doChangePasswordOfMibileCompleted:^(QY_ResultBase * _Nonnull result) {
            if (result.success)
            {
                NSDictionary *valueDict = result.result;
                [[KeyController sharedKeyController] UpdateUserInfo:valueDict];
                [weakSelf BackAccountDelegate];
                [[QY_CommonController sharedComController] showSuccessWithStatus:@"修改成功"];
            }
            else
            {
                [[QY_CommonController sharedComController] showErrorWithStatus:result.msg];
            }
        }];
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
        UITextField *textField = [[QY_CommonController sharedComController] GetTextFieldFirstResponder:self.AccountContainer];
        if (textField)
        {
            UIViewController *unityController = [[KeyController sharedKeyController] GetMainController];
            CGRect pRect = [self.AccountContainer convertRect:self.AccountContainer.bounds toView:unityController.view];
            pCenter = pRect.origin.y + (pRect.size.height / 2.0) - (self.nScreenH / 2.0);
            CGRect rect = [textField convertRect:textField.bounds toView:unityController.view];
            if (nKeyboardY >= (rect.origin.y + rect.size.height))
            {
                self.bChanging = false;
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
        [weakSelf.AccountContainer setCenter:CGPointMake((self.nScreenW / 2.0), (self.nScreenH / 2.0 + yDiff + pCenter))];
    }];
}

/**  @代理 切换小号 */
- (void)ChangeAccountDelegate
{
    [self.ChangeAccountView ViewDidAppear:YES];
    [self.AccountView ViewDidDisappear];
    [self RequestSubUserList];
    [self.SaveToPhotoAlbumTwo ViewDidDisappear];
}

/**  @请求小号列表 */
- (void)RequestSubUserList
{
QY_AccountModel *vm = [[QY_AccountModel alloc] init];
vm.appId = [[KeyController sharedKeyController] GetAppId];
vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
vm.uid = [[KeyController sharedKeyController] GetUserUid];
vm.token = [[KeyController sharedKeyController] GetUserToken];
__weak typeof(self) weakSelf = self;
[vm doGetSubUserListCompleted:^(QY_ResultBase * _Nonnull result) {
    if (result.success)
    {
        [weakSelf.ChangeAccountView UpdateSubUserTableView:result.result];
    }
    else
    {
        [[QY_CommonController sharedComController] showErrorWithStatus:result.msg];
    }
}];
}

/**  @代理 新建小号 */
- (void)CreateSubUserDelegate:(NSString *)nickName;
{
QY_AccountModel *vm = [[QY_AccountModel alloc] init];
vm.nickName = nickName;
vm.appId = [[KeyController sharedKeyController] GetAppId];
vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
vm.uid = [[KeyController sharedKeyController] GetUserUid];
vm.token = [[KeyController sharedKeyController] GetUserToken];
__weak typeof(self) weakSelf = self;
[vm doCreateSubUserCompleted:^(QY_ResultBase * _Nonnull result) {
    if (result.success)
    {
        [weakSelf.ChangeAccountView InsertSubUserInfo:result.result];
        NSDictionary *userInfo = result.result;
        NSString *msg = [NSString stringWithFormat:@"创建小号[%@]成功", userInfo[@"nickName"]];
        [[QY_CommonController sharedComController] showSuccessWithStatus:msg];
    }
    else
    {
        [[QY_CommonController sharedComController] showErrorWithStatus:result.msg];
    }
}];
}

/**  @代理 选择小号 */
- (void)SelectedSubUserDelegate:(NSString *)subPid
{
QY_AccountModel *vm = [[QY_AccountModel alloc] init];
vm.subPid = subPid;
vm.appId = [[KeyController sharedKeyController] GetAppId];
vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
vm.uid = [[KeyController sharedKeyController] GetUserUid];
vm.token = [[KeyController sharedKeyController] GetUserToken];
__weak typeof(self) weakSelf = self;
[vm doChooseSubUserCompleted:^(QY_ResultBase * _Nonnull result) {
    if (result.success)
    {
        [weakSelf.ChangeAccountView UpdateSubUserState:subPid];
        [[QY_CommonController sharedComController] showSuccessWithStatus:@"切换成功，请重新登录游戏"];
    }
    else
    {
        [[QY_CommonController sharedComController] showErrorWithStatus:result.msg];
    }
}];
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
        [weakSelf.ChangeBindView SetRandomUserName:userName];
    }
    else
    {
        [[QY_CommonController sharedComController] showErrorWithStatus:result.msg];
    }
}];
}

- (int)ConvertToInt:(NSString *)str
{
int strlength = 0;
char *p = (char *)[str cStringUsingEncoding:NSUnicodeStringEncoding];
for(int i=0; i<[str lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++){
    if (*p){
        p++;
        strlength++;
    }else{
        p++;
    }
}
return strlength;
}

/**  @上报数据 */
- (void)ReportGameData:(NSDictionary *)params;
{
    QY_AccountModel *vm = [[QY_AccountModel alloc] init];
    vm.appId = [[KeyController sharedKeyController] GetAppId];
    vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
    vm.uid = [[KeyController sharedKeyController] GetUserUid];
    vm.token = [[KeyController sharedKeyController] GetUserToken];
    vm.roleId = params[@"roleId"];
    vm.roleName = params[@"roleName"];
    vm.serverId = params[@"serverId"];
    vm.serverName = params[@"serverName"];
    vm.roleLevel = params[@"roleLevel"];
    
    [vm doReportGameDataCompleted:^(QY_ResultBase * _Nonnull result) {
        if (result.success)
        {
            NSLog(@" ====== success ====== ");
        }
        else
        {
            NSLog(@" ====== failed ====== ");
        }
    }];
}

/**  @跳转 截图到相册 */
- (void)TurnToSaveAlbumVieWithDefault:(BOOL)isDefault;
{
    [self.AccountView ViewDidDisappear];
    [self.NewBindView ViewDidDisappear];
    [self.BindView ViewDidDisappear];
    [self.ChangeBindView ViewDidDisappear];
    [self.SaveToPhotoAlbumTwo ViewDidAppear:YES];
    [self.SaveToPhotoAlbumTwo UpdateUserInfoWithType:self.nType withDefault:isDefault];
}

#pragma mark - SaveToPhotoAlbumDelegate
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
            UIImage *image = [[QY_CommonController sharedComController] imageFromView:self.AccountContainer];
            [weakSelf SaveImageToPhotoAlbum:weakSelf withImage:image];
            if (weakSelf.nType == BindPhone || weakSelf.nType == ChangePhone) {
                [weakSelf QuitActionDelegate];
            }
            else {
                [weakSelf BackAccountDelegate];
            }
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

@end
