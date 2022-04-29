//
//  BaseController.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/7/4.
//

#import "QY_ControllerBase.h"
#import "BaseMaskView.h"
#import "SuspendView.h"
#import "SuspendLogo.h"
#import "PayContainer.h"
#import "PayWebView.h"
#import "AiPayWebView.h"

@implementation QY_ControllerBase

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

- (void)InitController
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDeviceOrientationChange) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)handleDeviceOrientationChange
{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if(orientation == UIDeviceOrientationPortrait)
    {
        self.isVertical = YES;
    }
    else if (self.isVertical && orientation == UIDeviceOrientationFaceUp) { }
    else if (self.isVertical && orientation == UIDeviceOrientationFaceDown) { }
    else
    {
        self.isVertical = NO;
    }

    UIViewController *unityController = [[KeyController sharedKeyController] GetMainController];
    for (UIView *view in unityController.view.subviews) {
        //遮罩
        if ([view isKindOfClass:[BaseMaskView class]]) {
            for (UIView *subView in view.subviews) {
                //NSLog(@"subView === %@",[subView class]);
                if([subView isKindOfClass:[PayContainer class]])
                {
                    CGRect rect = [[UIApplication sharedApplication] keyWindow].frame;
                    CGFloat nScreenW = rect.size.width;
                    CGFloat nScreenH = rect.size.height;
                    [view setFrame:CGRectMake(0, 0, nScreenW, nScreenH)];
                    [view setCenter:[[UIApplication sharedApplication] keyWindow].center];

                    CGFloat nItemW = nScreenW >= nScreenH? 0.9 * nScreenH : 0.9 * nScreenW;
                    nItemW = nItemW > 400 ? 400 : nItemW;
                    CGFloat nItemH = nItemW * (7.0 / 8.0);
                    [subView setFrame:CGRectMake(0, 0, nItemW, nItemH)];
                    [subView setCenter:view.center];
                }
                else if([subView isKindOfClass:[PayWebView class]])
                {
                    CGRect rect = [[UIApplication sharedApplication] keyWindow].frame;
                    CGFloat nScreenW = rect.size.width;
                    CGFloat nScreenH = rect.size.height;
                    [subView setFrame:CGRectMake(0, 0, nScreenW, nScreenH)];
                    
                    for (UIView *v in subView.subviews) {
                        //NSLog(@"v === %@",[v class]);
                        if([v isKindOfClass:[AiPayWebView class]])
                        {
                            [v setFrame:CGRectMake(0, 0, nScreenW, nScreenH)];
                        }
                    }
                }
                else
                {
                    [view setCenter:[[UIApplication sharedApplication] keyWindow].center];
                }
            }
        }
        //悬浮图标
        else if ([view isKindOfClass:[SuspendLogo class]]) {
            if(self.isVertical)
            {
                [view setHidden:YES];
            }
            else
            {
                CGRect rect = unityController.view.frame;
                CGFloat nItemH = rect.size.width >= rect.size.height? 0.13 * rect.size.height : 0.13 * rect.size.width;
                [view setFrame:CGRectMake(0, 10, nItemH, nItemH)];
                [view setHidden:NO];
            }
        }
        //悬浮内容
        else if ([view isKindOfClass:[SuspendView class]]) {
            if(self.isVertical)
           {
               [view setHidden:YES];
           }
           else
           {
               CGRect rect = unityController.view.frame;
               CGFloat nItemH = rect.size.width >= rect.size.height? 0.13 * rect.size.height : 0.13 * rect.size.width;
               [view setFrame:CGRectMake(0, 10, 3.4*nItemH, nItemH)];
           }
            
        }
    }
}

@end
