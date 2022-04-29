//
//  HFAPI.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/7/3.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN

typedef void (^GameCallBack)(NSDictionary *resDictionary);

@interface QianYuAPI : NSObject

#pragma mark - 开放接口
/** 初始化SDK 并 打开登录页面 */
+ (void)OpenLoginView:(UIViewController *)MainController withCompleted:(GameCallBack)onCompleted;
/** 打开账号管理 */
+ (void)OpenAccountView:(NSInteger)nType;
/** 打开支付页面 */
+ (void)OpenPayView:(NSDictionary *)params withCompleted:(GameCallBack)onCompleted;
/** 显示悬浮图标 */
+ (void)ShowSuspendView;
/** 隐藏悬浮图标 */
+ (void)HideSuspendView;
/** 登出 */
+ (void)LoginOutEvent;
/** 支付URL */
+ (void)HandleOpenURL:(NSURL *)url;
/** 上报数据 */
+ (void)ReportGameData:(NSDictionary *)params;
/** 复制到黏贴版 */
+ (void)CopyTextToClipboard:(NSString *)text;

+(void)debugTest:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
