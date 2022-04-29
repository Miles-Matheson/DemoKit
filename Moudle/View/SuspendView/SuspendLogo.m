//
//  SuspendLogo.m
//  SDK
//
//  Created by qianyu on 2019/6/26.
//  Copyright © 2019 com.qianyugame.pdby. All rights reserved.
//

#import "SuspendLogo.h"

@interface SuspendLogo()

@property (weak, nonatomic) IBOutlet UIButton *SuspendButton;

@property (strong, nonatomic) UIPanGestureRecognizer *pan;
@property (strong, nonatomic) dispatch_source_t myTimer;
@property (assign, nonatomic) long num;
@property (assign, nonatomic) int ScreenW; //屏幕宽
@property (assign, nonatomic) int ScreenH; //屏幕高
@property (assign, nonatomic) int CenterX; //屏幕X中心
@property (assign, nonatomic) int CenterY; //屏幕Y中心
@property (assign, nonatomic) int FrameW; //控件宽
@property (assign, nonatomic) int FrameH; //控件高

- (IBAction)SuspendAction:(id)sender;

@end

@implementation SuspendLogo

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
    self = [[bundle loadNibNamed:@"SuspendLogo" owner:nil options:nil] lastObject];
    self.frame = frame;
    if (self)
    {
        CGSize ScreenSize = [[UIScreen mainScreen] bounds].size;
        self.ScreenW = ScreenSize.width;
        self.ScreenH = ScreenSize.height;
        self.CenterX = ScreenSize.width / 2.0;
        self.CenterY = ScreenSize.height / 2.0;
        self.FrameW = self.frame.size.width;
        self.FrameH = self.frame.size.height;
        
        self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(ChangeSuspendPosition:)];
        [self.SuspendButton addGestureRecognizer:self.pan];
    }
    return self;
}

//更新Suspend状态
- (void)UpdateSuspendState
{
    CGRect frame = self.frame;
    [self setFrame:CGRectMake(0, frame.origin.y, frame.size.width, frame.size.height)];
    UIImage *image = [[QY_CommonController sharedComController] GetCurrentImage:@"hl_fw_icon_left"];
    [self.SuspendButton setImage:image forState:UIControlStateNormal];
    [self RemovePanTimer];
}

- (IBAction)SuspendAction:(id)sender {
    UIImage *image = [[QY_CommonController sharedComController] GetCurrentImage:@"hl_fw_icon_default"];
    [self.SuspendButton setImage:image forState:UIControlStateNormal];
    [self RemovePanTimer];
    [self BeganPanTimer];
    [self UpdateSuspendViewState];
}

/**  @代理 隐藏SuspendView */
- (void)HideSuspendView
{
    if ([self.delegate respondsToSelector:@selector(HideSuspendViewDelegate)])
    {
        [self.delegate HideSuspendViewDelegate];
    }
}

/**  @代理 更新SuspendView状态 */
- (void)UpdateSuspendViewState
{
    if ([self.delegate respondsToSelector:@selector(UpdateSuspendViewDelegate:)])
    {
        [self.delegate UpdateSuspendViewDelegate:self.frame];
    }
}


- (void)ChangeSuspendPosition:(UIPanGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateBegan)
    {
        [self RemovePanTimer];
        [self HideSuspendView];
        UIImage *image = [[QY_CommonController sharedComController] GetCurrentImage:@"hl_fw_icon_default"];
        [self.SuspendButton setImage:image forState:UIControlStateNormal];
    }
    else if (pan.state == UIGestureRecognizerStateChanged)
    {
        CGPoint offset = [pan translationInView:self];
        CGPoint center = CGPointMake(self.center.x + offset.x, self.center.y + offset.y);
        if (center.x < (self.FrameW / 2.0))
        {
            center.x = (self.FrameW / 2.0);
        }
        else if (center.x > (self.ScreenW - (self.FrameW / 2.0)))
        {
            center.x = (self.ScreenW - (self.FrameW / 2.0));
        }
        if (center.y < (self.FrameH / 2.0))
        {
            center.y = (self.FrameH / 2.0);
        }
        else if (center.y > (self.ScreenH - (self.FrameH / 2.0)))
        {
            center.y = (self.ScreenH - (self.FrameH / 2.0));
        }
        
        [self setCenter:center];
        [pan setTranslation:CGPointZero inView:self];
    }
    else if (pan.state == UIGestureRecognizerStateEnded)
    {
        CGRect frame = self.frame;
        if (self.center.x < self.CenterX)
        {
            frame.origin.x = 0;
        }
        else
        {
            frame.origin.x = self.ScreenW - self.FrameW;
        }
        
        __weak typeof (self) weakSelf = self;
        [UIView animateWithDuration:0.3 animations:^{
            [weakSelf setFrame:frame];
        }];
        [self BeganPanTimer];
    }
}

//定时器
- (void)BeganPanTimer
{
    [self RemovePanTimer];
    dispatch_queue_t queue = dispatch_get_main_queue();
    self.myTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.myTimer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    __weak typeof (self) weakSelf = self;
    weakSelf.num = 5;
    dispatch_source_set_event_handler(self.myTimer, ^{
        weakSelf.num --;
        if (weakSelf.num == 0) {
            [weakSelf RemovePanTimer];
            [weakSelf PanTimerAction];
        }
    });
    dispatch_resume(self.myTimer);
}

// 定时器结束 修改浮标图片
- (void)PanTimerAction
{
    NSString *imgName = @"";
    CGFloat xCenter = self.center.x;
    if (xCenter < self.CenterX)
    {
        imgName = @"hl_fw_icon_left";
    }
    else
    {
        imgName = @"hl_fw_icon_right";
    }
    UIImage *image = [[QY_CommonController sharedComController] GetCurrentImage:imgName];
    [self.SuspendButton setImage:image forState:UIControlStateNormal];
    [self HideSuspendView];
}

//移除定时器
- (void)RemovePanTimer
{
    if (self.myTimer)
    {
        dispatch_source_cancel(self.myTimer);
        self.myTimer = nil;
    }
}

//移除pan手势
- (void)RemovePanGestureRecognizer
{
    if (self.pan)
    {
        [self.SuspendButton removeGestureRecognizer:self.pan];
        self.pan = nil;
    }
}

//移除Suspend状态
- (void)RemoveSuspendState
{
    [self RemovePanTimer];
    [self RemovePanGestureRecognizer];
}

@end
