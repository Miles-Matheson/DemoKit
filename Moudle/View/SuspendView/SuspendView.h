//
//  SuspendView.h
//  SDK
//
//  Created by qianyu on 2019/6/26.
//  Copyright © 2019 com.qianyugame.pdby. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SuspendViewDelegate <NSObject>

/**  @代理 显示账号管理 */
- (void)ShowAccountViewDelegate;
/**  @代理 隐藏悬浮图标 */
- (void)HideSuspendControllerDelegate;

@end

@interface SuspendView : BaseView

@property (nonatomic, weak) id <SuspendViewDelegate> delegate;

//隐藏SuspendView
- (void)HideSuspendView;
//更新Suspend状态
- (void)UpdateSuspendState:(CGRect)bRect;


@end

NS_ASSUME_NONNULL_END
