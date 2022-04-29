//
//  PayApi.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/7/12.
//

#import "QY_PayAPI.h"
#import "QY_PayWebProxy.h"

@implementation QY_PayAPI

//下单 生成订单
+ (void)doPlaceOrder:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion
{
    [QY_PayWebProxy doPlaceOrderSuccess:^(id  _Nonnull response) {
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

//查询 订单结果
+ (void)doQueryOrder:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;
{
    [QY_PayWebProxy doQueryOrderSuccess:^(id  _Nonnull response) {
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
