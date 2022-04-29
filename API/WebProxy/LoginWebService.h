//
//  LoginWebService.h
//  Unity-iPhone
//
//  Created by Allone on 2019/6/16.
//
//  备注：WebService主要配置请求的url

#import <Foundation/Foundation.h>
#import "QY_WebProxyBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface QY_LoginWebProxy : NSObject

//账号注册
+ (void)doRegistSuccess:(void (^)(id response))success
                failure:(void (^)(NSError* err))failure
                 params:(NSDictionary *)params;
//登录
+ (void)doLoginSuccess:(void (^)(id response))success
                failure:(void (^)(NSError* err))failure
                 params:(NSDictionary *)params;
//随机用户名
+ (void)doRandomUserNameSuccess:(void (^)(id response))success
                        failure:(void (^)(NSError* err))failure
                         params:(NSDictionary *)params;
//发送验证码 快速注册
+ (void)doSendSmsOfRegistSuccess:(void (^)(id response))success
                         failure:(void (^)(NSError* err))failure
                          params:(NSDictionary *)params;
//快速注册
+ (void)doQuickRegistSuccess:(void (^)(id response))success
                         failure:(void (^)(NSError* err))failure
                          params:(NSDictionary *)params;
//发送验证码 找回密码
+ (void)doSendSmsOfFoundSuccess:(void (^)(id response))success
                         failure:(void (^)(NSError* err))failure
                          params:(NSDictionary *)params;
//找回密码
+ (void)doFoundPasswordSuccess:(void (^)(id response))success
                        failure:(void (^)(NSError* err))failure
                         params:(NSDictionary *)params;
//token自动登录
+ (void)doAutoLoginSuccess:(void (^)(id response))success
                       failure:(void (^)(NSError* err))failure
                        params:(NSDictionary *)params;
//一键快速注册
+ (void)doOneQuickRegistSuccess:(void (^)(id response))success
                   failure:(void (^)(NSError* err))failure
                    params:(NSDictionary *)params;
//一键登录
+ (void)doOneLoginSuccess:(void (^)(id response))success
                   failure:(void (^)(NSError* err))failure
                    params:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
