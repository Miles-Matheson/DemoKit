//
//  UserListCell.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/25.
//

#import "UserListCell.h"
#import "QY_CommonController.h"

@interface UserListCell()

@property (assign, nonatomic) NSNumber *uid;
@property (weak, nonatomic) IBOutlet UILabel *CellLabel;
- (IBAction)CellButtonAction:(id)sender;
- (IBAction)CellDeleteAction:(id)sender;


@end

@implementation UserListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (UserListCell *)getCell
{
    static NSString *identify = @"UserListCell";
    NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
    UserListCell *cell = [[bundle loadNibNamed:identify owner:self options:nil] objectAtIndex:0];
    return cell;
}

- (void)setCellModel:(NSDictionary *)CellModel
{
    NSNumber *uid = CellModel[@"pid"];
    NSString *mobile = CellModel[@"mobile"];
    NSString *userName = CellModel[@"userName"];
    NSString *mainName = CellModel[@"main_name"];
    self.uid = uid;
    if (mainName && ![mainName isEqualToString:@""])
    {
        [self.CellLabel setText:mainName];
    }
    else if (mobile && ![mobile isEqualToString:@""])
    {
        [self.CellLabel setText:mobile];
    }
    else
    {
        [self.CellLabel setText:userName];
    }
}

//选中
- (IBAction)CellButtonAction:(id)sender {
    self.sureButton(self.indexCell);
}

//删除
- (IBAction)CellDeleteAction:(id)sender {
    self.deleteButton(self.indexCell);
}

@end
