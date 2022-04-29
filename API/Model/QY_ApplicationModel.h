//
//  AppViewModel.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/17.
//

#import "QY_ModelBase.h"
#import "QY_ApplicationAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface QY_ApplicationModel : QY_ModelBase

@property (nonatomic, assign) BOOL noLoad;
@property (nonatomic, copy) NSString * requestTs;   //时间戳
@property (nonatomic, copy) NSString * appId;       //appId


//请求application
- (void)doAppLicationCompleted:(void(^)(QY_ResultBase *result))onCompleted;

@end

NS_ASSUME_NONNULL_END
