//
//  LoginViewModel.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/16.
//
//  备注：向服务端请求时，传参设参params

#import "QY_ModelBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface QY_LoginModel : QY_ModelBase

@property (nonatomic, assign) BOOL noLoad;
@property (nonatomic, copy) NSString * appId;
@property (nonatomic, copy) NSString * requestTs;

@property (nonatomic, copy) NSString * userName;
@property (nonatomic, copy) NSString * passport;
@property (nonatomic, copy) NSString * password;
@property (nonatomic, copy) NSString * mobile;
@property (nonatomic, copy) NSString * smsCode;
@property (nonatomic, copy) NSString * uid;
@property (nonatomic, copy) NSString * token;
@property (nonatomic, copy) NSString * processID;

//账号注册
- (void)doRegistCompleted:(void(^)(QY_ResultBase *result))onCompleted;
//登录
- (void)doLoginCompleted:(void(^)(QY_ResultBase *result))onCompleted;
//随机用户名
- (void)doRandomUserNameCompleted:(void(^)(QY_ResultBase *result))onCompleted;
//发送验证码 快速注册
- (void)doSendSmsOfRegistCompleted:(void(^)(QY_ResultBase *result))onCompleted;
//快速注册
- (void)doQuickRegistCompleted:(void(^)(QY_ResultBase *result))onCompleted;
//发送验证码 找回密码
- (void)doSendSmsOfFoundCompleted:(void(^)(QY_ResultBase *result))onCompleted;
//找回密码
- (void)doFoundPasswordCompleted:(void(^)(QY_ResultBase *result))onCompleted;
//Token自动登录
- (void)doAutoLoginCompleted:(void(^)(QY_ResultBase *result))onCompleted;
//一键快速注册
- (void)doOneQuickRegistCompleted:(void(^)(QY_ResultBase *result))onCompleted;
//一键登录
- (void)doOneLoginCompleted:(void(^)(QY_ResultBase *result))onCompleted;

@end

NS_ASSUME_NONNULL_END
