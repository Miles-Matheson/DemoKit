//
//  PayViewModel.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/7/12.
//

#import "QY_PayModel.h"
#import "QY_PayAPI.h"

@implementation QY_PayModel

//下单 生成订单
- (void)doPlaceOrderCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.requestTs forKey:@"requestTs"];
    [params setValue:self.uid forKey:@"uid"];
    [params setValue:self.token forKey:@"token"];
    
    [params setValue:self.callbackInfo forKey:@"callbackInfo"];
    [params setValue:self.amount forKey:@"amount"];
    [params setValue:self.itemId forKey:@"itemId"];
    [params setValue:self.itemName forKey:@"itemName"];
    [params setValue:self.roleId forKey:@"roleId"];
    [params setValue:self.roleName forKey:@"roleName"];
    [params setValue:self.serverId forKey:@"serverId"];
    [params setValue:self.roleLevel forKey:@"roleLevel"];
    [params setValue:self.serverName forKey:@"serverName"];
    [params setValue:self.cpOrderId forKey:@"cpOrderId"];
    [params setValue:self.notifyUrl forKey:@"notifyUrl"];
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_PayAPI doPlaceOrder:params withCompletion:^(QY_ResultBase * _Nonnull result) {
        if (result.success)
        {
            comResult.success = YES;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
        else
        {
            comResult.success = NO;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
    }];
}

//查询 订单结果
- (void)doQueryOrderCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.requestTs forKey:@"requestTs"];
    [params setValue:self.uid forKey:@"uid"];
    [params setValue:self.token forKey:@"token"];
    [params setValue:self.orderId forKey:@"orderId"];
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_PayAPI doQueryOrder:params withCompletion:^(QY_ResultBase * _Nonnull result) {
        if (result.success)
        {
            comResult.success = YES;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
        else
        {
            comResult.success = NO;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
    }];
}

@end
