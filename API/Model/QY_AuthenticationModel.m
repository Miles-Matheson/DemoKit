//
//  AuthViewModel.m
//  QianYu_SDK_IOS
//
//  Created by qianyu on 2019/11/27.
//  Copyright © 2019 qianyu. All rights reserved.
//

#import "QY_AuthenticationModel.h"

@implementation QY_AuthenticationModel

//请求Authentication
- (void)doAuthenticationCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.requestTs forKey:@"requestTs"];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.uid forKey:@"uid"];
    [params setValue:self.token forKey:@"token"];
    [params setValue:@(self.noLoad) forKey:@"noLoad"];
    self.noLoad = NO;
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_AuthenticationAPI doAuthentication:params withCompletion:^(QY_ResultBase * _Nonnull result) {
        if (result.success)
        {
            comResult.success = YES;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
        else
        {
            comResult.success = NO;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
    }];
}

//请求Certification
- (void)doCertificationCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.requestTs forKey:@"requestTs"];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.uid forKey:@"uid"];
    [params setValue:self.token forKey:@"token"];
    [params setValue:self.realName forKey:@"realName"];
    [params setValue:self.idCardNo forKey:@"idCardNo"];
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_AuthenticationAPI doCertification:params withCompletion:^(QY_ResultBase * _Nonnull result) {
        if (result.success)
        {
            comResult.success = YES;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
        else
        {
            comResult.success = NO;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
    }];
}

@end
