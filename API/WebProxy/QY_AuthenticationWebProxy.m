//
//  AuthWebService.m
//  QianYu_SDK_IOS
//
//  Created by qianyu on 2019/11/27.
//  Copyright © 2019 qianyu. All rights reserved.
//

#import "QY_AuthenticationWebProxy.h"

@implementation QY_AuthenticationWebProxy

//请求Authentication
+ (void)doAuthenticationSuccess:(void (^)(id response))success
                        failure:(void (^)(NSError* err))failure
                         params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/user/validateToken"
                     params:params
                    success:success
                    failure:failure];
}

//请求实名认证
+ (void)doCertificationSuccess:(void (^)(id response))success
                       failure:(void (^)(NSError* err))failure
                        params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/user/certification"
                     params:params
                    success:success
                    failure:failure];
}

@end
