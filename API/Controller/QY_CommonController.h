//
//  ComController.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/7/3.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QY_CommonController : NSObject

+ (instancetype)sharedComController;

/** @获取NSBundle */
- (NSBundle *)GetCurrentBundle;

/** @获取UIImage */
- (UIImage *)GetCurrentImage:(NSString *)name;

#pragma mark - LoadController
/** @显示成功 */
- (void)showSuccessWithStatus:(NSString *)msg;

/** @显示失败 */
- (void)showErrorWithStatus:(NSString *)msg;

/** @加载状态 */
- (void)showWithStatus:(NSString * _Nonnull)msg;

/** @隐藏 */
- (void)dismiss;

#pragma mark - 通用功能
/** @将View转化为Image */
- (UIImage *)imageFromView:(UIView *)view;

/** 密码小眼睛 */
- (void)SetTextFieldEye:(UITextField *)field withButton:(UIButton *)button;

/** 获取textField的Rect */
- (UITextField *)GetTextFieldFirstResponder:(UIView *)parentView;

/** 设置富文本颜色 */
- (NSMutableAttributedString *)SetOneTitle:(NSString *)oneTitle oneColor:(UIColor *)oneColor twoTitle:(NSString *)twoTitle twoColor:(UIColor *)twoColor;

@end

NS_ASSUME_NONNULL_END
