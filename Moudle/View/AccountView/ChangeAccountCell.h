//
//  ChangeAccountCell.h
//  QianYu_SDK_IOS
//
//  Created by qianyu on 2019/10/9.
//  Copyright © 2019 qianyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChangeAccountCell : UITableViewCell

@property (nonatomic, assign) NSInteger indexCell;
@property (nonatomic, strong) NSDictionary *CellModel;
@property (nonatomic, strong) void(^selectedButton)(NSString *subPid);

+ (ChangeAccountCell *)getCell;

@end

NS_ASSUME_NONNULL_END
