//
//  LoginApi.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/17.
//
//  备注：对服务端返回结果的处理，success和failue

#import <Foundation/Foundation.h>
#import "QY_ResultBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface QY_LoginAPI : NSObject

//账号注册
+ (void)doRegist:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;
//登录
+ (void)doLogin:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;
//随机用户名
+ (void)doRandomUserName:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;
//发送验证码 快速注册
+ (void)doSendSmsOfRegist:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;
//快速注册
+ (void)doQuickRegist:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;
//发送验证码 找回密码
+ (void)doSendSmsOfFound:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;
//找回密码
+ (void)doFoundPassword:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;
//token自动登录
+ (void)doAutoLogin:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;
//一键快速注册
+ (void)doOneQucikRegist:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;
//一键登录
+ (void)doOneLogin:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;

@end

NS_ASSUME_NONNULL_END
