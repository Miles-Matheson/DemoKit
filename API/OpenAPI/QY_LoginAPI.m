//
//  LoginApi.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/17.
//

#import "QY_LoginAPI.h"
#import "QY_LoginWebProxy.h"

@implementation QY_LoginAPI

//账号注册
+ (void)doRegist:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion
{
    [QY_LoginWebProxy doRegistSuccess:^(id  _Nonnull response) {
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
//登录
+ (void)doLogin:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion
{
    [QY_LoginWebProxy doLoginSuccess:^(id  _Nonnull response) {
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
//随机用户名
+ (void)doRandomUserName:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion
{
    [QY_LoginWebProxy doRandomUserNameSuccess:^(id  _Nonnull response) {
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
//发送验证码 快速注册
+ (void)doSendSmsOfRegist:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion
{
    [QY_LoginWebProxy doSendSmsOfRegistSuccess:^(id  _Nonnull response) {
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
//快速注册
+ (void)doQuickRegist:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion
{
    [QY_LoginWebProxy doQuickRegistSuccess:^(id  _Nonnull response) {
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
//发送验证码 找回密码
+ (void)doSendSmsOfFound:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion
{
    [QY_LoginWebProxy doSendSmsOfFoundSuccess:^(id  _Nonnull response) {
        QY_ResultBase *result = [[QY_ResultBase alloc] init];
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        if ([code isEqualToString:@"SUCCESS"]) {
            result.success = YES;
            result.msg = response[@"value"];
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
//找回密码
+ (void)doFoundPassword:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion
{
    [QY_LoginWebProxy doFoundPasswordSuccess:^(id  _Nonnull response) {
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
//token自动登录
+ (void)doAutoLogin:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion
{
    [QY_LoginWebProxy doAutoLoginSuccess:^(id  _Nonnull response) {
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
//一键快速注册
+ (void)doOneQucikRegist:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion
{
    [QY_LoginWebProxy doOneQuickRegistSuccess:^(id  _Nonnull response) {
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
//一键登录
+ (void)doOneLogin:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion
{
    [QY_LoginWebProxy doOneLoginSuccess:^(id  _Nonnull response) {
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
