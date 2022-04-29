//
//  LoginView.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/13.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FoundViewDelegate <NSObject>

/**  @代理 切换登录页面 */
- (void)BackLoginDelegate;
/**  @代理 发送验证码 */
- (void)RequireSendCodeOfFoundPassword:(NSString *)mobile;
/**  @代理 找回密码 -- 手机号码 验证码 新密码 */
- (void)RequireFound:(NSString *)phone withPassword:(NSString *)password withCode:(NSString *)code;
/**  @代理 更新键盘 */
- (void)UpdateKeyboardState;

@end

@interface FoundView : BaseView

@property (nonatomic, weak) id <FoundViewDelegate> delegate;

/** @验证码发送成功后 倒计时 */
- (void)RegetSendCodeAction:(NSNumber *)second;
/** @设置客服电话和QQ */
- (void)SetServiceInfo:(NSString *)qqService withPhone:(NSString *)phoneService;

@end

NS_ASSUME_NONNULL_END
