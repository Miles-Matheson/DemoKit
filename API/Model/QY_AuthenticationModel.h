//
//  AuthViewModel.h
//  QianYu_SDK_IOS
//
//  Created by qianyu on 2019/11/27.
//  Copyright © 2019 qianyu. All rights reserved.
//

#import "QY_ModelBase.h"
#import "QY_AuthenticationAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface QY_AuthenticationModel : QY_ModelBase

@property (nonatomic, assign) BOOL noLoad;
@property (nonatomic, copy) NSString * requestTs;   //时间戳
@property (nonatomic, copy) NSString * appId;       //appId
@property (nonatomic, copy) NSString * uid;         //playerUserId
@property (nonatomic, copy) NSString * token;         //token

@property (nonatomic, copy) NSString * realName;    //realName
@property (nonatomic, copy) NSString * idCardNo;    //idCardNo

//请求Authentication
- (void)doAuthenticationCompleted:(void(^)(QY_ResultBase *result))onCompleted;
//请求Certification
- (void)doCertificationCompleted:(void(^)(QY_ResultBase *result))onCompleted;

@end

NS_ASSUME_NONNULL_END
