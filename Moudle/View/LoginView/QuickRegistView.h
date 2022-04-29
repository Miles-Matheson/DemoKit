//
//  LoginView.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/13.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol QuickRegistViewDelegate <NSObject>

/**  @代理 切换登录页面 */
- (void)BackLoginDelegate;
/**  @代理 切换注册页面 */
- (void)BackRegistDelegate;
/**  @代理 发送验证码 */
- (void)RequireSendCodeOfQuickRegist:(NSString *)mobile;
/**  @代理 快速注册 -- 手机号码 密码 验证码 */
- (void)RequireQuickRegist:(NSString *)mobile withPassword:(NSString *)password withCode:(NSString *)code;
/**  @代理 更新键盘 */
- (void)UpdateKeyboardState;
/**  @一键快速注册 */
- (void)OneQuickRegistDelegate;

@end

@interface QuickRegistView : BaseView

@property (nonatomic, weak) id <QuickRegistViewDelegate> delegate;

/** @验证码发送成功后 倒计时 */
- (void)RegetSendCodeAction:(NSNumber *)second;
/**  @更新一键快速注册 */
- (void)OneQuickRegistShow:(BOOL)bShow;

@end

NS_ASSUME_NONNULL_END
