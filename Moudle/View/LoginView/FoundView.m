//
//  LoginView.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/13.
//

#import "FoundView.h"

@interface FoundView()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *FoundNameField;
@property (weak, nonatomic) IBOutlet UITextField *FoundCodeField;
@property (weak, nonatomic) IBOutlet UITextField *FoundPasswordField;
@property (weak, nonatomic) IBOutlet UIButton *CodeButton;
@property (weak, nonatomic) IBOutlet UIButton *FoundButton;
@property (weak, nonatomic) IBOutlet UILabel *FoundServicePhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *FoundServiceQQLabel;

- (IBAction)FoundSendCodeAction:(id)sender;
- (IBAction)FoundButton:(id)sender;
- (IBAction)BackLoginAction:(id)sender;
- (IBAction)FoundPasswordEyeAction:(id)sender;

@end

@implementation FoundView

- (id)init{
    self = [super init];
    NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
    self = [[bundle loadNibNamed:@"FoundView" owner:nil options:nil] lastObject];
    if (self)
    {
        [self.FoundButton.layer setMasksToBounds:YES];
        [self.FoundButton.layer setCornerRadius:5.0f];
        
        [self.FoundNameField addTarget:self action:@selector(TextFieldFirstResponder:) forControlEvents:UIControlEventEditingDidBegin];
        [self.FoundCodeField addTarget:self action:@selector(TextFieldFirstResponder:) forControlEvents:UIControlEventEditingDidBegin];
        [self.FoundPasswordField addTarget:self action:@selector(TextFieldFirstResponder:) forControlEvents:UIControlEventEditingDidBegin];
        
        [self.FoundNameField setReturnKeyType:UIReturnKeyNext];
        [self.FoundNameField setDelegate:self];
        [self.FoundCodeField setReturnKeyType:UIReturnKeyNext];
        [self.FoundCodeField setDelegate:self];
        [self.FoundPasswordField setReturnKeyType:UIReturnKeySend];
        [self.FoundPasswordField setDelegate:self];
    }
    return self;
}

/** @键盘返回键 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.FoundNameField)
    {
        [self.FoundCodeField becomeFirstResponder];
    }
    else if (textField == self.FoundCodeField)
    {
        [self.FoundPasswordField becomeFirstResponder];
    }
    else if (textField == self.FoundPasswordField)
    {
        [self.FoundPasswordField endEditing:YES];
        [self FoundButton:nil];
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

/** @修改密码 */
- (IBAction)FoundButton:(id)sender {
    [self SetEndEditing];
    if([self.delegate respondsToSelector:@selector(RequireFound:withPassword:withCode:)])
    {
        NSString *phone = self.FoundNameField.text;
        NSString *password = self.FoundPasswordField.text;
        NSString *code = self.FoundCodeField.text;
        [self.delegate RequireFound:phone withPassword:password withCode:code];
    }
}

/** @发送验证码 */
- (IBAction)FoundSendCodeAction:(id)sender {
    [self SetEndEditing];
    if([self.delegate respondsToSelector:@selector(RequireSendCodeOfFoundPassword:)])
    {
        NSString *mobile = self.FoundNameField.text;
        [self.delegate RequireSendCodeOfFoundPassword:mobile];
    }
}

/** @返回登录页面 */
- (IBAction)BackLoginAction:(id)sender {
    [self SetEndEditing];
    if([self.delegate respondsToSelector:@selector(BackLoginDelegate)])
    {
        [self.delegate BackLoginDelegate];
    }
}

/** @密码小眼睛 */
- (IBAction)FoundPasswordEyeAction:(UIButton *)sender {
    [[QY_CommonController sharedComController] SetTextFieldEye:self.FoundPasswordField withButton:sender];
}

/** @验证码发送成功后 倒计时 */
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
    [self.FoundServiceQQLabel setText:qqText];
    [self.FoundServicePhoneLabel setText:phoneText];
}

@end
