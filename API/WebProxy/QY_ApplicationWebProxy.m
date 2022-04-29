//
//  AppWebService.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/17.
//

#import "QY_ApplicationWebProxy.h"

@implementation QY_ApplicationWebProxy

//请求AppLication
+ (void)doAppLicationSuccess:(void (^)(id response))success
                     failure:(void (^)(NSError* err))failure
                      params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/user/applicationInit"
                     params:params
                    success:success
                    failure:failure];
}

@end
