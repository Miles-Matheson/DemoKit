//
//  PayView.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/19.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PayViewDelegate <NSObject>

/**  @代理 退出支付页面 */
- (void)QuitPayDelegate;
/**  @代理 选择其他支付方式 */
- (void)ChangePayModeDelegate;
/**  @代理 支付功能 */
- (void)PayDelegate;

@end

@interface PayView : BaseView

@property (nonatomic, weak) id <PayViewDelegate> delegate;
@property (nonatomic, copy) void(^PayTypeBlock)(NSString *tPay);

/** @初始化支付信息 */
- (void)InitPayView:(NSDictionary *)data withMainPay:(NSDictionary *)mainPay;

/**  @更新支付信息 */
- (void)UpdatePayModeInfo:(NSDictionary *)payInfo;

@end

NS_ASSUME_NONNULL_END
