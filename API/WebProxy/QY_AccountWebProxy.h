//
//  AccountWebService.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/20.
//
//  备注：WebService主要配置请求的url

#import <Foundation/Foundation.h>
#import "QY_WebProxyBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface QY_AccountWebProxy : NSObject

//普通用户修改密码
+ (void)doChangePasswordOfUserSuccess:(void (^)(id response))success
                              failure:(void (^)(NSError* err))failure
                               params:(NSDictionary *)params;
//普通用户绑定手机 发送验证码
+ (void)doSendCodeOfUserBindMobileSuccess:(void (^)(id response))success
                                  failure:(void (^)(NSError* err))failure
                                   params:(NSDictionary *)params;
//普通用户绑定手机
+ (void)doBindMobileOfUserSuccess:(void (^)(id response))success
                          failure:(void (^)(NSError* err))failure
                           params:(NSDictionary *)params;


//手机用户修改密码 发送验证码
+ (void)doSendCodeOfMobileToChangePasswordSuccess:(void (^)(id response))success
                                          failure:(void (^)(NSError* err))failure
                                           params:(NSDictionary *)params;
//手机用户修改密码
+ (void)doChangePasswordOfMobileSuccess:(void (^)(id response))success
                                failure:(void (^)(NSError* err))failure
                                 params:(NSDictionary *)params;
//手机用户变更手机号 发送验证码1
+ (void)doSendCodeOfMobileOldSuccess:(void (^)(id response))success
                             failure:(void (^)(NSError* err))failure
                              params:(NSDictionary *)params;
//手机用户变更手机号 验证验证码1
+ (void)doBindMobileOfMobileOldSuccess:(void (^)(id response))success
                               failure:(void (^)(NSError* err))failure
                                params:(NSDictionary *)params;
//手机用户变更手机号 发送验证码2
+ (void)doSendCodeOfMobileNewSuccess:(void (^)(id response))success
                             failure:(void (^)(NSError* err))failure
                              params:(NSDictionary *)params;
//手机用户变更手机号 验证验证码2
+ (void)doBindMobileOfMobileNewSuccess:(void (^)(id response))success
                               failure:(void (^)(NSError* err))failure
                                params:(NSDictionary *)params;


//获取小号列表
+ (void)doGetSubUserListSuccess:(void (^)(id response))success
                        failure:(void (^)(NSError* err))failure
                         params:(NSDictionary *)params;
//选择某个小号
+ (void)doChooseSubUserSuccess:(void (^)(id response))success
                       failure:(void (^)(NSError* err))failure
                        params:(NSDictionary *)params;
//创建某个小号
+ (void)doCreateSubUserSuccess:(void (^)(id response))success
                       failure:(void (^)(NSError* err))failure
                        params:(NSDictionary *)params;
//上报数据
+ (void)doReportGameDataSuccess:(void (^)(id response))success
                       failure:(void (^)(NSError* err))failure
                        params:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
