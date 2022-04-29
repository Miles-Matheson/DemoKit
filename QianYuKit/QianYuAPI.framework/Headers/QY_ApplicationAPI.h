//
//  AppApi.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/17.
//

#import <Foundation/Foundation.h>
#import "QY_ResultBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface QY_ApplicationAPI : NSObject

//请求AppLication
+ (void)doAppLication:(NSDictionary *)params withCompletion:(void(^)(QY_ResultBase *result))completion;

@end

NS_ASSUME_NONNULL_END
