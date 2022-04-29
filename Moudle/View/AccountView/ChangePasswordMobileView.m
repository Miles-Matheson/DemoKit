//
//  AccountView.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/19.
//

#import "ChangePasswordMobileView.h"

@interface ChangePasswordMobileView()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *ChangePasswordMobileTip;
@property (weak, nonatomic) IBOutlet UITextField *ChangePasswordMobileCodeField;
@property (weak, nonatomic) IBOutlet UITextField *ChangePasswordMobileField;
@property (weak, nonatomic) IBOutlet UIButton *CodeButton;
@property (weak, nonatomic) IBOutlet UIButton *ChangePasswordMobileButton;
@property (weak, nonatomic) IBOutlet UILabel *ChangePasswordMobileSDKNameLabel;

- (IBAction)BackAccountAction:(id)sender;
- (IBAction)ChangePasswordAction:(id)sender;
- (IBAction)ChangePasswordMobileCodeAction:(id)sender;
- (IBAction)ChangePasswordMobileEyeAction:(id)sender;

@end

@implementation ChangePasswordMobileView

- (id)init{
    self = [super init];
    NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
    self = [[bundle loadNibNamed:@"ChangePasswordMobileView" owner:nil options:nil] lastObject];
    if (self)
    {
        [self.ChangePasswordMobileButton.layer setMasksToBounds:YES];
        [self.ChangePasswordMobileButton.layer setCornerRadius:5.0f];
        
        [self.ChangePasswordMobileCodeField addTarget:self action:@selector(TextFieldFirstResponder:) forControlEvents:UIControlEventEditingDidBegin];
        [self.ChangePasswordMobileField addTarget:self action:@selector(TextFieldFirstResponder:) forControlEvents:UIControlEventEditingDidBegin];
        
        [self.ChangePasswordMobileCodeField setReturnKeyType:UIReturnKeyNext];
        [self.ChangePasswordMobileCodeField setDelegate:self];
        [self.ChangePasswordMobileField setReturnKeyType:UIReturnKeyNext];
        [self.ChangePasswordMobileField setDelegate:self];
        
        NSString *SDKName = [[KeyController sharedKeyController] GetSDKName];
        [self.ChangePasswordMobileSDKNameLabel setText:SDKName];
    }
    return self;
}

/** @键盘返回键 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.ChangePasswordMobileCodeField)
    {
        [self.ChangePasswordMobileField becomeFirstResponder];
    }
    else if (textField == self.ChangePasswordMobileField)
    {
        [self.ChangePasswordMobileField endEditing:YES];
        [self ChangePasswordAction:nil];
    }
    return YES;
}

/** @监听TextField键盘光标 */
-(void)TextFieldFirstResponder:(id)textField
{
    if ([self.delegate respondsToSelector:@selector(UpdateKeyboardState)])
    {
        [self.delegate UpdateKeyboardState];
    }
}

/**
 *  @验证码发送成功后 倒计时
 */
- (void)RegetSendCodeAction:(NSNumber *)second
{
    if ([second integerValue] == 0){
        [self.CodeButton setEnabled:YES];
        [self.CodeButton setTitleColor:[UIColor colorWithRed:21/255.0 green:131/255.0 blue:210/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.CodeButton setTitle:@"重新发送" forState:UIControlStateNormal];
    }else{
        int intSecond = [second intValue];
        [self.CodeButton setEnabled:NO];
        [self.CodeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.CodeButton setTitle:[NSString stringWithFormat:@"%ds",intSecond] forState:UIControlStateNormal];
        [self performSelector:@selector(RegetSendCodeAction:) withObject:[NSNumber numberWithInt:intSecond-1] afterDelay:1];
    }
}

/** @更新页面手机号 */
- (void)UpdateChangePasswordMobileViewByMobile:(NSString *)mobile
{
    NSString *oneTitle = @"已绑定手机：";
    NSString *twoTitle = [NSString stringWithFormat:@"%@****%@",[mobile substringToIndex:3],[mobile substringFromIndex:7]];
    NSString *string = [NSString stringWithFormat:@"%@%@",oneTitle,twoTitle];
    NSMutableAttributedString *mutString = [[NSMutableAttributedString alloc]initWithString:string];
    [mutString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, oneTitle.length)];
    [mutString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(oneTitle.length, twoTitle.length)];
    [self.ChangePasswordMobileTip setAttributedText:mutString];
}

/**  @密码小眼睛 */
- (IBAction)ChangePasswordMobileEyeAction:(UIButton *)sender {
    [[QY_CommonController sharedComController] SetTextFieldEye:self.ChangePasswordMobileField withButton:sender];
}

/**  @代理 返回账号管理页面 */
- (IBAction)BackAccountAction:(id)sender {
    [self SetEndEditing];
    if ([self.delegate respondsToSelector:@selector(BackAccountDelegate)])
    {
        [self.delegate BackAccountDelegate];
    }
}

/**  @代理 手机用户 修改密码 */
- (IBAction)ChangePasswordAction:(id)sender {
    [self SetEndEditing];
    if([self.delegate respondsToSelector:@selector(ChangePasswordOfMobile:withPassword:)])
    {
        NSString *code = self.ChangePasswordMobileCodeField.text;
        NSString *password = self.ChangePasswordMobileField.text;
        [self.delegate ChangePasswordOfMobile:code withPassword:password];
    }
}

/**  @代理 发送验证码 */
- (IBAction)ChangePasswordMobileCodeAction:(id)sender {
    [self SetEndEditing];
    if ([self.delegate respondsToSelector:@selector(SendCodeOfChangePasswordOfMobile)])
    {
        [self.delegate SendCodeOfChangePasswordOfMobile];
    }
}



@end
