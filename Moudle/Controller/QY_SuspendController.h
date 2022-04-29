//
//  SuspendController.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/24.
//

#import "QY_ControllerBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface QY_SuspendController : QY_ControllerBase

@property (nonatomic, copy) void(^AccountShow)(BOOL state);

+ (instancetype)sharedSuspendController;

/**  @初始化SuspendView */
- (void)InitSuspendView;

/**  @显示SuspendView */
- (void)ShowSuspendController;

/**  @隐藏SuspendView */
- (void)HideSuspendController;

/**  @销毁SuspendView */
- (void)DestroySuspendView;

@end

NS_ASSUME_NONNULL_END
