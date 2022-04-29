//
//  PayModeCell.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/25.
//

#import "PayModeCell.h"
#import "QY_CommonController.h"

@interface PayModeCell()

@property (weak, nonatomic) IBOutlet UIImageView *CellLogo;
@property (weak, nonatomic) IBOutlet UILabel *CellTitle;

- (IBAction)ClickCellAction:(id)sender;

@end

@implementation PayModeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (PayModeCell *)getCell
{
    static NSString *identify = @"PayModeCell";
    NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
    PayModeCell *cell = [[bundle loadNibNamed:identify owner:self options:nil] objectAtIndex:0];
    return cell;
}

- (void)setCellModel:(NSDictionary *)CellModel
{
    NSString *icon = CellModel[@"icon"];
    NSString *name = CellModel[@"name"];
    UIImage *image = [[QY_CommonController sharedComController] GetCurrentImage:icon];
    [self.CellLogo setImage:image];
    [self.CellTitle setText:name];
}

- (IBAction)ClickCellAction:(id)sender {
    self.sureButton(self.indexCell);
}

@end
