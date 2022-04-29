
//
//  AccountApi.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/20.
//

#import <Foundation/Foundation.h>
#import "QY_ResultBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface QY_AccountAPI : NSObject

//普通用户修改密码
+ (void)doChangePasswordOfUser:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;
//普通用户绑定手机号 发送验证码
+ (void)doSendCodeOfUserBindMobile:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;
//普通用户绑定手机号
+ (void)doBindMobileOfUser:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;


//手机用户修改密码 发送验证码
+ (void)doSendCodeOfMotileToChangePassword:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;
//手机用户修改密码
+ (void)doChangePasswordOfMobile:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;
//手机用户变更手机号 发验证码1
+ (void)doSendCodeOfMobileOld:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;
//手机用户变更手机号 验证验证码1
+ (void)doBindMobileOfMobileOld:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;
//手机用户变更手机号 发验证码2
+ (void)doSendCodeOfMobileNew:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;
//手机用户变更手机号 验证验证码2
+ (void)doBindMobileOfMobileNew:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;

//查询小号列表
+ (void)doGetSubUserList:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;
//选择小号
+ (void)doSelectSubUser:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;
//创建小号
+ (void)doCreateSubUser:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;
//上报数据
+ (void)doReportGameData:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;

@end

NS_ASSUME_NONNULL_END
