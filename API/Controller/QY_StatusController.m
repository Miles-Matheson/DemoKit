//
//  LoadController.m
//  SDK
//
//  Created by qianyu on 2019/6/28.
//  Copyright © 2019 com.qianyugame.pdby. All rights reserved.
//

#import "QY_StatusController.h"

#define MARGIN      5       //边距
#define HEIGHT      60      //大小
#define SHOWTIME    1       //显示时间
#define TEXTFONT    16.0f   //文字字体大小
#define IMGSUCCESS  @"icon_load_success"
#define IMGFAILED   @"icon_load_failed"

#define SCREENW     [[UIScreen mainScreen] bounds].size.width
#define SCREENH     [[UIScreen mainScreen] bounds].size.height

@interface QY_StatusController()

@property (nonatomic, strong) UIView *MaskView;
@property (nonatomic, strong) UILabel *StateLabel;
@property (nonatomic, strong) UIImageView *StateImage;
@property (nonatomic, strong) UIActivityIndicatorView *ActivityView;
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation QY_StatusController

#pragma mark - 单例
static id _instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return  _instance;
}

+ (instancetype)sharedLoadController
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

#pragma mark - 懒加载
- (UIView *)MaskView
{
    if (!_MaskView)
    {
        _MaskView = [[UIView alloc] init];
        [_MaskView.layer setMasksToBounds:YES];
        [_MaskView.layer setCornerRadius:10.0f];
        [_MaskView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    }
    return _MaskView;
}

- (UILabel *)StateLabel
{
    if (!_StateLabel)
    {
        _StateLabel = [[UILabel alloc] init];
        [_StateLabel setNumberOfLines:0];
        [_StateLabel setTextColor:[UIColor whiteColor]];
        [_StateLabel setFont:[UIFont systemFontOfSize:TEXTFONT]];
        [_StateLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _StateLabel;
}

- (UIImageView *)StateImage
{
    if (!_StateImage)
    {
        _StateImage = [[UIImageView alloc] init];
        [_StateImage setFrame:CGRectMake(0, 0, HEIGHT, HEIGHT)];
    }
    return _StateImage;
}

- (UIActivityIndicatorView *)ActivityView
{
    if (!_ActivityView)
    {
        _ActivityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    return _ActivityView;
}

#pragma mark - 通用功能
/** @初始化 */
- (void)InitLoadView
{
    [self CancelTimer];
    [self.MaskView addSubview:self.StateImage];
    [self.MaskView addSubview:self.StateLabel];
    [self.MaskView addSubview:self.ActivityView];
    [self.StateImage setHidden:YES];
    [self.StateLabel setHidden:YES];
    [self.ActivityView setHidden:YES];
    [self.ActivityView stopAnimating];
    [self.MaskView removeFromSuperview];
    [[UIApplication sharedApplication].keyWindow addSubview:self.MaskView];
    [self.MaskView setCenter:[UIApplication sharedApplication].keyWindow.center];
}

/** @获取文本大小 */
- (CGSize)getMsgSize:(NSString *)msg withLabel:(UILabel *)label
{
    CGSize constraintSize = CGSizeMake(200.0f, 300.0f);
    CGSize msgSize = [msg boundingRectWithSize:constraintSize
                                       options:(NSStringDrawingOptions)(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin)
                                    attributes:@{NSFontAttributeName:label.font}
                                       context:NULL].size;
    msgSize.height = msgSize.width < 1.0? 0 : msgSize.height;
    msgSize.width = msgSize.width < HEIGHT? HEIGHT : msgSize.width;
    return msgSize;
}

/** @显示成功 */
- (void)showSuccessWithStatus:(NSString *)msg
{
    [self showStatus:msg withImage:IMGSUCCESS];
}

/** @显示失败 */
- (void)showErrorWithStatus:(NSString *)msg
{
    [self showStatus:msg withImage:IMGFAILED];
}

/** @显示图标文字 */
- (void)showStatus:(NSString *)msg withImage:(NSString *)img
{
    [self ListenEvent];
    [self InitLoadView];
    CGSize msgSize = [self getMsgSize:msg withLabel:self.StateLabel];
    CGFloat nLoadW = msgSize.width + 4*MARGIN;
    CGFloat nLoadH = msgSize.height + HEIGHT + 4*MARGIN;
    [self.MaskView setFrame:CGRectMake(0, 0, nLoadW, nLoadH)];
    [self.MaskView setCenter:CGPointMake(SCREENW / 2.0, SCREENH / 2.0)];
    
    [self.StateLabel setFrame:CGRectMake(2*MARGIN, HEIGHT+2*MARGIN, msgSize.width, msgSize.height)];
    [self.StateLabel setText:msg];
    [self.StateLabel setHidden:NO];
    
    [self.StateImage setImage:[UIImage imageNamed:img]];
    [self.StateImage setCenter:CGPointMake(nLoadW / 2.0, (HEIGHT/2.0+2*MARGIN))];
    [self.StateImage setHidden:NO];
    [self StartTimer];
}

/** @加载状态 */
- (void)showWithStatus:(NSString * _Nonnull)msg
{
    [self InitLoadView];
    if (msg != nil && ![msg isEqualToString:@""])
    {
        CGSize msgSize = [self getMsgSize:msg withLabel:self.StateLabel];
        CGSize ScreenSize = [[UIScreen mainScreen] bounds].size;
        CGFloat nLoadW = msgSize.width + 4*MARGIN;
        CGFloat nLoadH = msgSize.height + HEIGHT + 4*MARGIN;
        [self.MaskView setFrame:CGRectMake(0, 0, nLoadW, nLoadH)];
        [self.MaskView setCenter:CGPointMake(ScreenSize.width / 2.0, ScreenSize.height / 2.0)];
        
        [self.StateLabel setFrame:CGRectMake(2*MARGIN, HEIGHT+2*MARGIN, msgSize.width, msgSize.height)];
        [self.StateLabel setText:msg];
        [self.StateLabel setHidden:NO];
        
        [self.ActivityView setCenter:CGPointMake(nLoadW / 2.0, (HEIGHT/2.0+MARGIN))];
        [self.ActivityView setHidden:NO];
        [self.ActivityView startAnimating];
    }
    else
    {
        CGSize ScreenSize = [[UIScreen mainScreen] bounds].size;
        [self.MaskView setFrame:CGRectMake(0, 0, HEIGHT, HEIGHT)];
        [self.MaskView setCenter:CGPointMake(ScreenSize.width/2.0, ScreenSize.height/2.0)];
        
        CGSize PSize = self.ActivityView.superview.frame.size;
        [self.ActivityView setCenter:CGPointMake(PSize.width/2.0, PSize.height/2.0)];
        [self.ActivityView setHidden:NO];
        [self.ActivityView startAnimating];
    }
}

/** @隐藏 */
- (void)dismiss
{
    [self CancelTimer];
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.ActivityView stopAnimating];
        [weakSelf.MaskView removeFromSuperview];
    });
}

#pragma mark - 定时器
//定时器设置
- (void)StartTimer
{
    [self CancelTimer];
    dispatch_queue_t queue = dispatch_get_main_queue();
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(SHOWTIME*NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(1.0 * NSEC_PER_SEC);
    dispatch_source_set_timer(self.timer, start, interval, 0);
    
    //设置回调
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(self.timer, ^{
        [weakSelf dismiss];
        [weakSelf CancelTimer];
    });
    dispatch_resume(self.timer);
}

//取消定时器
- (void)CancelTimer
{
    if (self.timer) {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
}

- (void)ListenEvent
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDeviceOrientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)handleDeviceOrientationChange:(NSNotification *)notification
{
    if(self.MaskView)
    {
        [self.MaskView setCenter:[UIApplication sharedApplication].keyWindow.center];
    }
}

@end
