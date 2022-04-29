//
//  ComController.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/7/3.
//

#import "QY_CommonController.h"
#import "QY_StatusController.h"
#import "KeyController.h"

@implementation QY_CommonController

static id _instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return  _instance;
}

+ (instancetype)sharedComController
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return  _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

/** @获取NSBundle */
- (NSBundle *)GetCurrentBundle
{
    NSBundle *bundle = [NSBundle mainBundle];
    BOOL InDev = [[KeyController sharedKeyController] GetInDevelopment];
    if (!InDev)
    {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"QianYu_SDK_Framework" ofType:@"bundle"];
        bundle = [NSBundle bundleWithPath:bundlePath];
    }
    return bundle;
}

/** @获取UIImage */
- (UIImage *)GetCurrentImage:(NSString *)name
{
    NSString *symbol = @"";
    BOOL InDev = [[KeyController sharedKeyController] GetInDevelopment];
    if (!InDev)
    {
        symbol = @"QianYu_SDK_Framework.bundle/";
    }
    UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",symbol,name]];
    return img;
}

#pragma mark - LoadController
/** @显示成功 */
- (void)showSuccessWithStatus:(NSString *)msg
{
    [[QY_StatusController sharedLoadController] showSuccessWithStatus:msg];
}

/** @显示失败 */
- (void)showErrorWithStatus:(NSString *)msg
{
    [[QY_StatusController sharedLoadController] showErrorWithStatus:msg];
}

/** @加载状态 */
- (void)showWithStatus:(NSString * _Nonnull)msg
{
    [[QY_StatusController sharedLoadController]showWithStatus:msg];
}

/** @隐藏 */
- (void)dismiss
{
    [[QY_StatusController sharedLoadController] dismiss];
}

#pragma mark - 通用功能
/** @将View转化为Image */
- (UIImage *)imageFromView:(UIView *)view
{
    //UIGraphicsBeginImageContext(view.frame.size);
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/** 密码小眼睛 */
- (void)SetTextFieldEye:(UITextField *)field withButton:(UIButton *)button
{
    if (field.secureTextEntry == YES)
    {
        [field setSecureTextEntry:NO];
        UIImage *image = [[QY_CommonController sharedComController] GetCurrentImage:@"sdk_eye_close"];
        [button setImage:image forState:UIControlStateNormal];
    }
    else
    {
        [field setSecureTextEntry:YES];
        UIImage *image = [[QY_CommonController sharedComController] GetCurrentImage:@"sdk_yanjing"];
        [button setImage:image forState:UIControlStateNormal];
    }
}

/** 获取textField的Rect */
- (UITextField *)GetTextFieldFirstResponder:(UIView *)parentView;
{
    UITextField *textField;
    for (UIView *view1 in parentView.subviews)
    {
        if ([view1 isKindOfClass:[UITextField class]])
        {
            if ([(UITextField *)view1 isFirstResponder])
            {
                return (UITextField *)view1;
            }
        }
        else if ([view1 isKindOfClass:[UIView class]])
        {
            for (UIView *view2 in view1.subviews)
            {
                if ([view2 isKindOfClass:[UITextField class]])
                {
                    return (UITextField *)view1;
                }
                else if ([view2 isKindOfClass:[UIView class]])
                {
                    for (UIView *view3 in view2.subviews)
                    {
                        if ([(UITextField *)view3 isFirstResponder])
                        {
                            return (UITextField *)view3;
                        }
                    }
                }
            }
        }
    }
    return textField;
}

/** 设置富文本颜色 */
- (NSMutableAttributedString *)SetOneTitle:(NSString *)oneTitle oneColor:(UIColor *)oneColor twoTitle:(NSString *)twoTitle twoColor:(UIColor *)twoColor
{
    NSString *string = [NSString stringWithFormat:@"%@%@",oneTitle,twoTitle];
    NSMutableAttributedString *mutString = [[NSMutableAttributedString alloc]initWithString:string];
    [mutString addAttribute:NSForegroundColorAttributeName value:oneColor range:NSMakeRange(0, oneTitle.length)];
    [mutString addAttribute:NSForegroundColorAttributeName value:twoColor range:NSMakeRange(oneTitle.length, twoTitle.length)];
    return mutString;
}


@end
