//
//  SuspendLogo.h
//  SDK
//
//  Created by qianyu on 2019/6/26.
//  Copyright © 2019 com.qianyugame.pdby. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SuspendLogoDelegate <NSObject>

/**  @代理 隐藏SuspendView */
- (void)HideSuspendViewDelegate;
/**  @代理 更新SuspendView状态 */
- (void)UpdateSuspendViewDelegate:(CGRect)bRect;

@end

@interface SuspendLogo : BaseView

@property (nonatomic, weak) id <SuspendLogoDelegate> delegate;

//更新Suspend状态
- (void)UpdateSuspendState;
//移除Suspend状态
- (void)RemoveSuspendState;

@end

NS_ASSUME_NONNULL_END
