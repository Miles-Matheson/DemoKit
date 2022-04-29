//
//  AccountView.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/19.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ChangePasswordMobileViewDelegate <NSObject>

/**  @代理 返回账号管理页面 */
- (void)BackAccountDelegate;
/**  @代理 发送验证码 */
- (void)SendCodeOfChangePasswordOfMobile;
/**  @代理 手机用户 修改密码 */
- (void)ChangePasswordOfMobile:(NSString *)code withPassword:(NSString *)password;
/**  @代理 更新键盘 */
- (void)UpdateKeyboardState;

@end

@interface ChangePasswordMobileView : BaseView

@property (nonatomic, weak) id <ChangePasswordMobileViewDelegate> delegate;

/** @验证码发送成功后 倒计时 */
- (void)RegetSendCodeAction:(NSNumber *)second;

/** @更新页面手机号 */
- (void)UpdateChangePasswordMobileViewByMobile:(NSString *)mobile;

@end

NS_ASSUME_NONNULL_END
