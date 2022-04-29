//
//  AuthApi.h
//  QianYu_SDK_IOS
//
//  Created by qianyu on 2019/11/27.
//  Copyright © 2019 qianyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QY_ResultBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface QY_AuthenticationAPI : NSObject

//请求Authentication
+ (void)doAuthentication:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;
//请求Certification
+ (void)doCertification:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;

@end

NS_ASSUME_NONNULL_END
