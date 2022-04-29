//
//  AccountApi.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/20.
//

#import "QY_AccountAPI.h"
#import "QY_AccountWebProxy.h"

@implementation QY_AccountAPI

//普通用户修改密码
+ (void)doChangePasswordOfUser:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion
{
    [QY_AccountWebProxy doChangePasswordOfUserSuccess:^(id  _Nonnull response) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        if ([code isEqualToString:@"SUCCESS"]) {
            result.success = YES;
            result.msg = @"";
            result.result = response[@"value"];
        }else{
            result.success = NO;
            result.msg = [NSString stringWithFormat:@"%@",response[@"i18NDesc"]];
            result.result = response[@"traceId"];
        }
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completion(result);
            });
        }
    } failure:^(NSError * _Nonnull err) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        result.success = NO;
        result.msg = [result netErrorString:err];
        result.result = err;
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completion(result);
            });
        }
    } params:params];
}
//普通用户绑定手机号 发送验证码
+ (void)doSendCodeOfUserBindMobile:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion
{
    [QY_AccountWebProxy doSendCodeOfUserBindMobileSuccess:^(id  _Nonnull response) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        if ([code isEqualToString:@"SUCCESS"]) {
            result.success = YES;
            result.msg = @"";
            result.result = response[@"value"];
        }else{
            result.success = NO;
            result.msg = [NSString stringWithFormat:@"%@",response[@"i18NDesc"]];
            result.result = response[@"traceId"];
        }
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completion(result);
            });
        }
    } failure:^(NSError * _Nonnull err) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        result.success = NO;
        result.msg = [result netErrorString:err];
        result.result = err;
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completion(result);
            });
        }
    } params:params];
}
//普通用户绑定手机号
+ (void)doBindMobileOfUser:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion
{
    [QY_AccountWebProxy doBindMobileOfUserSuccess:^(id  _Nonnull response) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        if ([code isEqualToString:@"SUCCESS"]) {
            result.success = YES;
            result.msg = @"";
            result.result = response[@"value"];
        }else{
            result.success = NO;
            result.msg = [NSString stringWithFormat:@"%@",response[@"i18NDesc"]];
            result.result = response[@"traceId"];
        }
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completion(result);
            });
        }
    } failure:^(NSError * _Nonnull err) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        result.success = NO;
        result.msg = [result netErrorString:err];
        result.result = err;
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completion(result);
            });
        }
    } params:params];
}


//手机用户修改密码 发送验证码
+ (void)doSendCodeOfMotileToChangePassword:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion
{
    [QY_AccountWebProxy doSendCodeOfMobileToChangePasswordSuccess:^(id  _Nonnull response) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        if ([code isEqualToString:@"SUCCESS"]) {
            result.success = YES;
            result.msg = @"";
            result.result = response[@"value"];
        }else{
            result.success = NO;
            result.msg = [NSString stringWithFormat:@"%@",response[@"i18NDesc"]];
            result.result = response[@"traceId"];
        }
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completion(result);
            });
        }
    } failure:^(NSError * _Nonnull err) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        result.success = NO;
        result.msg = [result netErrorString:err];
        result.result = err;
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completion(result);
            });
        }
    } params:params];
}
//手机用户修改密码
+ (void)doChangePasswordOfMobile:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion
{
    [QY_AccountWebProxy doChangePasswordOfMobileSuccess:^(id  _Nonnull response) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        if ([code isEqualToString:@"SUCCESS"]) {
            result.success = YES;
            result.msg = @"";
            result.result = response[@"value"];
        }else{
            result.success = NO;
            result.msg = [NSString stringWithFormat:@"%@",response[@"i18NDesc"]];
            result.result = response[@"traceId"];
        }
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completion(result);
            });
        }
    } failure:^(NSError * _Nonnull err) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        result.success = NO;
        result.msg = [result netErrorString:err];
        result.result = err;
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completion(result);
            });
        }
    } params:params];
}
//手机用户变更手机号 发验证码1
+ (void)doSendCodeOfMobileOld:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion
{
    [QY_AccountWebProxy doSendCodeOfMobileOldSuccess:^(id  _Nonnull response) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        if ([code isEqualToString:@"SUCCESS"]) {
            result.success = YES;
            result.msg = @"";
            result.result = response[@"value"];
        }else{
            result.success = NO;
            result.msg = [NSString stringWithFormat:@"%@",response[@"i18NDesc"]];
            result.result = response[@"traceId"];
        }
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completion(result);
            });
        }
    } failure:^(NSError * _Nonnull err) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        result.success = NO;
        result.msg = [result netErrorString:err];
        result.result = err;
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completion(result);
            });
        }
    } params:params];
}
//手机用户变更手机号 验证验证码1
+ (void)doBindMobileOfMobileOld:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion
{
    [QY_AccountWebProxy doBindMobileOfMobileOldSuccess:^(id  _Nonnull response) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        if ([code isEqualToString:@"SUCCESS"]) {
            result.success = YES;
            result.msg = @"";
            result.result = response[@"value"];
        }else{
            result.success = NO;
            result.msg = [NSString stringWithFormat:@"%@",response[@"i18NDesc"]];
            result.result = response[@"traceId"];
        }
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completion(result);
            });
        }
    } failure:^(NSError * _Nonnull err) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        result.success = NO;
        result.msg = [result netErrorString:err];
        result.result = err;
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completion(result);
            });
        }
    } params:params];
}
//手机用户变更手机号 发验证码2
+ (void)doSendCodeOfMobileNew:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion
{
    [QY_AccountWebProxy doSendCodeOfMobileNewSuccess:^(id  _Nonnull response) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        if ([code isEqualToString:@"SUCCESS"]) {
            result.success = YES;
            result.msg = @"";
            result.result = response[@"value"];
        }else{
            result.success = NO;
            result.msg = [NSString stringWithFormat:@"%@",response[@"i18NDesc"]];
            result.result = response[@"traceId"];
        }
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completion(result);
            });
        }
    } failure:^(NSError * _Nonnull err) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        result.success = NO;
        result.msg = [result netErrorString:err];
        result.result = err;
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completion(result);
            });
        }
    } params:params];
}
//手机用户变更手机号 验证验证码2
+ (void)doBindMobileOfMobileNew:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion
{
    [QY_AccountWebProxy doBindMobileOfMobileNewSuccess:^(id  _Nonnull response) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        if ([code isEqualToString:@"SUCCESS"]) {
            result.success = YES;
            result.msg = @"";
            result.result = response[@"value"];
        }else{
            result.success = NO;
            result.msg = [NSString stringWithFormat:@"%@",response[@"i18NDesc"]];
            result.result = response[@"traceId"];
        }
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completion(result);
            });
        }
    } failure:^(NSError * _Nonnull err) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        result.success = NO;
        result.msg = [result netErrorString:err];
        result.result = err;
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completion(result);
            });
        }
    } params:params];
}

//查询小号列表
+ (void)doGetSubUserList:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion
{
    [QY_AccountWebProxy doGetSubUserListSuccess:^(id  _Nonnull response) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        if ([code isEqualToString:@"SUCCESS"]) {
            result.success = YES;
            result.msg = @"";
            result.result = response[@"value"];
        }else{
            result.success = NO;
            result.msg = [NSString stringWithFormat:@"%@",response[@"i18NDesc"]];
            result.result = response[@"traceId"];
        }
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completion(result);
            });
        }
    } failure:^(NSError * _Nonnull err) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        result.success = NO;
        result.msg = [result netErrorString:err];
        result.result = err;
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completion(result);
            });
        }
    } params:params];
}
//选择小号
+ (void)doSelectSubUser:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion
{
    [QY_AccountWebProxy doChooseSubUserSuccess:^(id  _Nonnull response) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        if ([code isEqualToString:@"SUCCESS"]) {
            result.success = YES;
            result.msg = @"";
            result.result = response[@"value"];
        }else{
            result.success = NO;
            result.msg = [NSString stringWithFormat:@"%@",response[@"i18NDesc"]];
            result.result = response[@"traceId"];
        }
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completion(result);
            });
        }
    } failure:^(NSError * _Nonnull err) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        result.success = NO;
        result.msg = [result netErrorString:err];
        result.result = err;
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completion(result);
            });
        }
    } params:params];
}
//创建小号
+ (void)doCreateSubUser:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion
{
    [QY_AccountWebProxy doCreateSubUserSuccess:^(id  _Nonnull response) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        if ([code isEqualToString:@"SUCCESS"]) {
            result.success = YES;
            result.msg = @"";
            result.result = response[@"value"];
        }else{
            result.success = NO;
            result.msg = [NSString stringWithFormat:@"%@",response[@"i18NDesc"]];
            result.result = response[@"traceId"];
        }
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completion(result);
            });
        }
    } failure:^(NSError * _Nonnull err) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        result.success = NO;
        result.msg = [result netErrorString:err];
        result.result = err;
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completion(result);
            });
        }
    } params:params];
}
//上报数据
+ (void)doReportGameData:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion
{
    [QY_AccountWebProxy doReportGameDataSuccess:^(id  _Nonnull response) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        if ([code isEqualToString:@"SUCCESS"]) {
            result.success = YES;
            result.msg = @"";
            result.result = response[@"value"];
        }else{
            result.success = NO;
            result.msg = [NSString stringWithFormat:@"%@",response[@"i18NDesc"]];
            result.result = response[@"traceId"];
        }
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completion(result);
            });
        }
    } failure:^(NSError * _Nonnull err) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        result.success = NO;
        result.msg = [result netErrorString:err];
        result.result = err;
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completion(result);
            });
        }
    } params:params];
}

@end
