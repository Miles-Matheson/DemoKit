//
//  AuthWebService.h
//  QianYu_SDK_IOS
//
//  Created by qianyu on 2019/11/27.
//  Copyright © 2019 qianyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QY_WebProxyBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface QY_AuthenticationWebProxy : NSObject

//请求Authentication
+ (void)doAuthenticationSuccess:(void (^)(id response))success
                        failure:(void (^)(NSError* err))failure
                         params:(NSDictionary *)params;
//请求实名认证
+ (void)doCertificationSuccess:(void (^)(id response))success
                       failure:(void (^)(NSError* err))failure
                        params:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
