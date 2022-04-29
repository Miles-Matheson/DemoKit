//
//  BaseView.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/20.
//

#import "BaseView.h"

@implementation BaseView

- (CGFloat)nScreenW
{
    if (!_nScreenW)
    {
        CGSize ScreenSize = [[UIScreen mainScreen] bounds].size;
        _nScreenW = ScreenSize.width;
    }
    return _nScreenW;
}

- (CGFloat)nScreenH
{
    if (!_nScreenH)
    {
        CGSize ScreenSize = [[UIScreen mainScreen] bounds].size;
        _nScreenH = ScreenSize.height;
    }
    return _nScreenH;
}

/** @销毁 */
- (void)DestroyView
{
    [self removeFromSuperview];
}

/** @隐藏键盘 */
- (void)SetEndEditing
{
    [self endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self SetEndEditing];
}


/** @页面出现 */
- (void)ViewDidAppear:(BOOL)isClean;
{
    [self setHidden:NO];
    if (isClean)
    {
        [self UpdateTextField:self];
    }
}

/** @页面消失 */
- (void)ViewDidDisappear
{
    [self setHidden:YES];
}

/** @TextField置空 */
- (void)UpdateTextField:(UIView *)view {
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[UITextField class]])
        {
            [(UITextField *)subView setText:@""];
        }
        else if ([subView isKindOfClass:[UIView class]] && subView.subviews.count > 0) {
            [self UpdateTextField:subView];
        }
    }
}


@end
