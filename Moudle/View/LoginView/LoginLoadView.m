//
//  LoginLoadView.m
//  QianYu_SDK_IOS
//
//  Created by qianyu on 2019/10/18.
//  Copyright © 2019 qianyu. All rights reserved.
//

#import "LoginLoadView.h"

@interface LoginLoadView()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *LoginLoadActivity;
@property (weak, nonatomic) IBOutlet UILabel *LoginLoadTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *LoginLoadButton;
- (IBAction)LoginLoadAction:(id)sender;

@end

@implementation LoginLoadView

- (id)init{
    self = [super init];
    NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
    self = [[bundle loadNibNamed:@"LoginLoadView" owner:nil options:nil] lastObject];
    if (self)
    {
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:10.0f];
        [self.LoginLoadButton.layer setMasksToBounds:YES];
        [self.LoginLoadButton.layer setCornerRadius:5.0f];
    }
    return self;
}

//更新文本内容
- (void)UpdateLoginLoad
{
    NSString *title = [[KeyController sharedKeyController] GetLoginName];
    NSString *msg = [NSString stringWithFormat:@"%@正在登录...",title];
    [self.LoginLoadTitleLabel setText:msg];
    [self.LoginLoadActivity startAnimating];
}

/** @页面消失 */
- (void)ViewDidDisappear
{
    [self setHidden:YES];
    if (self.LoginLoadActivity)
    {
        [self.LoginLoadActivity stopAnimating];
    }
}

- (IBAction)LoginLoadAction:(id)sender {
    if([self.delegate respondsToSelector:@selector(ClickChangeDelegate)])
    {
        [self.delegate ClickChangeDelegate];
    }
}

@end
