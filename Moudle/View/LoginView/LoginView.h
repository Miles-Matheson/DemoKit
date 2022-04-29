//
//  LoginView.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/13.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LoginViewDelegate <NSObject>

/**  @代理 退出登录页面 */
- (void)QuitActionDelegate;
/**  @代理 切换快速注册 */
- (void)BackQuickRegistDelegate;
/**  @代理 切换找回密码 */
- (void)BackFoundPasswordDelegate;
/**  @代理 移除下拉列表数据 */
- (void)RemoveUserListDelegate:(NSInteger)indexCell;
/**  @代理 登录 -- uid token */
- (void)RequireLoginByToken:(NSString *)passport withUid:(NSString *)uid withToken:(NSString *)token;
/**  @代理 登录 -- 账号 密码 */
- (void)RequireLogin:(NSString *)passport withPassword:(NSString *)password;
/**  @代理 更新键盘 */
- (void)UpdateKeyboardState;
/**  @一键快速注册 */
- (void)OneQuickRegistDelegate;
/**  @自动登录 */
- (void)AutoLoginDelegate;

@end

@interface LoginView : BaseView

@property (nonatomic, weak) id <LoginViewDelegate> delegate;

/**  @更新用户信息 */
- (void)UpdateUserList:(nullable NSDictionary *)myInfo withUserList:(NSArray *)userList;
/**  @更新一键快速注册 */
- (void)OneQuickRegistShow:(BOOL)bShow;

@end

NS_ASSUME_NONNULL_END
