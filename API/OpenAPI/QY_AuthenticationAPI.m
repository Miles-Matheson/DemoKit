//
//  AuthApi.m
//  QianYu_SDK_IOS
//
//  Created by qianyu on 2019/11/27.
//  Copyright © 2019 qianyu. All rights reserved.
//

#import "QY_AuthenticationAPI.h"
#import "QY_AuthenticationWebProxy.h"

@implementation QY_AuthenticationAPI

//请求Authentication
+ (void)doAuthentication:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion
{
    [QY_AuthenticationWebProxy doAuthenticationSuccess:^(id  _Nonnull response) {
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
//请求Certification
+ (void)doCertification:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion
{
    [QY_AuthenticationWebProxy doCertificationSuccess:^(id  _Nonnull response) {
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
