//
//  LoginViewModel.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/16.
//

#import "QY_LoginModel.h"
#import "QY_LoginAPI.h"


@implementation QY_LoginModel

//账号注册
- (void)doRegistCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.requestTs forKey:@"requestTs"];
    [params setValue:self.userName forKey:@"userName"];
    [params setValue:self.password forKey:@"password"];
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_LoginAPI doRegist:params withCompletion:^(QY_ResultBase * _Nonnull result) {
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
//登录
- (void)doLoginCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.requestTs forKey:@"requestTs"];
    [params setValue:self.passport forKey:@"passport"];
    [params setValue:self.password forKey:@"password"];
    [params setValue:@(self.noLoad) forKey:@"noLoad"];
    self.noLoad = NO;
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_LoginAPI doLogin:params withCompletion:^(QY_ResultBase * _Nonnull result) {
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
//随机用户名
- (void)doRandomUserNameCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.requestTs forKey:@"requestTs"];
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_LoginAPI doRandomUserName:params withCompletion:^(QY_ResultBase * _Nonnull result) {
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
//发送验证码 快速注册
- (void)doSendSmsOfRegistCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.requestTs forKey:@"requestTs"];
    [params setValue:self.mobile forKey:@"mobile"];
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_LoginAPI doSendSmsOfRegist:params withCompletion:^(QY_ResultBase * _Nonnull result) {
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
//快速注册 -- 手机号 密码 验证码
- (void)doQuickRegistCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.requestTs forKey:@"requestTs"];
    [params setValue:self.mobile forKey:@"mobile"];
    [params setValue:self.smsCode forKey:@"smsCode"];
    [params setValue:self.password forKey:@"password"];
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_LoginAPI doQuickRegist:params withCompletion:^(QY_ResultBase * _Nonnull result) {
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
//发送验证码 找回密码
- (void)doSendSmsOfFoundCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.requestTs forKey:@"requestTs"];
    [params setValue:self.mobile forKey:@"mobile"];
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_LoginAPI doSendSmsOfFound:params withCompletion:^(QY_ResultBase * _Nonnull result) {
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
//找回密码
- (void)doFoundPasswordCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.requestTs forKey:@"requestTs"];
    [params setValue:self.mobile forKey:@"mobile"];
    [params setValue:self.password forKey:@"password"];
    [params setValue:self.smsCode forKey:@"smsCode"];
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_LoginAPI doFoundPassword:params withCompletion:^(QY_ResultBase * _Nonnull result) {
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
//Token自动登录
- (void)doAutoLoginCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.requestTs forKey:@"requestTs"];
    [params setValue:self.uid forKey:@"uid"];
    [params setValue:self.token forKey:@"token"];
    [params setValue:@(self.noLoad) forKey:@"noLoad"];
    self.noLoad = NO;
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_LoginAPI doAutoLogin:params withCompletion:^(QY_ResultBase * _Nonnull result) {
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
//一键快速注册
- (void)doOneQuickRegistCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.requestTs forKey:@"requestTs"];

    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_LoginAPI doOneQucikRegist:params withCompletion:^(QY_ResultBase * _Nonnull result) {
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
//一键登录
- (void)doOneLoginCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.requestTs forKey:@"requestTs"];
    [params setValue:self.processID forKey:@"process_id"];
    [params setValue:self.token forKey:@"token"];
    [params setValue:@(self.noLoad) forKey:@"noLoad"];
    self.noLoad = NO;
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_LoginAPI doOneLogin:params withCompletion:^(QY_ResultBase * _Nonnull result) {
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
