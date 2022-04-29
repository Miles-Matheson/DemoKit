//
//  PayWebView.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/7/11.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PayWebViewDelegate <NSObject>

/**  @代理 支付成功 */
- (void)PaySuccessDelegate;
/**  @代理 支付失败 */
- (void)PayFailedDelegate;


@end

@interface PayWebView : BaseView

@property (nonatomic, weak) id <PayWebViewDelegate> delegate;

- (void)UpdatePayWebView:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
