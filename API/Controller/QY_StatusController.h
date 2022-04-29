//
//  LoadController.h
//  SDK
//
//  Created by qianyu on 2019/6/28.
//  Copyright © 2019 com.qianyugame.pdby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QY_StatusController : NSObject

+ (instancetype)sharedLoadController;

/** @显示成功 */
- (void)showSuccessWithStatus:(NSString *)msg;

/** @显示失败 */
- (void)showErrorWithStatus:(NSString *)msg;

/** @加载状态 */
- (void)showWithStatus:(NSString * _Nonnull)msg;

/** @隐藏 */
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
