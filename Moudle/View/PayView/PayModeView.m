//
//  PayModeView.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/25.
//

#import "PayModeView.h"
#import "PayModeCell.h"

@interface PayModeView()<UITableViewDelegate,UITableViewDataSource>

- (IBAction)BackPayAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *PayModeTableView;
@property (weak, nonatomic) IBOutlet UIView *PayModeViewBG;

@property (assign, nonatomic) CGFloat tableviewH; //tableview高度
@property (strong, nonatomic) NSArray *tPayArray; //支付类型数据

@end

@implementation PayModeView

- (id)init{
    self = [super init];
    NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
    self = [[bundle loadNibNamed:@"PayModeView" owner:nil options:nil] lastObject];
    if (self)
    {
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:10.0];
        [self.PayModeViewBG.layer setMasksToBounds:YES];
        [self.PayModeViewBG.layer setCornerRadius:10.0];
        
        [self.PayModeTableView setDelegate:self];
        [self.PayModeTableView setDataSource:self];
        [self.PayModeTableView setBounces:YES];
        
        [self.PayModeTableView setShowsVerticalScrollIndicator:NO];
        [self.PayModeTableView setShowsHorizontalScrollIndicator:NO];
        [self.PayModeTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return self;
}

/**  @返回支付页面 */
- (IBAction)BackPayAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(BackPayDelegate)])
    {
        [self.delegate BackPayDelegate];
    }
}

/**  @更新tableview */
- (void)UpdateTableViewData:(NSArray *)tPayArray;
{
    self.tableviewH = self.PayModeTableView.frame.size.height;
    if (self.tPayArray == nil)
    {
        self.tPayArray = tPayArray;
    }
    if (self.PayModeTableView)
    {
        [self.PayModeTableView reloadData];
    }
}

/** @UserListTableView 代理事件 */
//每个模块的Cell数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tPayArray.count;
}
//Cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return floor(self.tableviewH / 3);
}

//自定义Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"PayModeCell";
    PayModeCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [PayModeCell getCell];
    }
    cell.indexCell = indexPath.row;
    cell.CellModel = self.tPayArray[indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    [cell setSureButton:^(NSInteger indexCell) {
        [weakSelf CellSureButtonAction:indexCell];
    }];
    return cell;
}

/** @确定事件  */
- (void)CellSureButtonAction:(NSInteger)indexCell
{
    NSDictionary *info = self.tPayArray[indexCell];
    if ([self.delegate respondsToSelector:@selector(UpdatePayModeDelegate:)])
    {
        [self.delegate UpdatePayModeDelegate:info];
    }
}


@end
