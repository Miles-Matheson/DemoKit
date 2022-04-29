//
//  AccountView.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/19.
//

#import "ChangeBindView.h"

@interface ChangeBindView()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *ChangeBindSDKNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *ChangeBindNameField;
@property (weak, nonatomic) IBOutlet UITextField *ChnageBindCodeField;
@property (weak, nonatomic) IBOutlet UIButton *CodeButton;
@property (weak, nonatomic) IBOutlet UIButton *ChangeBindButton;
@property (weak, nonatomic) IBOutlet UIView *ChangeBindNickNameView;
@property (weak, nonatomic) IBOutlet UITextField *ChangeBindNickNameField;
@property (copy, nonatomic) NSString *oCode;
@property (copy, nonatomic) NSString *oNick;

- (IBAction)BackBindViewAction:(id)sender;
- (IBAction)ChangeBindCodeAction:(id)sender;
- (IBAction)ChangeBindAction:(id)sender;
- (IBAction)ChangeBindNickNameAction:(id)sender;

@end

@implementation ChangeBindView

- (id)init{
    self = [super init];
    NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
    self = [[bundle loadNibNamed:@"ChangeBindView" owner:nil options:nil] lastObject];
    if (self)
    {
        [self.ChangeBindButton.layer setMasksToBounds:YES];
        [self.ChangeBindButton.layer setCornerRadius:5.0f];

        [self.ChangeBindNameField addTarget:self action:@selector(TextFieldFirstResponder:) forControlEvents:UIControlEventEditingDidBegin];
        [self.ChnageBindCodeField addTarget:self action:@selector(TextFieldFirstResponder:) forControlEvents:UIControlEventEditingDidBegin];
        
        [self.ChangeBindNameField setReturnKeyType:UIReturnKeyNext];
        [self.ChangeBindNameField setDelegate:self];
        [self.ChnageBindCodeField setReturnKeyType:UIReturnKeySend];
        [self.ChnageBindCodeField setDelegate:self];
        
        NSString *SDKName = [[KeyController sharedKeyController] GetSDKName];
        [self.ChangeBindSDKNameLabel setText:SDKName];
    }
    return self;
}

/** @键盘返回键 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.ChangeBindNameField)
    {
        [self.ChnageBindCodeField becomeFirstResponder];
    }
    else if (textField == self.ChnageBindCodeField)
    {
        [self.ChnageBindCodeField endEditing:YES];
        [self ChangeBindAction:nil];
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

/** @传递 验证一 验证码 */
- (void)PassMobileCodeAction:(NSString *)code
{
    self.oCode = code;
    NSString *sNick = [[KeyController sharedKeyController] GetUserName];
    if (sNick == nil || [sNick isEqualToString:@""])
    {
        [self.ChangeBindNickNameField setText:@""];
        [self.ChangeBindNickNameView setHidden:NO];
    }
    else
    {
        [self.ChangeBindNickNameField setText:@""];
        [self.ChangeBindNickNameView setHidden:YES];
    }
}

/**  @代理 返回绑定手机号页面 */
- (IBAction)BackBindViewAction:(id)sender {
    [self SetEndEditing];
    if ([self.delegate respondsToSelector:@selector(BackBindViewDelegate)])
    {
        [self.delegate BackBindViewDelegate];
    }
}

/**  @代理 发送验证码 */
- (IBAction)ChangeBindCodeAction:(id)sender {
    [self SetEndEditing];
    if ([self.delegate respondsToSelector:@selector(SendCodeOfChangeBind:withOldCode:)])
    {
        NSString *mobile = self.ChangeBindNameField.text;
        [self.delegate SendCodeOfChangeBind:mobile withOldCode:self.oCode];
    }
}

/**  @代理 绑定新手机号 */
- (IBAction)ChangeBindAction:(id)sender {
    [self SetEndEditing];
    if ([self.delegate respondsToSelector:@selector(ChangeBindNewMobile:withNickName:withOldCode:withNewCode:)])
    {
        NSString *nick = self.ChangeBindNickNameField.text;
        NSString *mobile = self.ChangeBindNameField.text;
        NSString *code = self.ChnageBindCodeField.text;
        [self.delegate ChangeBindNewMobile:mobile withNickName:nick withOldCode:self.oCode withNewCode:code];
    }
}

- (IBAction)ChangeBindNickNameAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(RequireRandomUserName)])
    {
        [self.delegate RequireRandomUserName];
    }
}

/** @设置 随机用户名*/
- (void)SetRandomUserName:(NSString *)userName
{
    [self.ChangeBindNickNameField setText:userName];
}


@end
