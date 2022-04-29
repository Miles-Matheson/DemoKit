//
//  LoginView.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/13.
//

#import "LoginView.h"
#import "UserListCell.h"

@interface LoginView()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *LoginNameField;
@property (weak, nonatomic) IBOutlet UITextField *LoginPasswordField;
@property (weak, nonatomic) IBOutlet UITableView *UserListTableView;
@property (weak, nonatomic) IBOutlet UIView *LoginNameView;
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;
@property (weak, nonatomic) IBOutlet UIButton *QuickRegistButton;
@property (weak, nonatomic) IBOutlet UIButton *OneQuickRegistButton;
@property (weak, nonatomic) IBOutlet UIButton *BackButton;
@property (assign, nonatomic) NSNumber *uid;
@property (copy, nonatomic) NSString *token;
@property (strong, nonatomic) NSMutableArray *userList;

- (IBAction)LoginAction:(id)sender;
- (IBAction)LoginPasswordFoundAction:(id)sender;
- (IBAction)QuickRegistAction:(id)sender;
- (IBAction)QuitAction:(id)sender;
- (IBAction)DownListAction:(id)sender;
- (IBAction)OneQuickRegistAction:(id)sender;

@end

@implementation LoginView

- (id)init{
    self = [super init];
    NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
    self = [[bundle loadNibNamed:@"LoginView" owner:nil options:nil] lastObject];
    if (self)
    {
        self.uid = 0;
        self.token = @"";
        
        [self.UserListTableView setHidden:YES];
        [self.UserListTableView setDelegate:self];
        [self.UserListTableView setDataSource:self];
        [self.UserListTableView setBounces:NO];
        [self.UserListTableView setPagingEnabled:YES];
        [self.UserListTableView setShowsVerticalScrollIndicator:NO];
        [self.UserListTableView setShowsHorizontalScrollIndicator:NO];
        [self.UserListTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [self.BackButton setHidden:YES];
        [self.LoginButton.layer setMasksToBounds:YES];
        [self.LoginButton.layer setCornerRadius:5.0f];
        [self.QuickRegistButton.layer setMasksToBounds:YES];
        [self.QuickRegistButton.layer setCornerRadius:5.0f];
        [self.OneQuickRegistButton.layer setMasksToBounds:YES];
        [self.OneQuickRegistButton.layer setCornerRadius:5.0f];
        
        [self.LoginNameField addTarget:self action:@selector(ChangedTextField:) forControlEvents:UIControlEventEditingChanged];
        [self.LoginPasswordField addTarget:self action:@selector(ChangedTextField:) forControlEvents:UIControlEventEditingChanged];
        
        [self.LoginNameField addTarget:self action:@selector(TextFieldFirstResponder:) forControlEvents:UIControlEventEditingDidBegin];
        [self.LoginPasswordField addTarget:self action:@selector(TextFieldFirstResponder:) forControlEvents:UIControlEventEditingDidBegin];
        
        [self.LoginNameField setReturnKeyType:UIReturnKeyNext];
        [self.LoginNameField setDelegate:self];
        [self.LoginPasswordField setReturnKeyType:UIReturnKeySend];
        [self.LoginPasswordField setDelegate:self];
    }
    return self;
}

/** @键盘返回键 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.LoginNameField)
    {
        [self.LoginPasswordField becomeFirstResponder];
    }
    else if (textField == self.LoginPasswordField)
    {
        [self.LoginPasswordField endEditing:YES];
        [self LoginAction:nil];
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

/** @监听TextField数值变化 */
-(void)ChangedTextField:(id)textField
{
    self.uid = 0;
    [self UpdateUserListTableViewHide];
    if (textField == self.LoginNameField)
    {
        [self.LoginPasswordField setText:@""];
    }
}

/** @登录 */
- (IBAction)LoginAction:(id)sender {
    [self SetEndEditing];
    [self UpdateUserListTableViewHide];
    
    if (self.uid == 0 || [self.token isEqualToString:@""])
    {
        if([self.delegate respondsToSelector:@selector(RequireLogin:withPassword:)])
        {
            NSString *passport = self.LoginNameField.text;
            NSString *password = self.LoginPasswordField.text;
            [self.delegate RequireLogin:passport withPassword:password];
        }
    }
    else
    {
        if ([self.delegate respondsToSelector:@selector(RequireLoginByToken:withUid:withToken:)])
        {
            NSString *passport = self.LoginNameField.text;
            NSString *uid = [NSString stringWithFormat:@"%@",self.uid];
            NSString *token = self.token;
            [self.delegate RequireLoginByToken:passport withUid:uid withToken:token];
        }
    }
}

/** @切换 找回密码 */
- (IBAction)LoginPasswordFoundAction:(id)sender {
    [self SetEndEditing];
    [self UpdateUserListTableViewHide];
    
    if([self.delegate respondsToSelector:@selector(BackFoundPasswordDelegate)])
    {
        [self.delegate BackFoundPasswordDelegate];
    }
}

/** @切换 快速注册 */
- (IBAction)QuickRegistAction:(id)sender {
    [self SetEndEditing];
    [self UpdateUserListTableViewHide];
    
    if([self.delegate respondsToSelector:@selector(BackQuickRegistDelegate)])
    {
        [self.delegate BackQuickRegistDelegate];
    }
}

/** @退出登录页面 */
- (IBAction)QuitAction:(id)sender {
    [self SetEndEditing];
    [self UpdateUserListTableViewHide];
    
    if([self.delegate respondsToSelector:@selector(QuitActionDelegate)])
    {
        [self.delegate QuitActionDelegate];
    }
}

/** @用户下拉列表 */
- (IBAction)DownListAction:(id)sender {
    [self UpdateUserListTableViewShow];
}

- (IBAction)OneQuickRegistAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(OneQuickRegistDelegate)])
    {
        [self.delegate OneQuickRegistDelegate];
    }
}

/** @更新用户信息 */
- (void)UpdateUserList:(nullable NSDictionary *)myInfo withUserList:(NSArray *)userList
{
    self.userList = [NSMutableArray arrayWithArray:userList];
    CGRect frame = self.LoginNameView.frame;
    CGFloat nHeight = frame.size.height;
    CGFloat nItemY = frame.origin.y + frame.size.height;
    CGFloat nItemH = (self.userList.count > 4) ? (4.8 * nHeight) : (self.userList.count * nHeight);
    
    CGRect tvFrame = self.UserListTableView.frame;
    tvFrame.origin.y = nItemY;
    tvFrame.size.height = nItemH;
    [self.UserListTableView setFrame:tvFrame];
    [self.UserListTableView reloadData];
    
    if ([self.LoginNameField.text isEqualToString:@""] || [self.LoginPasswordField.text isEqualToString:@""])
    {
        if (myInfo != NULL)
        {
            [self UpdateUserInfo:myInfo];
            if ([self.delegate respondsToSelector:@selector(AutoLoginDelegate)])
            {
                [self.delegate AutoLoginDelegate];
            }
        }
        else if ([userList firstObject])
        {
            [self UpdateUserInfo:[userList firstObject]];
            if ([self.delegate respondsToSelector:@selector(AutoLoginDelegate)])
            {
                [self.delegate AutoLoginDelegate];
            }
        }
        else
        {
            self.uid = 0;
            self.token = @"";
            [self.LoginNameField setText:@""];
            [self.LoginPasswordField setText:@""];
        }
    }
    else if (myInfo != NULL)
    {
        [self UpdateUserInfo:myInfo];
    }
}

- (void)UpdateUserInfo:(NSDictionary *)userInfo
{
    NSString *mobile = userInfo[@"mobile"];
    NSString *userName = userInfo[@"userName"];
    NSNumber *uid = userInfo[@"pid"];
    NSString *token = userInfo[@"token"];
    NSString *main_name = userInfo[@"main_name"];
    NSString *loginName = [[KeyController sharedKeyController] GetLoginName];
    NSString *name = @"";
    if (main_name && ![main_name isEqualToString:@""])
    {
        name = main_name;
    }
    else if (loginName && ![loginName isEqualToString:@""] && [loginName isEqualToString:userName])
    {
        name = userName;
    }
    else if (loginName && ![loginName isEqualToString:@""] && [loginName isEqualToString:mobile])
    {
        name = mobile;
    }
    else
    {
        name = (mobile != nil)? mobile : userName;
    }
    if (name && uid && token)
    {
        NSLog(@" name %@", name);
        self.uid = uid;
        self.token = token;
        [self.LoginNameField setText:name];
        [self.LoginPasswordField setText:token];
    }
    else
    {
        self.uid = 0;
        self.token = @"";
        [self.LoginNameField setText:@""];
        [self.LoginPasswordField setText:@""];
    }
}

/**  @更新一键快速注册 */
- (void)OneQuickRegistShow:(BOOL)bShow
{
    if (bShow)
    {
        [self.OneQuickRegistButton setHidden:NO];
        CGSize size = self.OneQuickRegistButton.frame.size;
        CGPoint point = self.QuickRegistButton.frame.origin;
        [self.QuickRegistButton setFrame:CGRectMake(point.x, point.y, size.width, size.height)];
    }
    else
    {
        [self.OneQuickRegistButton setHidden:YES];
        CGSize size = self.LoginButton.frame.size;
        CGPoint point = self.QuickRegistButton.frame.origin;
        [self.QuickRegistButton setFrame:CGRectMake(point.x, point.y, size.width, size.height)];
    }
}

/** @显示隐藏 UserListTableView列表 */
- (void)UpdateUserListTableViewShow
{
    [self SetEndEditing];
    if ([self.UserListTableView isHidden] == YES)
    {
        [self.UserListTableView setHidden:NO];
    }
    else
    {
        [self.UserListTableView setHidden:YES];
    }
}

/** @隐藏 UserListTableView列表 */
- (void)UpdateUserListTableViewHide
{
    [self.UserListTableView setHidden:YES];
}

/** @UserListTableView 代理事件 */
//每个模块的Cell数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.userList.count;
}
//Cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect frame = self.LoginNameView.frame;
    return frame.size.height;
}

//自定义Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"UserListCell";
    UserListCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [UserListCell getCell];
    }
    cell.indexCell = indexPath.row;
    cell.CellModel = self.userList[indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    [cell setSureButton:^(NSInteger indexCell) {
        [weakSelf CellSureButtonAction:indexCell];
    }];
    [cell setDeleteButton:^(NSInteger indexCell) {
        [weakSelf CellDeleteButtonAction:indexCell];
    }];
    return cell;
}

/** @添加  */
- (void)CellSureButtonAction:(NSInteger)indexCell
{
    NSDictionary *info = self.userList[indexCell];
    [self UpdateUserInfo:info];
    [self UpdateUserListTableViewShow];
}

/** @删除  */
- (void)CellDeleteButtonAction:(NSInteger)indexCell
{
    NSDictionary *info = self.userList[indexCell];
    NSNumber *uid = info[@"pid"];
    if (uid != 0 && uid == self.uid)
    {
        [self.LoginNameField setText:@""];
        [self.LoginPasswordField setText:@""];
    }
    if ([self.delegate respondsToSelector:@selector(RemoveUserListDelegate:)])
    {
        [self.delegate RemoveUserListDelegate:indexCell];
    }
    [self UpdateUserListTableViewShow];
}

@end
