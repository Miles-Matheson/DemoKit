//
//  LoginView.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/13.
//

#import "QuickRegistView.h"

@interface QuickRegistView()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *QuickRegistNameField;
@property (weak, nonatomic) IBOutlet UITextField *QuickRegistPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *QuickRegistCodeField;
@property (weak, nonatomic) IBOutlet UIButton *CodeButton;
@property (weak, nonatomic) IBOutlet UIButton *QuickRegistButton;
@property (weak, nonatomic) IBOutlet UIButton *NameRegistButton;
@property (weak, nonatomic) IBOutlet UIButton *OneQuickRegistButton;

- (IBAction)QuickRegistSendCodeAction:(id)sender;
- (IBAction)QuickRegistEyeAction:(id)sender;
- (IBAction)QuickRegistButton:(id)sender;
- (IBAction)BackRegistAction:(id)sender;
- (IBAction)BackLoginAction:(id)sender;
- (IBAction)OneQuickRegistAction:(id)sender;

@end

@implementation QuickRegistView

- (id)init{
    self = [super init];
    NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
    self = [[bundle loadNibNamed:@"QuickRegistView" owner:nil options:nil] lastObject];
    if (self)
    {
        [self.QuickRegistButton.layer setMasksToBounds:YES];
        [self.QuickRegistButton.layer setCornerRadius:5.0f];
        [self.OneQuickRegistButton.layer setMasksToBounds:YES];
        [self.OneQuickRegistButton.layer setCornerRadius:5.0f];
        [self.NameRegistButton.layer setMasksToBounds:YES];
        [self.NameRegistButton.layer setCornerRadius:5.0f];
        
        [self.QuickRegistNameField addTarget:self action:@selector(TextFieldFirstResponder:) forControlEvents:UIControlEventEditingDidBegin];
        [self.QuickRegistPasswordField addTarget:self action:@selector(TextFieldFirstResponder:) forControlEvents:UIControlEventEditingDidBegin];
        [self.QuickRegistCodeField addTarget:self action:@selector(TextFieldFirstResponder:) forControlEvents:UIControlEventEditingDidBegin];
        
        [self.QuickRegistNameField setReturnKeyType:UIReturnKeyNext];
        [self.QuickRegistNameField setDelegate:self];
        [self.QuickRegistCodeField setReturnKeyType:UIReturnKeyNext];
        [self.QuickRegistCodeField setDelegate:self];
        [self.QuickRegistPasswordField setReturnKeyType:UIReturnKeyNext];
        [self.QuickRegistPasswordField setDelegate:self];
    }
    return self;
}

/** @键盘返回键 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.QuickRegistNameField)
    {
        [self.QuickRegistCodeField becomeFirstResponder];
    }
    else if (textField == self.QuickRegistCodeField)
    {
        [self.QuickRegistPasswordField becomeFirstResponder];
    }
    else if (textField == self.QuickRegistPasswordField)
    {
        [self.QuickRegistPasswordField endEditing:YES];
        [self QuickRegistButton:nil];
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

/** @快速注册 */
- (IBAction)QuickRegistButton:(id)sender {
    [self SetEndEditing];
    if([self.delegate respondsToSelector:@selector(RequireQuickRegist:withPassword:withCode:)])
    {
        NSString *mobile = self.QuickRegistNameField.text;
        NSString *password = self.QuickRegistPasswordField.text;
        NSString *code = self.QuickRegistCodeField.text;
        [self.delegate RequireQuickRegist:mobile withPassword:password withCode:code];
    }
}

/** @发送验证码 */
- (IBAction)QuickRegistSendCodeAction:(id)sender {
    [self SetEndEditing];
    if([self.delegate respondsToSelector:@selector(RequireSendCodeOfQuickRegist:)])
    {
        NSString *mobile = self.QuickRegistNameField.text;
        [self.delegate RequireSendCodeOfQuickRegist:mobile];
    }
}

/** @密码小眼睛 */
- (IBAction)QuickRegistEyeAction:(UIButton *)sender {
    [[QY_CommonController sharedComController] SetTextFieldEye:self.QuickRegistPasswordField withButton:sender];
}

/** @返回注册页面 */
- (IBAction)BackRegistAction:(id)sender {
    [self SetEndEditing];
    if([self.delegate respondsToSelector:@selector(BackRegistDelegate)])
    {
        [self.delegate BackRegistDelegate];
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

- (IBAction)OneQuickRegistAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(OneQuickRegistDelegate)])
    {
        [self.delegate OneQuickRegistDelegate];
    }
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

/**  @更新一键快速注册 */
- (void)OneQuickRegistShow:(BOOL)bShow
{
    if (bShow)
    {
        [self.OneQuickRegistButton setHidden:NO];
        CGSize size = self.OneQuickRegistButton.frame.size;
        CGPoint point = self.NameRegistButton.frame.origin;
        [self.NameRegistButton setFrame:CGRectMake(point.x, point.y, size.width, size.height)];
    }
    else
    {
        [self.OneQuickRegistButton setHidden:YES];
        CGSize size = self.QuickRegistButton.frame.size;
        CGPoint point = self.NameRegistButton.frame.origin;
        [self.NameRegistButton setFrame:CGRectMake(point.x, point.y, size.width, size.height)];
    }
}

@end
