//
//  UIImage+Doraemon.h
//  DoraemonKit
//
//  Created by yixiang on 2017/12/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (QianYu)


+ (nullable UIImage *)qy_xcassetImageNamed:(NSString *)name;

//压缩图片尺寸 等比缩放 通过计算得到缩放系数
- (nullable UIImage*)qy_scaledToSize:(CGSize)newSize;

/**
Create and return a 1x1 point size image with the given color.

@param color  The color.
*/
+ (UIImage *)qy_imageWithColor:(UIColor *)color;

/**
 Create and return a pure color image with the given color and size.
 
 @param color  The color.
 @param size   New image's type.
 */
+ (UIImage *)qy_imageWithColor:(UIColor *)color size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
