//
//  PayModeCell.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PayModeCell : UITableViewCell

@property (nonatomic, assign) NSInteger indexCell;
@property (nonatomic, strong) NSDictionary *CellModel;
@property (nonatomic, strong) void(^sureButton)(NSInteger indexCell);

+ (PayModeCell *)getCell;

@end

NS_ASSUME_NONNULL_END
