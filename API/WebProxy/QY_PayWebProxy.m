//
//  PayWebService.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/7/12.
//

#import "QY_PayWebProxy.h"

@implementation QY_PayWebProxy

//下单 生成订单
+ (void)doPlaceOrderSuccess:(void (^)(id response))success
                    failure:(void (^)(NSError* err))failure
                     params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/pay/placeOrder"
                     params:params
                    success:success
                    failure:failure];
}

//查询 订单结果
+ (void)doQueryOrderSuccess:(void (^)(id response))success
                    failure:(void (^)(NSError* err))failure
                     params:(NSDictionary *)params
{
    QY_WebProxyBase *baseWeb = [[QY_WebProxyBase alloc] init];
    [baseWeb requestWithURL:@"/pay/queryOrder"
                     params:params
                    success:success
                    failure:failure];
}

@end
