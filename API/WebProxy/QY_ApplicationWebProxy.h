//
//  AppWebService.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/17.
//

#import <Foundation/Foundation.h>
#import "QY_WebProxyBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface QY_ApplicationWebProxy : NSObject

//请求AppLication
+ (void)doAppLicationSuccess:(void (^)(id response))success
                     failure:(void (^)(NSError* err))failure
                      params:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
