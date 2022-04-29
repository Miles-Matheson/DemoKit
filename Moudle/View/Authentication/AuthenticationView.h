//
//  AuthenticationView.h
//  QianYu_SDK_IOS
//
//  Created by qianyu on 2019/11/26.
//  Copyright © 2019 qianyu. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AuthenticationViewDelegate <NSObject>

/**  @代理 更新键盘 */
- (void)UpdateKeyboardState;
/**  @代理 返回按钮 */
- (void)UpdateBackDelegate;
/**  @代理 关闭按钮 */
- (void)UpdateCloseDelegate;
/**  @代理 实名认证 -- 姓名 身份证*/
- (void)AuthAction:(NSString *)userName withNumber:(NSString *)userNumber;

@end

@interface AuthenticationView : BaseView

@property (nonatomic, weak) id <AuthenticationViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
