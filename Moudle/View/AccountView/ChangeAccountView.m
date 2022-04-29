//
//  ChangeAccountView.m
//  QianYu_SDK_IOS
//
//  Created by qianyu on 2019/10/9.
//  Copyright © 2019 qianyu. All rights reserved.
//

#import "ChangeAccountView.h"
#import "ChangeAccountCell.h"

@interface ChangeAccountView()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *NickNameField;
@property (weak, nonatomic) IBOutlet UIView *ChangeNickNameView;
@property (weak, nonatomic) IBOutlet UILabel *CurrentInfoLabel;
@property (weak, nonatomic) IBOutlet UITableView *AccountTableView;
@property (strong, nonatomic) NSMutableArray *userList;

- (IBAction)BackAction:(id)sender;
- (IBAction)CreateAccountAction:(id)sender;

@end

@implementation ChangeAccountView

- (id)init{
    self = [super init];
    NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
    self = [[bundle loadNibNamed:@"ChangeAccountView" owner:nil options:nil] lastObject];
    if (self)
    {
        [self.AccountTableView setDelegate:self];
        [self.AccountTableView setDataSource:self];
        [self.AccountTableView setBounces:YES];
        [self.AccountTableView setPagingEnabled:NO];
        [self.AccountTableView setShowsVerticalScrollIndicator:NO];
        [self.AccountTableView setShowsHorizontalScrollIndicator:NO];
        [self.AccountTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [self.NickNameField setReturnKeyType:UIReturnKeySend];
        [self.NickNameField setDelegate:self];
    }
    return self;
}

/** @键盘返回键 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.NickNameField)
    {
        [self CreateAccountAction:nil];
    }
    return YES;
}

//创建小号
- (IBAction)CreateAccountAction:(id)sender {
    if([self.delegate respondsToSelector:@selector(CreateSubUserDelegate:)])
    {
        NSString *nickName = self.NickNameField.text;
        nickName = nickName == nil? @"":nickName;
        [self.delegate CreateSubUserDelegate:nickName];
        [self.NickNameField endEditing:YES];
    }
}

//返回
- (IBAction)BackAction:(id)sender {
    if([self.delegate respondsToSelector:@selector(BackAccountDelegate)])
    {
        [self.delegate BackAccountDelegate];
    }
}

//刷新小号列表
- (void)UpdateSubUserTableView:(NSArray *)userList
{
    self.userList = [NSMutableArray arrayWithArray:userList];
    [self UpdateCurrentInfo];
    [self.AccountTableView reloadData];
}

//新增小号
- (void)InsertSubUserInfo:(NSDictionary *)userInfo
{
    [self.userList addObject:userInfo];
    [self.AccountTableView reloadData];
}

//更新选中小号状态
- (void)UpdateSubUserState:(NSString *)subPid
{
    for (int index=0; index<[self.userList count]; index++)
    {
        NSDictionary *userInfo = [self.userList objectAtIndex:index];
        NSString *pid = [NSString stringWithFormat:@"%@", [userInfo objectForKey:@"subPid"]];
        NSString *nickName = [NSString stringWithFormat:@"%@", [userInfo objectForKey:@"nickName"]];
        NSString *isDefault = [pid isEqualToString:subPid]? @"2" : @"1";
        
        NSMutableDictionary *mutInfo = [[NSMutableDictionary alloc] init];
        [mutInfo setValue:pid forKey:@"subPid"];
        [mutInfo setValue:nickName forKey:@"nickName"];
        [mutInfo setValue:isDefault forKey:@"isDefault"];
        [self.userList replaceObjectAtIndex:index withObject:mutInfo];
    }
    [self UpdateCurrentInfo];
    [self.AccountTableView reloadData];
}

//更新当前角色信息
- (void)UpdateCurrentInfo
{
    NSString *msg = @"";
    for (NSDictionary *userInfo in self.userList) {
        NSString *nickName = [NSString stringWithFormat:@"%@", [userInfo objectForKey:@"nickName"]];
        NSString *isDefault = [NSString stringWithFormat:@"%@", [userInfo objectForKey:@"isDefault"]];
        if([isDefault isEqualToString:@"2"])
        {
            msg = [NSString stringWithFormat:@"当前选择用户:%@",nickName];
        }
    }
    [self.CurrentInfoLabel setText:msg];
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
    CGRect frame = self.ChangeNickNameView.frame;
    return frame.size.height;
}

//自定义Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"ChangeAccountCell";
    ChangeAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [ChangeAccountCell getCell];
    }
    cell.indexCell = indexPath.row;
    cell.CellModel = self.userList[indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    [cell setSelectedButton:^(NSString * _Nonnull subPid) {
        if([weakSelf.delegate respondsToSelector:@selector(SelectedSubUserDelegate:)])
        {
            [weakSelf.delegate SelectedSubUserDelegate:subPid];
        }
    }];
    return cell;
}

@end
