//
//  AccountViewModel.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/20.
//

#import "QY_AccountModel.h"
#import "QY_AccountAPI.h"

@implementation QY_AccountModel

//普通用户修改密码
- (void)doChangePasswordOfUserCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.requestTs forKey:@"requestTs"];
    [params setValue:self.uid forKey:@"uid"];
    [params setValue:self.token forKey:@"token"];
    [params setValue:self.oPassword forKey:@"oldPassword"];
    [params setValue:self.nPassword forKey:@"newPassword"];
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_AccountAPI doChangePasswordOfUser:params withCompletion:^(QY_ResultBase * _Nonnull result) {
        if (result.success)
        {
            comResult.success = YES;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
        else
        {
            comResult.success = NO;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
    }];
}
//普通用户绑定手机 发送验证码
- (void)doSendCodeOfUserBindMobileCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.requestTs forKey:@"requestTs"];
    [params setValue:self.uid forKey:@"uid"];
    [params setValue:self.token forKey:@"token"];
    [params setValue:self.mobile forKey:@"mobile"];
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_AccountAPI doSendCodeOfUserBindMobile:params withCompletion:^(QY_ResultBase * _Nonnull result) {
        if (result.success)
        {
            comResult.success = YES;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
        else
        {
            comResult.success = NO;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
    }];
}
//普通用户绑定手机
- (void)doBindMobileOfUserCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.requestTs forKey:@"requestTs"];
    [params setValue:self.uid forKey:@"uid"];
    [params setValue:self.token forKey:@"token"];
    [params setValue:self.mobile forKey:@"mobile"];
    [params setValue:self.smsCode forKey:@"smsCode"];
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_AccountAPI doBindMobileOfUser:params withCompletion:^(QY_ResultBase * _Nonnull result) {
        if (result.success)
        {
            comResult.success = YES;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
        else
        {
            comResult.success = NO;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
    }];
}


//手机用户修改密码 发送验证码
- (void)doSendCodeOfMobileToChangePasswordCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.requestTs forKey:@"requestTs"];
    [params setValue:self.uid forKey:@"uid"];
    [params setValue:self.token forKey:@"token"];
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_AccountAPI doSendCodeOfMotileToChangePassword:params withCompletion:^(QY_ResultBase * _Nonnull result) {
        if (result.success)
        {
            comResult.success = YES;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
        else
        {
            comResult.success = NO;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
    }];
}
//手机用户修改密码
- (void)doChangePasswordOfMibileCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.requestTs forKey:@"requestTs"];
    [params setValue:self.uid forKey:@"uid"];
    [params setValue:self.token forKey:@"token"];
    [params setValue:self.smsCode forKey:@"smsCode"];
    [params setValue:self.password forKey:@"password"];
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_AccountAPI doChangePasswordOfMobile:params withCompletion:^(QY_ResultBase * _Nonnull result) {
        if (result.success)
        {
            comResult.success = YES;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
        else
        {
            comResult.success = NO;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
    }];
}
//手机用户变更手机号 发验证码1
- (void)doSendCodeOfMobileOldCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.requestTs forKey:@"requestTs"];
    [params setValue:self.uid forKey:@"uid"];
    [params setValue:self.token forKey:@"token"];
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_AccountAPI doSendCodeOfMobileOld:params withCompletion:^(QY_ResultBase * _Nonnull result) {
        if (result.success)
        {
            comResult.success = YES;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
        else
        {
            comResult.success = NO;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
    }];
}
//手机用户变更手机号 验证验证码1
- (void)doBindMobileOfMobileOldCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.requestTs forKey:@"requestTs"];
    [params setValue:self.uid forKey:@"uid"];
    [params setValue:self.token forKey:@"token"];
    [params setValue:self.smsCode forKey:@"smsCode"];
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_AccountAPI doBindMobileOfMobileOld:params withCompletion:^(QY_ResultBase * _Nonnull result) {
        if (result.success)
        {
            comResult.success = YES;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
        else
        {
            comResult.success = NO;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
    }];
}
//手机用户变更手机号 发验证码2
- (void)doSendCodeOfMobileNewCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.requestTs forKey:@"requestTs"];
    [params setValue:self.uid forKey:@"uid"];
    [params setValue:self.token forKey:@"token"];
    [params setValue:self.mobile forKey:@"mobile"];
    [params setValue:self.smsCode forKey:@"smsCode1"];
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_AccountAPI doSendCodeOfMobileNew:params withCompletion:^(QY_ResultBase * _Nonnull result) {
        if (result.success)
        {
            comResult.success = YES;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
        else
        {
            comResult.success = NO;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
    }];
}
//手机用户变更手机号 验证验证码2
- (void)doBindMobileOfMobileNewCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.requestTs forKey:@"requestTs"];
    [params setValue:self.uid forKey:@"uid"];
    [params setValue:self.token forKey:@"token"];
    [params setValue:self.nickName forKey:@"userName"];
    [params setValue:self.nMobile forKey:@"newMobile"];
    [params setValue:self.smsCode forKey:@"smsCode1"];
    [params setValue:self.nSmsCode forKey:@"smsCode2"];
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_AccountAPI doBindMobileOfMobileNew:params withCompletion:^(QY_ResultBase * _Nonnull result) {
        if (result.success)
        {
            comResult.success = YES;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
        else
        {
            comResult.success = NO;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
    }];
}

//获取小号列表
- (void)doGetSubUserListCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.requestTs forKey:@"requestTs"];
    [params setValue:self.uid forKey:@"uid"];
    [params setValue:self.token forKey:@"token"];
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_AccountAPI doGetSubUserList:params withCompletion:^(QY_ResultBase * _Nonnull result) {
        if (result.success)
        {
            comResult.success = YES;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
        else
        {
            comResult.success = NO;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
    }];
}
//选择小号
- (void)doChooseSubUserCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.requestTs forKey:@"requestTs"];
    [params setValue:self.uid forKey:@"uid"];
    [params setValue:self.token forKey:@"token"];
    [params setValue:self.subPid forKey:@"subPid"];
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_AccountAPI doSelectSubUser:params withCompletion:^(QY_ResultBase * _Nonnull result) {
        if (result.success)
        {
            comResult.success = YES;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
        else
        {
            comResult.success = NO;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
    }];
}
//创建小号
- (void)doCreateSubUserCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.requestTs forKey:@"requestTs"];
    [params setValue:self.uid forKey:@"uid"];
    [params setValue:self.token forKey:@"token"];
    [params setValue:self.nickName forKey:@"nickName"];
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_AccountAPI doCreateSubUser:params withCompletion:^(QY_ResultBase * _Nonnull result) {
        if (result.success)
        {
            comResult.success = YES;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
        else
        {
            comResult.success = NO;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
    }];
}
//上报数据
- (void)doReportGameDataCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.requestTs forKey:@"requestTs"];
    [params setValue:self.uid forKey:@"uid"];
    [params setValue:self.token forKey:@"token"];
    [params setValue:self.roleId forKey:@"roleId"];
    [params setValue:self.roleName forKey:@"roleName"];
    [params setValue:self.serverId forKey:@"serverId"];
    [params setValue:self.serverName forKey:@"serverName"];
    [params setValue:self.roleLevel forKey:@"roleLevel"];
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_AccountAPI doReportGameData:params withCompletion:^(QY_ResultBase * _Nonnull result) {
        if (result.success)
        {
            comResult.success = YES;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
        else
        {
            comResult.success = NO;
            comResult.msg = result.msg;
            comResult.result = result.result;
            onCompleted(comResult);
        }
    }];
}

@end
