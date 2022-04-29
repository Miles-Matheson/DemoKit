//
//  LoginView.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/13.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RegistViewDelegate <NSObject>

/**  @代理 切换登录页面 */
- (void)BackLoginDelegate;
/**  @代理 切换快速注册 */
- (void)BackQuickRegistDelegate;
/**  @代理 注册 -- 账号 密码*/
- (void)RequireRegist:(NSString *)name withPassword:(NSString *)password;
/**  @代理 更新键盘 */
- (void)UpdateKeyboardState;
/**  @代理 请求更新用户名 */
- (void)RequireRandomUserName;
/**  @一键快速注册 */
- (void)OneQuickRegistDelegate;

@end

@interface RegistView : BaseView

@property (nonatomic, weak) id <RegistViewDelegate> delegate;

/** @刷新 随机用户名*/
- (void)UpdateRandomUserName;
/** @设置 随机用户名*/
- (void)SetRandomUserName:(NSString *)userName;
/**  @更新一键快速注册 */
- (void)OneQuickRegistShow:(BOOL)bShow;

@end

NS_ASSUME_NONNULL_END
