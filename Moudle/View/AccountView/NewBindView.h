//
//  AccountView.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/19.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NewBindViewDelegate <NSObject>

/**  @代理 返回账号管理页面 */
- (void)BackAccountDelegate;
/**  @代理 发送验证码 */
- (void)SendCodeOfNewBind:(NSString *)mobile;
/**  @代理 绑定新手机号 */
- (void)NewBindNewMobile:(NSString *)mobile withCode:(NSString *)code;
/**  @代理 更新键盘 */
- (void)UpdateKeyboardState;

@end

@interface NewBindView : BaseView

@property (nonatomic, weak) id <NewBindViewDelegate> delegate;

/** @验证码发送成功后 倒计时 */
- (void)RegetSendCodeAction:(NSNumber *)second;

@end

NS_ASSUME_NONNULL_END
