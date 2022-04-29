//
//  PayController.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/19.
//
//  备注：支付管理器

#import "QY_ControllerBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface QY_PayController : QY_ControllerBase

@property (nonatomic, copy) void(^PayCallBack)(NSDictionary *resDictionary);

+ (instancetype)sharedPayController;

/**  @初始化payview */
- (void)InitPayView:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
