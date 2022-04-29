//
//  ChangeAccountView.h
//  QianYu_SDK_IOS
//
//  Created by qianyu on 2019/10/9.
//  Copyright © 2019 qianyu. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ChangeAccountViewDelegate <NSObject>

/**  @代理 返回账号管理页面 */
- (void)BackAccountDelegate;
/**  @代理 新建小号 */
- (void)CreateSubUserDelegate:(NSString *)nickName;
/**  @代理 选择小号 */
- (void)SelectedSubUserDelegate:(NSString *)subPid;

@end

@interface ChangeAccountView : BaseView

@property (nonatomic, weak) id <ChangeAccountViewDelegate> delegate;

//刷新小号列表
- (void)UpdateSubUserTableView:(NSArray *)userList;
//新增小号
- (void)InsertSubUserInfo:(NSDictionary *)userInfo;
//更新选中小号状态
- (void)UpdateSubUserState:(NSString *)subPid;

@end

NS_ASSUME_NONNULL_END
