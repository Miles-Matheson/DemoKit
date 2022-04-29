//
//  LoginWebService.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/16.
//

#import "QY_LoginWebProxy.h"

@implementation QY_LoginWebProxy

//账号注册
+ (void)doRegistSuccess:(void (^)(id response))success
                failure:(void (^)(NSError* err))failure
                 params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/user/registerByUserName"
                     params:params
                    success:success
                    failure:failure];
}
//登录
+ (void)doLoginSuccess:(void (^)(id response))success
               failure:(void (^)(NSError* err))failure
                params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/user/login"
                     params:params
                    success:success
                    failure:failure];
}
//随机用户名
+ (void)doRandomUserNameSuccess:(void (^)(id response))success
                        failure:(void (^)(NSError* err))failure
                         params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/user/generateAccount"
                     params:params
                    success:success
                    failure:failure];
}
//发送验证码 快速注册
+ (void)doSendSmsOfRegistSuccess:(void (^)(id response))success
                         failure:(void (^)(NSError* err))failure
                          params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/user/sendSmsOfRegister"
                     params:params
                    success:success
                    failure:failure];
}
//快速注册
+ (void)doQuickRegistSuccess:(void (^)(id response))success
                     failure:(void (^)(NSError* err))failure
                      params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/user/registerByMobile"
                     params:params
                    success:success
                    failure:failure];
}
//发送验证码 找回密码
+ (void)doSendSmsOfFoundSuccess:(void (^)(id response))success
                        failure:(void (^)(NSError* err))failure
                         params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/user/sendSmsOfFindPassword"
                     params:params
                    success:success
                    failure:failure];
}
//找回密码
+ (void)doFoundPasswordSuccess:(void (^)(id response))success
                       failure:(void (^)(NSError* err))failure
                        params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/user/findPassword"
                     params:params
                    success:success
                    failure:failure];
}
//token自动登录
+ (void)doAutoLoginSuccess:(void (^)(id response))success
                   failure:(void (^)(NSError* err))failure
                    params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/user/tokenLogin"
                     params:params
                    success:success
                    failure:failure];
}
//一键快速注册
+ (void)doOneQuickRegistSuccess:(void (^)(id response))success
                        failure:(void (^)(NSError* err))failure
                         params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/user/quickRegister"
                     params:params
                    success:success
                    failure:failure];
}
//一键登录
+ (void)doOneLoginSuccess:(void (^)(id response))success
                  failure:(void (^)(NSError* err))failure
                   params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/user/oneLogin"
                     params:params
                    success:success
                    failure:failure];
}

@end
