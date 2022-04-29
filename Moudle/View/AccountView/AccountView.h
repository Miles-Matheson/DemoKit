//
//  AccountView.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/19.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AccountViewDelegate <NSObject>

/**  @代理 关闭账号管理页面 */
- (void)QuitActionDelegate;
/**  @代理 跳转绑定页面 */
- (void)JumpBindViewDelegate;
/**  @代理 跳转修改密码页面 */
- (void)JumpChangePasswordViewDelegate;
/**  @代理 退出账号 */
- (void)LoginOutDelegate;
/**  @代理 切换小号 */
- (void)ChangeAccountDelegate;

@end

@interface AccountView : BaseView

@property (nonatomic, weak) id <AccountViewDelegate> delegate;

/** @更新绑定页面 bind or newbind */
- (void)UpdateBindModeByMobile:(NSString *)mobile withName:(NSString *)name;
/** @设置客服电话和QQ */
- (void)SetServiceInfo:(NSString *)qqService withPhone:(NSString *)phoneService;
/** @更新修改密码按钮文字 */
- (void)UpdateChangePasswordState;

@end

NS_ASSUME_NONNULL_END
