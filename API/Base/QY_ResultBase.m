//
//  BaseResult.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/16.
//

#import "QY_ResultBase.h"

@implementation QY_ResultBase

- (NSString *)netErrorString:(NSError *)error{
    NSString *result = @"网络连接异常，请稍后再试";
    switch (error.code) {
        case NSURLErrorTimedOut:
            result = @"连接超时，请稍后再试";
            break;
        case NSURLErrorBadServerResponse:
        case NSURLErrorDataLengthExceedsMaximum:
            result = @"系统繁忙，请稍后再试";
            break;
        case NSURLErrorNotConnectedToInternet:
            result = @"网络已断开，请检查网络设置";
            break;
        case NSURLErrorUnsupportedURL:
        case NSURLErrorCannotFindHost:
        case NSURLErrorCannotConnectToHost:
        case NSURLErrorNetworkConnectionLost:
        case NSURLErrorDNSLookupFailed:
            result = @"无法连接服务器，请稍后再试";
            break;
        default:
            break;
    }
    return result;
}

+ (NSString *)checkNetError:(NSError *)error{
    NSString *result = @"网络连接异常，请稍后再试";
    switch (error.code) {
        case NSURLErrorTimedOut:
            result = @"连接超时，请稍后再试";
            break;
        case NSURLErrorBadServerResponse:
        case NSURLErrorDataLengthExceedsMaximum:
            result = @"系统繁忙，请稍后再试";
            break;
        case NSURLErrorNotConnectedToInternet:
            result = @"网络已断开，请检查网络设置";
            break;
        case NSURLErrorUnsupportedURL:
        case NSURLErrorCannotFindHost:
        case NSURLErrorCannotConnectToHost:
        case NSURLErrorNetworkConnectionLost:
        case NSURLErrorDNSLookupFailed:
            result = @"无法连接服务器，请稍后再试";
            break;
        default:
            break;
    }
    return result;
}


@end
