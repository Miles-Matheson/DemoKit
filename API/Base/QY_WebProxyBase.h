//
//  BaseWebService.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QY_WebProxyBase : NSObject

- (void) requestWithURL:(NSString *)url
                 params:(NSDictionary *)params
                success:(void (^)(id response))success
                failure:(void (^)(NSError *err))failure;

@end

NS_ASSUME_NONNULL_END
