//
//  AccountView.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/19.
//

#import "BindView.h"

@interface BindView()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *BindTipLable;
@property (weak, nonatomic) IBOutlet UITextField *BindCodeField;
@property (weak, nonatomic) IBOutlet UIButton *CodeButton;
@property (weak, nonatomic) IBOutlet UIButton *BindButton;
@property (weak, nonatomic) IBOutlet UILabel *BindSDKNameLabel;

- (IBAction)BackAccountAction:(id)sender;
- (IBAction)BindeCodeAction:(id)sender;
- (IBAction)BindAction:(id)sender;

@end

@implementation BindView

- (id)init{
    self = [super init];
    NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
    self = [[bundle loadNibNamed:@"BindView" owner:nil options:nil] lastObject];
    if (self)
    {
        [self.BindButton.layer setMasksToBounds:YES];
        [self.BindButton.layer setCornerRadius:5.0f];
        
        [self.BindCodeField addTarget:self action:@selector(TextFieldFirstResponder:) forControlEvents:UIControlEventEditingDidBegin];
        [self.BindCodeField addTarget:self action:@selector(TextFieldFirstResponder:) forControlEvents:UIControlEventEditingDidBegin];
        
        [self.BindCodeField setReturnKeyType:UIReturnKeySend];
        [self.BindCodeField setDelegate:self];
        
        NSString *SDKName = [[KeyController sharedKeyController] GetSDKName];
        [self.BindSDKNameLabel setText:SDKName];
    }
    return self;
}

/** @键盘返回键 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.BindCodeField)
    {
        [self.BindCodeField endEditing:YES];
        [self BindAction:nil];
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

/** @更新绑定页面 bind or newbind */
- (void)UpdateBindViewByMobile:(NSString *)mobile
{
    NSString *oneTitle = @"已绑定手机：";
    NSString *twoTitle = [NSString stringWithFormat:@"%@****%@",[mobile substringToIndex:3],[mobile substringFromIndex:7]];
    NSString *string = [NSString stringWithFormat:@"%@%@",oneTitle,twoTitle];
    NSMutableAttributedString *mutString = [[NSMutableAttributedString alloc]initWithString:string];
    [mutString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, oneTitle.length)];
    [mutString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(oneTitle.length, twoTitle.length)];
    [self.BindTipLable setAttributedText:mutString];
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
    if([self.delegate respondsToSelector:@selector(BackAccountDelegate)])
    {
        [self.delegate BackAccountDelegate];
    }
}

/**  @代理 发送验证码 */
- (IBAction)BindeCodeAction:(id)sender {
    [self SetEndEditing];
    if([self.delegate respondsToSelector:@selector(SendCodeOfBindDelegate)])
    {
        [self.delegate SendCodeOfBindDelegate];
    }
}

/**  @代理 绑定新手机号 */
- (IBAction)BindAction:(id)sender {
    [self SetEndEditing];
    if([self.delegate respondsToSelector:@selector(ReadyToBindNewMobile:)])
    {
        NSString *code = self.BindCodeField.text;
        [self.delegate ReadyToBindNewMobile:code];
    }
}


@end
