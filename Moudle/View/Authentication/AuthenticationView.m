//
//  AuthenticationView.m
//  QianYu_SDK_IOS
//
//  Created by qianyu on 2019/11/26.
//  Copyright © 2019 qianyu. All rights reserved.
//

#import "AuthenticationView.h"

@interface AuthenticationView()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *AuthNoticeLabel;
@property (weak, nonatomic) IBOutlet UITextField *AuthNameField;
@property (weak, nonatomic) IBOutlet UITextField *AuthNumberField;
@property (weak, nonatomic) IBOutlet UIButton *AuthButton;
- (IBAction)AuthAction:(id)sender;
- (IBAction)CloseAction:(id)sender;
- (IBAction)BackAction:(id)sender;

@end

@implementation AuthenticationView

- (id)init{
    self = [super init];
    NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
    self = [[bundle loadNibNamed:@"AuthenticationView" owner:nil options:nil] lastObject];
    if (self)
    {
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:10.0f];
        [self.AuthButton.layer setMasksToBounds:YES];
        [self.AuthButton.layer setCornerRadius:5.0f];
        
        [self.AuthNameField addTarget:self action:@selector(TextFieldFirstResponder:) forControlEvents:UIControlEventEditingDidBegin];
        [self.AuthNumberField addTarget:self action:@selector(TextFieldFirstResponder:) forControlEvents:UIControlEventEditingDidBegin];
        
        [self.AuthNameField setReturnKeyType:UIReturnKeyNext];
        [self.AuthNameField setDelegate:self];
        [self.AuthNumberField setReturnKeyType:UIReturnKeySend];
        [self.AuthNumberField setDelegate:self];
    }
    return self;
}

/** @键盘返回键 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.AuthNameField)
    {
        [self.AuthNumberField becomeFirstResponder];
    }
    else if (textField == self.AuthNumberField)
    {
        [self.AuthNumberField endEditing:YES];
        [self AuthAction:nil];
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

- (IBAction)AuthAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(AuthAction:withNumber:)])
    {
        NSString *userName = [self.AuthNameField text];
        NSString *userNumber = [self.AuthNumberField text];
        [self.delegate AuthAction:userName withNumber:userNumber];
    }
}

- (IBAction)CloseAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(UpdateCloseDelegate)])
    {
        [self.delegate UpdateCloseDelegate];
    }
}

- (IBAction)BackAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(UpdateBackDelegate)])
    {
        [self.delegate UpdateBackDelegate];
    }
}

@end
