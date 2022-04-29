//
//  AccountController.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/19.
//
//  备注：账号管理器

#import "QY_ControllerBase.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, OpenStatus) {
    None = 0,
    BindPhone,
    ChangePhone
};

@interface QY_AccountController : QY_ControllerBase

@property (nonatomic, copy) void(^SuspendShow)(BOOL state);
@property (nonatomic, copy) void(^GameCallBack)(NSDictionary *resDictionary);

+ (instancetype)sharedAccountController;

/**  @初始化accountview */
- (void)InitAccountView:(NSInteger)nType;

/**  @移除accountview */
- (void)RemoveAccountView;

/**  @上报数据 */
- (void)ReportGameData:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
