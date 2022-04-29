//
//  AccountView.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/19.
//

#import "ChangePasswordView.h"

@interface ChangePasswordView()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *ChangePassworkSDKNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *ChangePasswordNameField;
@property (weak, nonatomic) IBOutlet UITextField *ChangePasswordField;
@property (weak, nonatomic) IBOutlet UITextField *ChangeRePasswordField;
@property (weak, nonatomic) IBOutlet UIButton *ChangePasswordButton;
@property (weak, nonatomic) IBOutlet UIView *InputViewFirst; //第一个原密码输入框

- (IBAction)BackAccountAction:(id)sender;
- (IBAction)ChangeAction:(id)sender;
- (IBAction)ChangePasswordNameEyeAction:(id)sender;
- (IBAction)ChangePasswordEyeAction:(id)sender;
- (IBAction)ChangeRePasswordEyeAction:(id)sender;

@end

@implementation ChangePasswordView

- (id)init{
    self = [super init];
    NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
    self = [[bundle loadNibNamed:@"ChangePasswordView" owner:nil options:nil] lastObject];
    if (self)
    {
        [self.ChangePasswordButton.layer setMasksToBounds:YES];
        [self.ChangePasswordButton.layer setCornerRadius:5.0f];
        
        [self.ChangePasswordNameField addTarget:self action:@selector(TextFieldFirstResponder:) forControlEvents:UIControlEventEditingDidBegin];
        [self.ChangePasswordField addTarget:self action:@selector(TextFieldFirstResponder:) forControlEvents:UIControlEventEditingDidBegin];
        [self.ChangeRePasswordField addTarget:self action:@selector(TextFieldFirstResponder:) forControlEvents:UIControlEventEditingDidBegin];
        
        [self.ChangePasswordNameField setReturnKeyType:UIReturnKeyNext];
        [self.ChangePasswordNameField setDelegate:self];
        [self.ChangePasswordField setReturnKeyType:UIReturnKeyNext];
        [self.ChangePasswordField setDelegate:self];
        [self.ChangeRePasswordField setReturnKeyType:UIReturnKeySend];
        [self.ChangeRePasswordField setDelegate:self];
        
        NSString *SDKName = [[KeyController sharedKeyController] GetSDKName];
        [self.ChangePassworkSDKNameLabel setText:SDKName];
    }
    return self;
}

/** @无密码则隐藏第一行 */
- (void)UpdateChangePasswordState{
    BOOL bEmptyPassword = [[KeyController sharedKeyController] GetUserEmptyPassword];
    //密码为空，设置密码
    if(bEmptyPassword == YES)
    {
        [self.InputViewFirst setHidden:YES];
    }
    else
    {
        [self.InputViewFirst setHidden:NO];
    }
}

/** @键盘返回键 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.ChangePasswordNameField)
    {
        [self.ChangePasswordField becomeFirstResponder];
    }
    else if (textField == self.ChangePasswordField)
    {
        [self.ChangeRePasswordField becomeFirstResponder];
    }
    else if (textField == self.ChangeRePasswordField)
    {
        [self.ChangeRePasswordField endEditing:YES];
        [self ChangeAction:nil];
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

/**  @代理 返回账号管理页面 */
- (IBAction)BackAccountAction:(id)sender {
    [self SetEndEditing];
    if ([self.delegate respondsToSelector:@selector(BackAccountDelegate)])
    {
        [self.delegate BackAccountDelegate];
    }
}

/**  @代理 修改密码 */
- (IBAction)ChangeAction:(id)sender {
    [self SetEndEditing];
    if ([self.delegate respondsToSelector:@selector(ChangePassword:withNew:withReNew:)])
    {
        NSString *oPassword = self.ChangePasswordNameField.text;
        NSString *nPassword = self.ChangePasswordField.text;
        NSString *sPassword = self.ChangeRePasswordField.text;
        [self.delegate ChangePassword:oPassword withNew:nPassword withReNew:sPassword];
    }
}

- (IBAction)ChangePasswordNameEyeAction:(UIButton *)sender {
    [[QY_CommonController sharedComController] SetTextFieldEye:self.ChangePasswordNameField withButton:sender];
}

- (IBAction)ChangePasswordEyeAction:(UIButton *)sender {
    [[QY_CommonController sharedComController] SetTextFieldEye:self.ChangePasswordField withButton:sender];
}

- (IBAction)ChangeRePasswordEyeAction:(UIButton *)sender {
    [[QY_CommonController sharedComController] SetTextFieldEye:self.ChangeRePasswordField withButton:sender];
}


@end
