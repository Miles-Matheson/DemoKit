//
//  PayViewModel.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/7/12.
//

#import "QY_ModelBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface QY_PayModel : QY_ModelBase

@property (nonatomic, copy) NSString * appId;
@property (nonatomic, copy) NSString * requestTs;
@property (nonatomic, copy) NSString * uid;
@property (nonatomic, copy) NSString * token;

@property (nonatomic, copy) NSString * callbackInfo;
@property (nonatomic, copy) NSString * amount;
@property (nonatomic, copy) NSString * itemId;
@property (nonatomic, copy) NSString * itemName;
@property (nonatomic, copy) NSString * roleId;
@property (nonatomic, copy) NSString * roleName;
@property (nonatomic, copy) NSString * roleLevel;
@property (nonatomic, copy) NSString * serverId;
@property (nonatomic, copy) NSString * serverName;
@property (nonatomic, copy) NSString * cpOrderId;
@property (nonatomic, copy) NSString * notifyUrl;

@property (nonatomic, copy) NSString * payway;
@property (nonatomic, copy) NSString * orderId;

//下单 生成订单
- (void)doPlaceOrderCompleted:(void(^)(QY_ResultBase *result))onCompleted;

//查询 订单结果
- (void)doQueryOrderCompleted:(void(^)(QY_ResultBase *result))onCompleted;

@end

NS_ASSUME_NONNULL_END
