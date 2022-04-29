//
//  AppViewModel.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/17.
//

#import "QY_ApplicationModel.h"

@implementation QY_ApplicationModel

//请求application
- (void)doAppLicationCompleted:(void(^)(QY_ResultBase *result))onCompleted
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.appId forKey:@"appId"];
    [params setValue:self.requestTs forKey:@"requestTs"];
    [params setValue:@(self.noLoad) forKey:@"noLoad"];
    self.noLoad = NO;
    
    QY_ResultBase *comResult = [[QY_ResultBase alloc] init];
    [QY_ApplicationAPI doAppLication:params withCompletion:^(QY_ResultBase * _Nonnull result) {
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
