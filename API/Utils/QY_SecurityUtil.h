//
//  SecurityUtil.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/7/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QY_SecurityUtil : NSObject

+ (NSString *)SHA1StringWithKey:(NSString *)input;

+ (NSString *)URLEncodedString:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
