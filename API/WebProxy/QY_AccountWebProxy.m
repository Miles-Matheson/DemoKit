//
//  AccountWebService.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/20.
//

#import "QY_AccountWebProxy.h"

@implementation QY_AccountWebProxy

//普通用户修改密码
+ (void)doChangePasswordOfUserSuccess:(void (^)(id response))success
                              failure:(void (^)(NSError* err))failure
                               params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/user/changePassword"
                     params:params
                    success:success
                    failure:failure];
}
//普通用户绑定手机 发送验证码
+ (void)doSendCodeOfUserBindMobileSuccess:(void (^)(id response))success
                                  failure:(void (^)(NSError* err))failure
                                   params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/user/sendSmsOfBind"
                     params:params
                    success:success
                    failure:failure];
}
//普通用户绑定手机
+ (void)doBindMobileOfUserSuccess:(void (^)(id response))success
                          failure:(void (^)(NSError* err))failure
                           params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/user/bindMobile"
                     params:params
                    success:success
                    failure:failure];
}


//手机用户修改密码 发送验证码
+ (void)doSendCodeOfMobileToChangePasswordSuccess:(void (^)(id response))success
                                          failure:(void (^)(NSError* err))failure
                                           params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/user/sendSmsOfChangePassword"
                     params:params
                    success:success
                    failure:failure];
}
//手机用户修改密码
+ (void)doChangePasswordOfMobileSuccess:(void (^)(id response))success
                                failure:(void (^)(NSError* err))failure
                                 params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/user/changePasswordForMobile"
                     params:params
                    success:success
                    failure:failure];
}
//手机用户变更手机号 发送验证码1
+ (void)doSendCodeOfMobileOldSuccess:(void (^)(id response))success
                             failure:(void (^)(NSError* err))failure
                              params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/user/sendSmsOfChangeMobile1"
                     params:params
                    success:success
                    failure:failure];
}
//手机用户变更手机号 验证验证码1
+ (void)doBindMobileOfMobileOldSuccess:(void (^)(id response))success
                               failure:(void (^)(NSError* err))failure
                                params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/user/changeMobile1"
                     params:params
                    success:success
                    failure:failure];
}
//手机用户变更手机号 发送验证码2
+ (void)doSendCodeOfMobileNewSuccess:(void (^)(id response))success
                             failure:(void (^)(NSError* err))failure
                              params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/user/sendSmsOfChangeMobile2"
                     params:params
                    success:success
                    failure:failure];
}
//手机用户变更手机号 验证验证码2
+ (void)doBindMobileOfMobileNewSuccess:(void (^)(id response))success
                               failure:(void (^)(NSError* err))failure
                                params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/user/changeMobile2"
                     params:params
                    success:success
                    failure:failure];
}

//获取小号列表
+ (void)doGetSubUserListSuccess:(void (^)(id response))success
                        failure:(void (^)(NSError* err))failure
                         params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/user/getSubUserList"
                     params:params
                    success:success
                    failure:failure];
}
//选择某个小号
+ (void)doChooseSubUserSuccess:(void (^)(id response))success
                       failure:(void (^)(NSError* err))failure
                        params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/user/selectSubUser"
                     params:params
                    success:success
                    failure:failure];
}
//创建某个小号
+ (void)doCreateSubUserSuccess:(void (^)(id response))success
                       failure:(void (^)(NSError* err))failure
                        params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/user/createSubUser"
                     params:params
                    success:success
                    failure:failure];
}
//上报数据
+ (void)doReportGameDataSuccess:(void (^)(id response))success
                       failure:(void (^)(NSError* err))failure
                        params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/user/updateRole"
                     params:params
                    success:success
                    failure:failure];
}

@end
