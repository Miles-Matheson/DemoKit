//
//  PayModeView.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/25.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PayModeViewDelegate <NSObject>

/**  @代理 返回支付页面 */
- (void)BackPayDelegate;
/**  @代理 更新支付模式 */
- (void)UpdatePayModeDelegate:(NSDictionary *)info;

@end

@interface PayModeView : BaseView

@property (nonatomic, weak) id <PayModeViewDelegate> delegate;

/**  @更新tableview */
- (void)UpdateTableViewData:(NSArray *)tPayArray;

@end

NS_ASSUME_NONNULL_END
