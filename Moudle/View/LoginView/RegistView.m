//
//  LoginView.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/13.
//

#import "RegistView.h"

@interface RegistView()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *RegistNameField;
@property (weak, nonatomic) IBOutlet UITextField *RegistPasswordField;
@property (weak, nonatomic) IBOutlet UIButton *RegistButton;
@property (weak, nonatomic) IBOutlet UIButton *PhoneRegistButton;
@property (weak, nonatomic) IBOutlet UIButton *OneQuickRegistButton;

- (IBAction)RegistPasswordEyeAction:(id)sender;
- (IBAction)RegistAction:(id)sender;
- (IBAction)BackQuickRegistAction:(id)sender;
- (IBAction)BackLoginAction:(id)sender;
- (IBAction)RandomNameAction:(id)sender;
- (IBAction)OneQuickRegistAction:(id)sender;

@end

@implementation RegistView

- (id)init{
    self = [super init];
    NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
    self = [[bundle loadNibNamed:@"RegistView" owner:nil options:nil] lastObject];
    if (self)
    {
        [self.RegistButton.layer setMasksToBounds:YES];
        [self.RegistButton.layer setCornerRadius:5.0f];
        [self.OneQuickRegistButton.layer setMasksToBounds:YES];
        [self.OneQuickRegistButton.layer setCornerRadius:5.0f];
        [self.PhoneRegistButton.layer setMasksToBounds:YES];
        [self.PhoneRegistButton.layer setCornerRadius:5.0f];
        
        [self.RegistNameField addTarget:self action:@selector(TextFieldFirstResponder:) forControlEvents:UIControlEventEditingDidBegin];
        [self.RegistPasswordField addTarget:self action:@selector(TextFieldFirstResponder:) forControlEvents:UIControlEventEditingDidBegin];
        
        [self.RegistNameField setReturnKeyType:UIReturnKeyNext];
        [self.RegistNameField setDelegate:self];
        [self.RegistPasswordField setReturnKeyType:UIReturnKeyNext];
        [self.RegistPasswordField setDelegate:self];
    }
    return self;
}

/** @键盘返回键 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.RegistNameField)
    {
        [self.RegistPasswordField becomeFirstResponder];
    }
    else if (textField == self.RegistPasswordField)
    {
        [self.RegistPasswordField endEditing:YES];
        [self RegistAction:nil];
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


/** @注册 */
- (IBAction)RegistAction:(id)sender {
    [self SetEndEditing];
    if([self.delegate respondsToSelector:@selector(RequireRegist:withPassword:)])
    {
        NSString *name = self.RegistNameField.text;
        NSString *password = self.RegistPasswordField.text;
        [self.delegate RequireRegist:name withPassword:password];
    }
}

/** @密码小眼睛 */
- (IBAction)RegistPasswordEyeAction:(UIButton *)sender {
    [[QY_CommonController sharedComController] SetTextFieldEye:self.RegistPasswordField withButton:sender];
}

/** @切换 快速注册 */
- (IBAction)BackQuickRegistAction:(id)sender {
    [self SetEndEditing];
    if([self.delegate respondsToSelector:@selector(BackQuickRegistDelegate)])
    {
        [self.delegate BackQuickRegistDelegate];
    }
}

/** @切换 登录页面 */
- (IBAction)BackLoginAction:(id)sender {
    [self SetEndEditing];
    if([self.delegate respondsToSelector:@selector(BackLoginDelegate)])
    {
        [self.delegate BackLoginDelegate];
    }
}

- (IBAction)RandomNameAction:(id)sender {
    [self UpdateRandomUserName];
}

- (IBAction)OneQuickRegistAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(OneQuickRegistDelegate)])
    {
        [self.delegate OneQuickRegistDelegate];
    }
}

/** @刷新 随机用户名*/
- (void)UpdateRandomUserName
{
    if([self.delegate respondsToSelector:@selector(RequireRandomUserName)])
    {
        [self.delegate RequireRandomUserName];
    }
}

/** @设置 随机用户名*/
- (void)SetRandomUserName:(NSString *)userName
{
    [self.RegistNameField setText:userName];
}

/**  @更新一键快速注册 */
- (void)OneQuickRegistShow:(BOOL)bShow
{
    if (bShow)
    {
        [self.OneQuickRegistButton setHidden:NO];
        CGSize size = self.OneQuickRegistButton.frame.size;
        CGPoint point = self.PhoneRegistButton.frame.origin;
        [self.PhoneRegistButton setFrame:CGRectMake(point.x, point.y, size.width, size.height)];
    }
    else
    {
        [self.OneQuickRegistButton setHidden:YES];
        CGSize size = self.RegistButton.frame.size;
        CGPoint point = self.PhoneRegistButton.frame.origin;
        [self.PhoneRegistButton setFrame:CGRectMake(point.x, point.y, size.width, size.height)];
    }
}

@end
