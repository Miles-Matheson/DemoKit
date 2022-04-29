//
//  PayView.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/19.
//

#import "PayView.h"

@interface PayView()

@property (weak, nonatomic) IBOutlet UILabel *GoodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *GoodsPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *PayModeLogo;
@property (weak, nonatomic) IBOutlet UILabel *PayModeNameLabel;
@property (weak, nonatomic) IBOutlet UIView *PayViewBG;
@property (weak, nonatomic) IBOutlet UIButton *PayButton;

- (IBAction)QuitPayAction:(id)sender;
- (IBAction)PayAction:(id)sender;
- (IBAction)ChangePayMode:(id)sender;

@end

@implementation PayView

- (id)init{
    self = [super init];
    NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
    self = [[bundle loadNibNamed:@"PayView" owner:nil options:nil] lastObject];
    if (self)
    {
        [self.PayViewBG.layer setMasksToBounds:YES];
        [self.PayViewBG.layer setCornerRadius:10.0];
        [self.PayButton.layer setMasksToBounds:YES];
        [self.PayButton.layer setCornerRadius:5.0];
    }
    return self;
}

/** @初始化支付信息 */
- (void)InitPayView:(NSDictionary *)data withMainPay:(NSDictionary *)mainPay
{
    CGFloat amount = [data[@"amount"] integerValue] * 0.01;
    NSString *itemName = data[@"itemName"];
    /*
    NSString *itemId = data[@"itemId"];
    NSString *roleId = data[@"roleId"];
    NSString *roleName = data[@"roleName"];
    NSString *serverId = data[@"serverId"];
    NSString *callbackInfo = data[@"callbackInfo"];
    */
    
    NSString *msg = [NSString stringWithFormat:@"%.2f元",amount];
    [self.GoodsPriceLabel setText:msg];
    [self.GoodsNameLabel setText:itemName];
    [self UpdatePayModeInfo:mainPay];
}

/**  @更新支付信息 */
- (void)UpdatePayModeInfo:(NSDictionary *)payInfo
{
    NSString *payType = payInfo[@"key"];
    NSString *payIcon = payInfo[@"icon"];
    NSString *payName = payInfo[@"name"];
    UIImage *image = [[QY_CommonController sharedComController] GetCurrentImage:payIcon];
    [self.PayModeLogo setImage:image];
    [self.PayModeNameLabel setText:payName];
    if (self.PayTypeBlock)
    {
        self.PayTypeBlock(payType);
    }
}

/**  @退出支付页面 */
- (IBAction)QuitPayAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(QuitPayDelegate)])
    {
        [self.delegate QuitPayDelegate];
    }
}

/**  @选择其他支付方式 */
- (IBAction)ChangePayMode:(id)sender {
    if ([self.delegate respondsToSelector:@selector(ChangePayModeDelegate)])
    {
        [self.delegate ChangePayModeDelegate];
    }
}

/**  @支付 */
- (IBAction)PayAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(PayDelegate)])
    {
        [self.delegate PayDelegate];
    }
}


@end
