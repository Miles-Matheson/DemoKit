//
//  PayWebService.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/7/12.
//

#import <Foundation/Foundation.h>
#import "QY_WebProxyBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface QY_PayWebProxy : NSObject

//下单 生成订单
+ (void)doPlaceOrderSuccess:(void (^)(id response))success
                    failure:(void (^)(NSError* err))failure
                     params:(NSDictionary *)params;

//查询 订单结果
+ (void)doQueryOrderSuccess:(void (^)(id response))success
                  failure:(void (^)(NSError* err))failure
                   params:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
