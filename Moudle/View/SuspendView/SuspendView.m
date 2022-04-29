//
//  SuspendView.m
//  SDK
//
//  Created by qianyu on 2019/6/26.
//  Copyright © 2019 com.qianyugame.pdby. All rights reserved.
//

#import "SuspendView.h"

@interface SuspendView()

@property (weak, nonatomic) IBOutlet UIView *SuspendFunctionView;
@property (assign, nonatomic) int ScreenW; //屏幕宽
@property (assign, nonatomic) int ScreenH; //屏幕高
@property (assign, nonatomic) int CenterX; //屏幕X中心
@property (assign, nonatomic) int CenterY; //屏幕Y中心

- (IBAction)SuspendAccountAction:(id)sender;
- (IBAction)SuspendHideAction:(id)sender;

@end

@implementation SuspendView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
    self = [[bundle loadNibNamed:@"SuspendView" owner:nil options:nil] lastObject];
    self.frame = frame;
    if (self)
    {
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:(self.frame.size.height / 2.0)];
        
        CGSize ScreenSize = [[UIScreen mainScreen] bounds].size;
        self.ScreenW = ScreenSize.width;
        self.ScreenH = ScreenSize.height;
        self.CenterX = ScreenSize.width / 2.0;
        self.CenterY = ScreenSize.height / 2.0;
    }
    return self;
}

//更新Suspend状态
- (void)UpdateSuspendState:(CGRect)bRect
{
    if (self.isHidden == YES)
    {
        CGRect pFrame = self.frame;
        pFrame.origin.y = bRect.origin.y;
        CGRect sFrame = self.SuspendFunctionView.frame;
        CGFloat xCenter = bRect.origin.x + (0.5 * bRect.size.width);
        CGFloat nDiff = pFrame.size.width - sFrame.size.width - bRect.size.width;
        
        if (xCenter < self.CenterX)
        {
            sFrame.origin.x = bRect.size.width + (0.2 * nDiff);
            [self.SuspendFunctionView setFrame:sFrame];
            pFrame.origin.x = 0;
            [self setFrame:pFrame];
        }
        else
        {
            sFrame.origin.x = 0.8 * nDiff;
            [self.SuspendFunctionView setFrame:sFrame];
            pFrame.origin.x = self.ScreenW - pFrame.size.width;
            [self setFrame:pFrame];
        }
        [self setHidden:NO];
    }
    else
    {
        [self setHidden:YES];
    }
}

//隐藏SuspendView
- (void)HideSuspendView
{
    [self setHidden:YES];
}

- (IBAction)SuspendAccountAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(ShowAccountViewDelegate)])
    {
        [self.delegate ShowAccountViewDelegate];
    }
}

- (IBAction)SuspendHideAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(HideSuspendControllerDelegate)])
    {
        [self.delegate HideSuspendControllerDelegate];
    }
}



@end
