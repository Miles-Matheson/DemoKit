//
//  AccountViewModel.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/20.
//

#import "QY_ModelBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface QY_AccountModel : QY_ModelBase

@property (nonatomic, copy) NSString * appId;
@property (nonatomic, copy) NSString * requestTs;
@property (nonatomic, copy) NSString * uid;
@property (nonatomic, copy) NSString * token;

@property (nonatomic, copy) NSString * mobile;
@property (nonatomic, copy) NSString * smsCode;
@property (nonatomic, copy) NSString * password;
@property (nonatomic, copy) NSString * oPassword;
@property (nonatomic, copy) NSString * nPassword;

@property (nonatomic, copy) NSString * nMobile;
@property (nonatomic, copy) NSString * nSmsCode;

@property (nonatomic, copy) NSString * subPid;
@property (nonatomic, copy) NSString * nickName;

//上报数据
@property (nonatomic, copy) NSString * roleId;
@property (nonatomic, copy) NSString * roleName;
@property (nonatomic, copy) NSString * serverId;
@property (nonatomic, copy) NSString * serverName;
@property (nonatomic, copy) NSString * roleLevel;

//普通用户修改密码
- (void)doChangePasswordOfUserCompleted:(void(^)(QY_ResultBase *result))onCompleted;
//普通用户绑定手机 发送验证码
- (void)doSendCodeOfUserBindMobileCompleted:(void(^)(QY_ResultBase *result))onCompleted;
//普通用户绑定手机
- (void)doBindMobileOfUserCompleted:(void(^)(QY_ResultBase *result))onCompleted;


//手机用户修改密码 发送验证码
- (void)doSendCodeOfMobileToChangePasswordCompleted:(void(^)(QY_ResultBase *result))onCompleted;
//手机用户修改密码
- (void)doChangePasswordOfMibileCompleted:(void(^)(QY_ResultBase *result))onCompleted;
//手机用户变更手机号 发验证码1
- (void)doSendCodeOfMobileOldCompleted:(void(^)(QY_ResultBase *result))onCompleted;
//手机用户变更手机号 验证验证码1
- (void)doBindMobileOfMobileOldCompleted:(void(^)(QY_ResultBase *result))onCompleted;
//手机用户变更手机号 发验证码2
- (void)doSendCodeOfMobileNewCompleted:(void(^)(QY_ResultBase *result))onCompleted;
//手机用户变更手机号 验证验证码2
- (void)doBindMobileOfMobileNewCompleted:(void(^)(QY_ResultBase *result))onCompleted;

//获取小号列表
- (void)doGetSubUserListCompleted:(void(^)(QY_ResultBase *result))onCompleted;
//选择小号
- (void)doChooseSubUserCompleted:(void(^)(QY_ResultBase *result))onCompleted;
//创建小号
- (void)doCreateSubUserCompleted:(void(^)(QY_ResultBase *result))onCompleted;
//上报数据
- (void)doReportGameDataCompleted:(void(^)(QY_ResultBase *result))onCompleted;

@end

NS_ASSUME_NONNULL_END
