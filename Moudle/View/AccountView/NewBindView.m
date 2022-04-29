//
//  AccountView.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/19.
//

#import "NewBindView.h"

@interface NewBindView()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *NewBindSDKNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *NewBindNameField;
@property (weak, nonatomic) IBOutlet UITextField *NewBindCodeField;
@property (weak, nonatomic) IBOutlet UIButton *CodeButton;
@property (weak, nonatomic) IBOutlet UIButton *NewBindButton;

- (IBAction)BackAccountAction:(id)sender;
- (IBAction)NewBindAction:(id)sender;
- (IBAction)NewBindCodeAction:(id)sender;


@end

@implementation NewBindView

- (id)init{
    self = [super init];
    NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
    self = [[bundle loadNibNamed:@"NewBindView" owner:nil options:nil] lastObject];
    if (self)
    {
        [self.NewBindButton.layer setMasksToBounds:YES];
        [self.NewBindButton.layer setCornerRadius:5.0f];
        
        [self.NewBindNameField addTarget:self action:@selector(TextFieldFirstResponder:) forControlEvents:UIControlEventEditingDidBegin];
        [self.NewBindCodeField addTarget:self action:@selector(TextFieldFirstResponder:) forControlEvents:UIControlEventEditingDidBegin];
        
        [self.NewBindNameField setReturnKeyType:UIReturnKeyNext];
        [self.NewBindNameField setDelegate:self];
        [self.NewBindCodeField setReturnKeyType:UIReturnKeySend];
        [self.NewBindCodeField setDelegate:self];
        
        NSString *SDKName = [[KeyController sharedKeyController] GetSDKName];
        [self.NewBindSDKNameLabel setText:SDKName];
    }
    return self;
}

/** @键盘返回键 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.NewBindNameField)
    {
        [self.NewBindCodeField becomeFirstResponder];
    }
    else if (textField == self.NewBindCodeField)
    {
        [self.NewBindCodeField endEditing:YES];
        [self NewBindAction:nil];
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


/**  @代理 返回账号管理页面 */
- (IBAction)BackAccountAction:(id)sender {
    [self SetEndEditing];
    if ([self.delegate respondsToSelector:@selector(BackAccountDelegate)])
    {
        [self.delegate BackAccountDelegate];
    }
}

/**  @代理 绑定 */
- (IBAction)NewBindAction:(id)sender {
    [self SetEndEditing];
    if([self.delegate respondsToSelector:@selector(NewBindNewMobile:withCode:)])
    {
        NSString *mobile = self.NewBindNameField.text;
        NSString *code = self.NewBindCodeField.text;
        [self.delegate NewBindNewMobile:mobile withCode:code];
    }
}

/**  @代理 发送验证码 */
- (IBAction)NewBindCodeAction:(id)sender {
    [self SetEndEditing];
    if ([self.delegate respondsToSelector:@selector(SendCodeOfNewBind:)])
    {
        NSString *mobile = self.NewBindNameField.text;
        [self.delegate SendCodeOfNewBind:mobile];
    }
}


@end
