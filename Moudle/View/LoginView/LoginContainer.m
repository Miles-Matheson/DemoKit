//
//  LoginContainer.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/13.
//

#import "LoginContainer.h"

@interface LoginContainer()

@property (weak, nonatomic) IBOutlet UILabel *SDKNameLabel;

@end

@implementation LoginContainer

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
    self = [[bundle loadNibNamed:@"LoginContainer" owner:nil options:nil] lastObject];
    if (self)
    {
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:10.0f];
        NSString *SDKName = [[KeyController sharedKeyController] GetSDKName];
        [self.SDKNameLabel setText:SDKName];
    }
    return self;
}


@end
