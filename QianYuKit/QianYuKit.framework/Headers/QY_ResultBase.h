//
//  BaseResult.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QY_ResultBase : NSObject

@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) id result;
@property (nonatomic, assign) BOOL success;

- (NSString *)netErrorString:(NSError *)error;
+ (NSString *)checkNetError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
