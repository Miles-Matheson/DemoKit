//
//  KeyController.h
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/18.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyController : NSObject

+ (instancetype)sharedKeyController;

/** @设置主要控制器 */
- (void)SetMainController:(UIViewController *)MainController;

/** @获取主要控制器 */
- (UIViewController *)GetMainController;

/** @初始化 储存数据 */
- (void)SetAppLicationInit:(NSDictionary *)valueDict;

/** @获取key字典 */
- (NSMutableDictionary *)GetKeyDictionary;

/** @获取appId */
- (NSString *)GetAppId;

/** @获取SDKName */
- (NSString *)GetSDKName;

/** @获取是否测试环境 */
- (BOOL)GetInDevelopment;

/** @获取ServerHost TODO */
- (NSString *)GetServerHost;

/** @获取ServerIndex TODO */
- (NSString *)GetServerIndex;

/** @获取ServerSign TODO */
- (NSString *)GetServerSign;

/** @获取ServerSymbol TODO */
- (NSString *)GetServerSymbol;

/** @获取PayList TODO */
- (NSMutableArray *)GetPayList;

/** @获取客户端本地时间戳 */
- (NSString *)GetNowTimetamp;

/** @获取当前时间戳 客户端 + 时间偏移量 */
- (NSString *)GetServerTime;

/** @退出账号 */
- (void)LoginOutAccount;

/** @获取客服QQ */
- (NSString *)GetServiceQQ;

/** @获取客服电话 */
- (NSString *)GetServicePhone;

/** @获取悬浮状态 */
- (BOOL)GetSuspendState;

#pragma mark - userInfo
/** @更新玩家信息 */
- (void)UpdateUserInfo:(NSDictionary *)userInfo;

/** @获取玩家是否登录*/
- (BOOL)GetUserLogin;

/** @设置是否自动登录*/
- (void)SetAutoLogin:(BOOL)bAuto;

/** @获取是否自动登录*/
- (BOOL)GetAutoLogin;

/** @获取玩家密码是否为空 */
- (BOOL)GetUserEmptyPassword;

/** @获取ClientKey */
- (NSString *)GetClientKey;

/** @获取OneLoginKey */
- (NSString *)GetOneLoginKey;

/** @获取玩家信息 */
- (NSDictionary *)GetUserInfo;

/** @获取uid */
- (NSString *)GetUserUid;

/** @获取Token */
- (NSString *)GetUserToken;

/** @获取Mobile */
- (NSString *)GetUserMobile;

/** @获取用户名 */
- (NSString *)GetUserName;

/** @生成UUID*/
- (NSString *)GetUUID;

/** @设置登录的账号名*/
- (void)SetLoginName:(NSString *)name;

/** @获取登录的账号名*/
- (NSString *)GetLoginName;

#pragma mark - userList
/** @获取userList */
- (NSArray *)GetUserList;

/** @添加数据到userList */
- (void)InsertToUserList:(NSDictionary *)info;

/** @移除玩家信息 */
- (NSArray *)RemoveUserListByIndex:(NSInteger)index;

/** @获取玩家最常用支付方式 */
- (NSString *)GetMainPayType:(NSArray *)typeArray;

/** @设置玩家最常用支付方式 */
- (void)SetMainPayType:(NSString *)tPay;

#pragma mark - WebService
// @拼接URL
- (NSString *)HandleServerURL:(NSString *)host withURL:(NSString *)url withParams:(NSDictionary *)dict;

// @处理GET请求头 字典参数
- (NSString *)HandleServerHead:(NSString *)url withKeys:(NSDictionary *)keys withParams:(NSDictionary *)dict withSymbol:(NSString *)symbol withClientKey:(NSString *)clientKey;

@end

NS_ASSUME_NONNULL_END
