//
//  BaseViewModel.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/16.
//

#import <Foundation/Foundation.h>
#import "QY_ResultBase.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^onCompleted)(QY_ResultBase *result);

@interface QY_ModelBase : NSObject

@end

NS_ASSUME_NONNULL_END
