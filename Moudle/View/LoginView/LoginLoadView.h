//
//  LoginLoadView.h
//  QianYu_SDK_IOS
//
//  Created by qianyu on 2019/10/18.
//  Copyright © 2019 qianyu. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LoginLoadViewDelegate <NSObject>

/**  @代理 点击切换按钮 */
- (void)ClickChangeDelegate;

@end

@interface LoginLoadView : BaseView

@property (nonatomic, weak) id <LoginLoadViewDelegate> delegate;

//更新文本内容
- (void)UpdateLoginLoad;

@end

NS_ASSUME_NONNULL_END
