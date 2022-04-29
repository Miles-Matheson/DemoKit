//
//  SecurityUtil.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/7/5.
//

#import "QY_SecurityUtil.h"
#import <CommonCrypto/CommonDigest.h>

@implementation QY_SecurityUtil

+ (NSString *)SHA1StringWithKey:(NSString *)input
{
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

/** url encode 编码 */
+ (NSString *)URLEncodedString:(NSString *)str
{
    NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%/:<>?@&\[]^`{|} "].invertedSet];;
    return encodedString;
}


@end
