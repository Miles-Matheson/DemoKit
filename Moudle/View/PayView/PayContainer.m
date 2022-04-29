//
//  PayContainer.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/19.
//

#import "PayContainer.h"

@implementation PayContainer

- (id)init{
    self = [super init];
    NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
    self = [[bundle loadNibNamed:@"PayContainer" owner:nil options:nil] lastObject];
    return self;
}

@end
