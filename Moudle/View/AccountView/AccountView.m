//
//  AccountView.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/19.
//

#import "AccountView.h"

@interface AccountView()

@property (weak, nonatomic) IBOutlet UILabel *AccountSKDNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *AccountTipLabel;
@property (weak, nonatomic) IBOutlet UIButton *BindButton;
@property (weak, nonatomic) IBOutlet UIButton *ChangePasswordButton;
@property (weak, nonatomic) IBOutlet UIButton *LoginOutButton;
@property (weak, nonatomic) IBOutlet UIButton *ChangeAccountButton;
@property (weak, nonatomic) IBOutlet UILabel *AccountNameTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *AccountServiceQQLabel;
@property (weak, nonatomic) IBOutlet UILabel *AccountServicePhoneLabel;

- (IBAction)QuitAction:(id)sender;
- (IBAction)BindAction:(id)sender;
- (IBAction)ChangeAction:(id)sender;
- (IBAction)LoginOutAction:(id)sender;
- (IBAction)ChangeAccountAction:(id)sender;


@end

@implementation AccountView

- (id)init{
    self = [super init];
    NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
    self = [[bundle loadNibNamed:@"AccountView" owner:nil options:nil] lastObject];
    if (self)
    {
        [self.BindButton.layer setMasksToBounds:YES];
        [self.BindButton.layer setCornerRadius:5.0f];
        [self.LoginOutButton.layer setMasksToBounds:YES];
        [self.LoginOutButton.layer setCornerRadius:5.0f];
        [self.ChangePasswordButton.layer setMasksToBounds:YES];
        [self.ChangePasswordButton.layer setCornerRadius:5.0f];
        [self.ChangeAccountButton.layer setMasksToBounds:YES];
        [self.ChangeAccountButton.layer setCornerRadius:5.0f];
        NSString *SDKName = [[KeyController sharedKeyController] GetSDKName];
        [self.AccountSKDNameLabel setText:SDKName];
    }
    return self;
}

/** @更新绑定页面 */
- (void)UpdateBindModeByMobile:(NSString *)mobile withName:(NSString *)name
{
    if (!(mobile == nil))
    {
        NSString *oneTitle = @"已绑定手机：";
        NSString *twoTitle = [NSString stringWithFormat:@"%@****%@",[mobile substringToIndex:3],[mobile substringFromIndex:7]];
        NSString *string = [NSString stringWithFormat:@"%@%@",oneTitle,twoTitle];
        NSMutableAttributedString *mutString = [[NSMutableAttributedString alloc]initWithString:string];
        [mutString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, oneTitle.length)];
        [mutString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(oneTitle.length, twoTitle.length)];
        [self.AccountTipLabel setAttributedText:mutString];
        [self.BindButton setTitle:@"变更手机号" forState:UIControlStateNormal];
        
        if (name == nil || [name isEqualToString:@""])
        {
            [self.AccountNameTipLabel setHidden:YES];
        }
        else
        {
            NSString *nameTitle = [NSString stringWithFormat:@"用户名：%@",name];
            [self.AccountNameTipLabel setText:nameTitle];
            [self.AccountNameTipLabel setHidden:NO];
        }
    }
    else
    {
        NSString *tip = @"注：必须绑定手机号才能找回密码";
        [self.AccountTipLabel setText:tip];
        [self.AccountTipLabel setTextColor:[UIColor redColor]];
        [self.BindButton setTitle:@"绑定手机" forState:UIControlStateNormal];
        //NSInteger index = [name length] > 4 ? ([name length] - 4) : 0;
        //NSString *nameTitle = [NSString stringWithFormat:@"用户名：%@****",[name substringToIndex:index]];
        NSString *nameTitle = [NSString stringWithFormat:@"用户名：%@",name];
        [self.AccountNameTipLabel setText:nameTitle];
        [self.AccountNameTipLabel setHidden:NO];
    }
    [self UpdateChangePasswordState];
}

/** @设置客服电话和QQ */
- (void)SetServiceInfo:(NSString *)qqService withPhone:(NSString *)phoneService
{
    NSString *qqText = [NSString stringWithFormat:@"客服QQ:%@",qqService];
    if (qqService == NULL || [qqService isEqualToString:@""])
    {
        qqText = @"";
    }
    NSString *phoneText = [NSString stringWithFormat:@"客服电话:%@",phoneService];
    if (phoneService == NULL || [phoneService isEqualToString:@""])
    {
        phoneText = @"";
    }
    
    [self.AccountServiceQQLabel setText:qqText];
    [self.AccountServicePhoneLabel setText:phoneText];
}

/** @更新修改密码按钮文字 */
- (void)UpdateChangePasswordState{
    BOOL bEmptyPassword = [[KeyController sharedKeyController] GetUserEmptyPassword];
    //密码为空，设置密码
    if(bEmptyPassword == YES)
    {
        [self.ChangePasswordButton setTitle:@"设置密码" forState:UIControlStateNormal];
    }
    else
    {
        [self.ChangePasswordButton setTitle:@"修改密码" forState:UIControlStateNormal];
    }
}

/** @退出账号管理页面 */
- (IBAction)QuitAction:(id)sender {
    [self SetEndEditing];
    if([self.delegate respondsToSelector:@selector(QuitActionDelegate)])
    {
        [self.delegate QuitActionDelegate];
    }
}

/** @跳转绑定页面 */
- (IBAction)BindAction:(id)sender {
    [self SetEndEditing];
    if([self.delegate respondsToSelector:@selector(JumpBindViewDelegate)])
    {
        [self.delegate JumpBindViewDelegate];
    }
}

/** @跳转修改密码页面 */
- (IBAction)ChangeAction:(id)sender {
    [self SetEndEditing];
    if([self.delegate respondsToSelector:@selector(JumpChangePasswordViewDelegate)])
    {
        [self.delegate JumpChangePasswordViewDelegate];
    }
}

/** @退出账号 */
- (IBAction)LoginOutAction:(id)sender {
    [self SetEndEditing];
    if([self.delegate respondsToSelector:@selector(LoginOutDelegate)])
    {
        [self.delegate LoginOutDelegate];
    }
}

- (IBAction)ChangeAccountAction:(id)sender {
    if([self.delegate respondsToSelector:@selector(ChangeAccountDelegate)])
    {
        [self.delegate ChangeAccountDelegate];
    } 
}



@end
