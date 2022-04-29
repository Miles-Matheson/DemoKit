//
//  LimitInput.h
//  YouDao
//
//  Created by lx on 16/9/7.
//  Copyright © 2016年 HZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "UIKit/UIKit.h"


#define PROPERTY_NAME @"limit"

#define DECLARE_PROPERTY(className) \
@interface className (Limit) @end

DECLARE_PROPERTY(UITextField)
DECLARE_PROPERTY(UITextView)

@interface QY_LimitInput : NSObject

@property(nonatomic, assign) BOOL enableLimitCount;

+(QY_LimitInput *) sharedInstance;

@end
