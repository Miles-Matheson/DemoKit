//
//  AccountView.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/19.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ChangeBindViewDelegate <NSObject>

/**  @代理 返回绑定手机号页面 */
- (void)BackBindViewDelegate;
/**  @代理 发送验证码 */
- (void)SendCodeOfChangeBind:(NSString *)mobile withOldCode:(NSString *)oCode;
/**  @代理 绑定新手机号 */
- (void)ChangeBindNewMobile:(NSString *)mobile withNickName:(NSString *)nickname withOldCode:(NSString *)oCode withNewCode:(NSString *)nCode;
/**  @代理 更新键盘 */
- (void)UpdateKeyboardState;
/**  @代理 请求更新用户名 */
- (void)RequireRandomUserName;

@end

@interface ChangeBindView : BaseView

@property (nonatomic, weak) id <ChangeBindViewDelegate> delegate;

/** @验证码发送成功后 倒计时 */
- (void)RegetSendCodeAction:(NSNumber *)second;

/** @传递 验证一 验证码 */
- (void)PassMobileCodeAction:(NSString *)code;

/** @设置 随机用户名*/
- (void)SetRandomUserName:(NSString *)userName;

@end

NS_ASSUME_NONNULL_END
