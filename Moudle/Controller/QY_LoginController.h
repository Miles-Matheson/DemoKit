//
//  LoginViewController.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/13.
//
//  备注：登录管理器

#import "QY_ControllerBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface QY_LoginController : QY_ControllerBase

@property (nonatomic, copy) void(^LoginCallBack)(NSDictionary *resDictionary);

+ (instancetype)sharedLoginController;

/** @初始化 */
- (void)InitAppLicationWithShowView;

@end

NS_ASSUME_NONNULL_END
