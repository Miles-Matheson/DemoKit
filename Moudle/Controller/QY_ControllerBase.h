//
//  BaseController.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/7/4.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QY_ControllerBase : NSObject

@property (nonatomic, assign) BOOL isVertical;
@property (nonatomic, assign) CGFloat nScreenW;
@property (nonatomic, assign) CGFloat nScreenH;

- (void)InitController;
- (void)handleDeviceOrientationChange;

@end

NS_ASSUME_NONNULL_END
