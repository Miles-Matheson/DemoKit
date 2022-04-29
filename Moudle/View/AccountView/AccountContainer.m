//
//  AccountContainer.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/19.
//

#import "AccountContainer.h"

@implementation AccountContainer

- (id)init{
    self = [super init];
    NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
    self = [[bundle loadNibNamed:@"AccountContainer" owner:nil options:nil] lastObject];
    if (self)
    {
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:10.0f];
    }
    return self;
}

@end
