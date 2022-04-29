//
//  ChangeAccountCell.m
//  QianYu_SDK_IOS
//
//  Created by qianyu on 2019/10/9.
//  Copyright © 2019 qianyu. All rights reserved.
//

#import "ChangeAccountCell.h"
#import "QY_CommonController.h"

@interface ChangeAccountCell()

@property (weak, nonatomic) IBOutlet UILabel *NickNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *HeadImage;
@property (nonatomic, copy) NSString *subPid;

- (IBAction)SelectedAction:(id)sender;

@end

@implementation ChangeAccountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (ChangeAccountCell *)getCell
{
    static NSString *identify = @"ChangeAccountCell";
    NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
    ChangeAccountCell *cell = [[bundle loadNibNamed:identify owner:self options:nil] objectAtIndex:0];
    return cell;
}

- (void)setCellModel:(NSDictionary *)CellModel
{
    NSString *subPid = [NSString stringWithFormat:@"%@", CellModel[@"subPid"]];
    NSString *nickName = [NSString stringWithFormat:@"%@", CellModel[@"nickName"]];
    NSString *isDefault = [NSString stringWithFormat:@"%@", CellModel[@"isDefault"]];
    
    self.subPid = subPid;
    BOOL state = [isDefault isEqualToString:@"2"]? NO : YES;
    [self.NickNameLabel setText:nickName];
    [self.HeadImage setHidden:state];
}

- (IBAction)SelectedAction:(id)sender {
    self.selectedButton(self.subPid);
}

@end
