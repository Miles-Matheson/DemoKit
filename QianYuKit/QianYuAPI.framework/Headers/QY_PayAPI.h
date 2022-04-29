//
//  PayApi.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/7/12.
//

#import <Foundation/Foundation.h>
#import "QY_ResultBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface QY_PayAPI : NSObject

//下单 生成订单
+ (void)doPlaceOrder:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;

//查询 订单结果
+ (void)doQueryOrder:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;

@end

NS_ASSUME_NONNULL_END
