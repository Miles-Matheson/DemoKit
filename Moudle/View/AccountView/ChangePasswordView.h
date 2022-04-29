//
//  AccountView.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/19.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ChangePasswordViewDelegate <NSObject>

/**  @代理 返回账号管理页面 */
- (void)BackAccountDelegate;
/**  @代理 修改密码 */
- (void)ChangePassword:(NSString *)oPassword withNew:(NSString *)nPassword withReNew:(NSString *)sPassword;
/**  @代理 更新键盘 */
- (void)UpdateKeyboardState;

@end

@interface ChangePasswordView : BaseView

@property (nonatomic, weak) id <ChangePasswordViewDelegate> delegate;

/** @无密码则隐藏第一行 */
- (void)UpdateChangePasswordState;

@end

NS_ASSUME_NONNULL_END
