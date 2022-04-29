//
//  BaseView.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/20.
//

#import <UIKit/UIKit.h>
#import "QY_CommonController.h"
#import "KeyController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseView : UIView

@property (nonatomic, assign) CGFloat nScreenW;
@property (nonatomic, assign) CGFloat nScreenH;

/** @销毁 */
- (void)DestroyView;

/** @隐藏键盘 */
- (void)SetEndEditing;

/** @页面出现 */
- (void)ViewDidAppear:(BOOL)isClean;

/** @页面消失 */
- (void)ViewDidDisappear;

@end

NS_ASSUME_NONNULL_END
