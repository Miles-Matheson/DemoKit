//
//  KeyController.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/18.
//

#import "KeyController.h"
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>
#import "QY_SecurityUtil.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "QY_Reachability.h"
#import "SSHKeychain.h"

#define USERDEFAULTS    [NSUserDefaults standardUserDefaults]
#define TIMEDIFF        @"timediff"
#define USERLIST        @"userlist"
#define USERINFO        @"userinfo"
#define USERLOGIN       @"userlogin"
#define AUTOLOGIN       @"autologin"
#define SERVICEQQ       @"serviceQQ"
#define SERVICEPHONE    @"servicePhone"
#define MAINPAYTYPE     @"mainpaytype"
#define EMPTYPASSWORD   @"emptyPassword"
#define LOGINNAME       @"loginname"
#define NETMONITOR      @"netmonitor"

#define IN_DEVELOPMENT  YES

@interface KeyController()

@property (nonatomic, strong) UIViewController *MainController;

//@property (nonatomic, copy) NSString * hf-sdk-mobile-model;         //手机型号
//@property (nonatomic, copy) NSString * hf-sdk-app-version;          //ios: CFBundleShortVersionString
//@property (nonatomic, copy) NSString * hf-sdk-app-version-code;     //ios: CFBundleVersion
//@property (nonatomic, copy) NSString * hf-sdk-idfa;                 //ios:idfa, 获取不到可为空  注：模拟器会崩
//@property (nonatomic, copy) NSString * hf-sdk-idfv;                 //ios:idfv
//@property (nonatomic, copy) NSString * hf-sdk-android-id;           //ios:为空
//@property (nonatomic, copy) NSString * hf-sdk-x-udid;               //从钥匙串获取该值,如果钥匙串没有,则生成UUID然后存在钥匙串
//@property (nonatomic, copy) NSString * hf-sdk-imei;                 //获取不到或者没有权限获取 可以为空
//@property (nonatomic, copy) NSString * hf-sdk-network-operator;     //网络运营商(获取不到可不获取)
//@property (nonatomic, copy) NSString * hf-sdk-network-type;         //网络类型(wifi,3g,4g,2g,mobile(流量))
//@property (nonatomic, copy) NSString * hf-sdk-package-name;         //ios: bundleid,android:packagename
//@property (nonatomic, copy) NSString * hf-sdk-os;                   //ios:直接标ios
//@property (nonatomic, copy) NSString * hf-sdk-os-version;           //os版本
//@property (nonatomic, copy) NSString * hf-sdk-sdk-version;          //hf-sdk的版本

@end

@implementation KeyController

static id _instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return  _instance;
}

+ (instancetype)sharedKeyController
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return  _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

/** @设置主要控制器 */
- (void)SetMainController:(UIViewController *)MainController
{
    if (!_MainController)
    {
        _MainController = MainController;
    }
}

/** @获取主要控制器 */
- (UIViewController *)GetMainController
{
    return _MainController;
}

/** @初始化 储存数据 */
- (void)SetAppLicationInit:(NSDictionary *)valueDict
{
    NSString *serverTime = [valueDict objectForKey:@"serverTime"];
    NSArray *userList = [valueDict objectForKey:@"userList"];
    NSString *serviceQQ = [valueDict objectForKey:@"kefuQQ"];
    NSString *servicePhone = [valueDict objectForKey:@"kefuPhone"];
    BOOL netMonitor = [[valueDict objectForKey:@"netMonitor"] boolValue];
    
    [self SetSuspendState:netMonitor];
    [self UpdateServerTime:serverTime];
    [self SetServiceQQ:serviceQQ andPhone:servicePhone];
    for(int i=1; i<[userList count]; i++)
    {
        NSDictionary *info = userList[i];
        [self InsertToUserList:info];
    }
}

/** @获取key字典 */
- (NSMutableDictionary *)GetKeyDictionary
{
    NSString *mobileModel = [self GetDeviceModel];
    NSString *mobileIDFV = [self GetDeviceIDFV];
    NSString *mobileVersion = [self GetDeviceVersion];
    NSString *mobileOS = [self GetDeviceOS];
    NSString *bundleVersion = [self GetBundleVersion];
    NSString *mobileIDFA = [self GetDeviceIDFA];
    NSString *operatorName = [self getMobileOperatorsName];
    NSString *mobileOSVersion = [self GetOSVersion];
    NSString *mobileNetType = [self GetNetType];
    NSString *sdkVersion = [self GetSDKVersion];
    NSString *bundleID = [self GetBundleID];
    NSString *mobileUDID = [self GetDeviceUDID];

    NSMutableDictionary *mutDict = [[NSMutableDictionary alloc] init];
    [mutDict setValue:mobileModel forKey:@"qy-sdk-mobile-model"];
    [mutDict setValue:mobileIDFV forKey:@"qy-sdk-idfv"];
    [mutDict setValue:mobileVersion forKey:@"qy-sdk-app-version"];
    [mutDict setValue:mobileOS forKey:@"qy-sdk-os"];
    [mutDict setValue:bundleVersion forKey:@"qy-sdk-app-version-code"];
    [mutDict setValue:mobileIDFA forKey:@"qy-sdk-idfa"]; //"00000000-0000-0000-0000-000000000000"
    [mutDict setValue:operatorName forKey:@"qy-sdk-network-operator"];
    [mutDict setValue:mobileOSVersion forKey:@"qy-sdk-os-version"];
    [mutDict setValue:mobileNetType forKey:@"qy-sdk-network-type"];
    [mutDict setValue:sdkVersion forKey:@"qy-sdk-sdk-version"];
    [mutDict setValue:bundleID forKey:@"qy-sdk-package-name"];
    [mutDict setValue:mobileUDID forKey:@"qy-sdk-x-udid"];
    
    //NSLog(@"\n\n\n====\n %@ =====\n\n\n\n",mutDict);
    return mutDict;
}

/** @获取appId */
- (NSString *)GetAppId
{
    NSString *paths = [[NSBundle mainBundle] pathForResource:@"QianYuInfo" ofType:@"plist"];
    NSDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:paths];
    NSString *appId = dict[@"appId"];
    return appId;
}

/** @获取ClientKey TODO */
- (NSString *)GetClientKey
{
    NSString *paths = [[NSBundle mainBundle] pathForResource:@"QianYuInfo" ofType:@"plist"];
    NSDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:paths];
    NSString *key = dict[@"clientKey"];
    return key;
}

/** @获取OneLoginKey */
- (NSString *)GetOneLoginKey
{
    NSString *paths = [[NSBundle mainBundle] pathForResource:@"QianYuInfo" ofType:@"plist"];
    NSDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:paths];
    NSString *key = dict[@"ologinKey"];
    return key;
}

/** @获取SDKName TODO */
- (NSString *)GetSDKName
{
    NSString *paths = [[NSBundle mainBundle] pathForResource:@"QianYuInfo" ofType:@"plist"];
    NSDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:paths];
    NSString *name = dict[@"name"];
    return name;
}

/** @获取是否测试环境 */
- (BOOL)GetInDevelopment
{
    return IN_DEVELOPMENT;
}

/** @获取ServerHost TODO */
- (NSString *)GetServerHost
{    NSString *serverHost = @"http://101.33.212.126:8082/x_service";
    if (IN_DEVELOPMENT)
    {
        serverHost = @"http://101.33.212.126:8082";
        //serverHost = @"http://106.13.145.60:8082";
    }
    return serverHost;
}

/** @获取ServerIndex TODO */
- (NSString *)GetServerIndex
{
    NSString *serverIndex = @"";
    if (IN_DEVELOPMENT)
    {
        serverIndex = @"/x_service";
    }
    return serverIndex;
}

/** @获取ServerSign TODO */
- (NSString *)GetServerSign
{
    NSString *ServerSign = @"hf-sdk-sign";
    return ServerSign;
}

/** @获取ServerSymbol TODO */
- (NSString *)GetServerSymbol
{
    NSString *ServerSymbol = @"&x_sdk_!@#$%&";
    return ServerSymbol;
}

/** @获取PayList TODO */
- (NSMutableArray *)GetPayList
{
    NSDictionary *pay1 = @{@"key":@"weixin", @"icon":@"hl_icon_wechat", @"name":@"微信支付"};
    NSDictionary *pay2 = @{@"key":@"alipay", @"icon":@"hl_icon_alipay", @"name":@"支付宝"};
    NSDictionary *pay3 = @{@"key":@"jdpay", @"icon":@"hl_icon_jdpay", @"name":@"京东支付"};
    NSMutableArray *payList = [NSMutableArray array];
    [payList addObject:pay1];
    [payList addObject:pay2];
    [payList addObject:pay3];
    return payList;
}

#pragma mark - DeviceDetail
/** @获取手机型号 */
- (NSString *)GetDeviceModel
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    return deviceModel;
}

/** @获取IDFV */
- (NSString *)GetDeviceIDFV
{
    NSString *deviceIDFV = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return deviceIDFV;
}

/** @获取CFBundleVersion */
- (NSString *)GetBundleVersion
{
    NSString *versionString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    return versionString;
}

/** @获取CFBundleVersion */
- (NSString *)GetBundleID
{
    NSString *bundleID = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    return bundleID;
}

/** @获取IDFA */
- (NSString *)GetDeviceIDFA
{
    NSString *deviceIDFA = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    return deviceIDFA;
}

/** @获取hf-sdk-app-version */
- (NSString *)GetDeviceVersion
{
    NSString *deviceVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return deviceVersion;
}

/** @获取hf-sdk-os */
- (NSString *)GetDeviceOS
{
    NSString *deviceOS = @"ios";
    return deviceOS;
}

/** @获取hf-sdk-os-version */
- (NSString *)GetOSVersion
{
    NSString *osVersion = [UIDevice currentDevice].systemVersion;
    return osVersion;
}

/** @获取营业商 */
- (NSString *)getMobileOperatorsName
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    if (carrier == nil)
    {
        return @"0";
    }
    NSString *code = [carrier mobileNetworkCode];
    switch (code.intValue) {
        case 00:
        case 02:
        case 07:
            return @"China Mobile";
            break;
        case 01:
        case 06:
            return @"China Unicom";
            break;
        case 03:
        case 05:
            return @"China Telecom";
            break;
        case 20:
            return @"China Tietong";
            break;
        default:
            break;
    }
    return @"Not In China";
}

/** @获取网络类型 */
- (NSString *)GetNetType
{
    NSString *netType = @"";
    QY_Reachability *reach = [QY_Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:// 没有网络
        {
            netType = @"no network";
        }
            break;
        case ReachableViaWiFi:// Wifi
        {
            netType = @"Wifi";
        }
            break;
        case ReachableViaWWAN:// 手机自带网络
        {
            // 获取手机网络类型
            CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
            NSString *currentStatus = info.currentRadioAccessTechnology;
            if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {
                netType = @"GPRS";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
                netType = @"2.75G EDGE";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){
                netType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){
                netType = @"3.5G HSDPA";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){
                netType = @"3.5G HSUPA";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
                netType = @"2G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
                netType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
                netType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
                netType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){
                netType = @"HRPD";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
                netType = @"4G";
            }
        }
            break;
        default:
            break;
    }
    return netType;
}

/** @获取hf-sdk-sdk-version */
- (NSString *)GetSDKVersion
{
    NSString *sdkVersion = @"1.0.0";
    return sdkVersion;
}

- (NSString *)GetDeviceUDID
{
    NSString *serviceName= @"com.qianyugame.pdby";
    NSString *account = @"qianyusdk_name";
    NSString *password = [SSHKeychain passwordForService:serviceName account:account];
    if (password == NULL || [password isEqualToString:@""])
    {
        password = [self GetUUID];
        if ([SSHKeychain setPassword:password forService:serviceName account:account])
        {
            //NSLog(@" === [Set UUID Success] === ");
        }
    }
    //NSLog(@" ===== name:%@",serviceName);
    //NSLog(@" ===== account:%@",account);
    //NSLog(@" ===== password:%@",password);
    return password;
}

/** @生成UUID*/
- (NSString *)GetUUID
{
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuid));
    CFRelease(uuid);
    return uuidString;
}

#pragma mark - DeviceInfo
/** @获取当前时间戳 */
- (NSString *)GetNowTimetamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%0.f", a];
    return timeString;
}

/** @获取当前时间戳 客户端 + 时间偏移量 */
- (NSString *)GetServerTime
{
    NSString *diff = [USERDEFAULTS objectForKey:TIMEDIFF];
    NSInteger now = [[self GetNowTimetamp] integerValue]*1000 + [diff integerValue];
    return [NSString stringWithFormat:@"%ld", (long)now];
}

- (void)SetSuspendState:(BOOL)bFlag
{
    [USERDEFAULTS setValue:@(bFlag) forKey:NETMONITOR];
    [USERDEFAULTS synchronize];
}

- (BOOL)GetSuspendState
{
    NSNumber * boolNum = [USERDEFAULTS objectForKey:NETMONITOR];
    BOOL bFlag = [boolNum boolValue];
    return bFlag;
}

/** @更新 时间偏移量 服务端 - 客户端 */
- (void)UpdateServerTime:(NSString *)serverTime
{
    NSInteger now = [[self GetNowTimetamp] integerValue];
    NSInteger diff = [serverTime integerValue] - now*1000;
    [USERDEFAULTS setValue:[NSString stringWithFormat:@"%ld",(long)diff] forKey:TIMEDIFF];
    [USERDEFAULTS synchronize];
}

/** @退出账号 */
- (void)LoginOutAccount
{
    //[USERDEFAULTS setValue:nil forKey:USERINFO];
    [USERDEFAULTS setValue:@(NO) forKey:USERLOGIN];
    [USERDEFAULTS setValue:@(NO) forKey:AUTOLOGIN];
    [USERDEFAULTS setValue:@(NO) forKey:EMPTYPASSWORD];
    [USERDEFAULTS synchronize];
}

/** @设置客服QQ和电话 */
- (void)SetServiceQQ:(NSString *)qq andPhone:(NSString *)phone
{
    [USERDEFAULTS setValue:qq forKey:SERVICEQQ];
    [USERDEFAULTS setValue:phone forKey:SERVICEPHONE];
    [USERDEFAULTS synchronize];
}

/** @获取客服QQ */
- (NSString *)GetServiceQQ
{
    NSString *qq = [USERDEFAULTS objectForKey:SERVICEQQ];
    return qq;
}

/** @获取客服电话 */
- (NSString *)GetServicePhone
{
    NSString *phone = [USERDEFAULTS objectForKey:SERVICEPHONE];
    return phone;
}

#pragma mark - userInfo
/** @更新玩家信息 */
- (void)UpdateUserInfo:(NSDictionary *)userInfo
{
    NSMutableDictionary *newInfo = [NSMutableDictionary dictionaryWithDictionary:userInfo];
    NSString *mobile = userInfo[@"mobile"];
    NSString *userName = userInfo[@"userName"];
    NSString *loginName = [self GetLoginName];
    if (loginName && ![loginName isEqualToString:@""] && [loginName isEqualToString:userName])
    {
        [newInfo setValue:loginName forKey:@"main_name"];
    }
    else if (loginName && ![loginName isEqualToString:@""] && [loginName isEqualToString:mobile])
    {
        [newInfo setValue:mobile forKey:@"main_name"];
    }
    
    [self InsertToUserList:newInfo];
    BOOL emptyPassword = [userInfo[@"emptyPassword"] boolValue];
    [USERDEFAULTS setValue:newInfo forKey:USERINFO];
    [USERDEFAULTS setValue:@(YES) forKey:USERLOGIN];
    [USERDEFAULTS setValue:@(YES) forKey:AUTOLOGIN];
    [USERDEFAULTS setValue:@(emptyPassword) forKey:EMPTYPASSWORD];
    [USERDEFAULTS synchronize];
}

/** @获取玩家信息 */
- (NSDictionary *)GetUserInfo
{
    NSDictionary *userInfo = [USERDEFAULTS objectForKey:USERINFO];
    return userInfo;
}

/** @获取玩家是否登录 */
- (BOOL)GetUserLogin
{
    NSNumber * boolNum = [USERDEFAULTS objectForKey:USERLOGIN];
    BOOL bLogin = [boolNum boolValue];
    return bLogin;
}

/** @设置是否自动登录 */
- (void)SetAutoLogin:(BOOL)bAuto
{
    [USERDEFAULTS setValue:@(bAuto) forKey:AUTOLOGIN];
    [USERDEFAULTS synchronize];
}

/** @获取是否自动登录 */
- (BOOL)GetAutoLogin
{
    NSNumber * boolNum = [USERDEFAULTS objectForKey:AUTOLOGIN];
    BOOL bLogin = [boolNum boolValue];
    return bLogin;
}

/** @获取玩家密码是否为空 */
- (BOOL)GetUserEmptyPassword
{
    NSNumber * emptyPassword = [USERDEFAULTS objectForKey:EMPTYPASSWORD];
    BOOL bEmptyPassword = [emptyPassword boolValue];
    return bEmptyPassword;
}

/** @获取uid */
- (NSString *)GetUserUid
{
    //注: 登录成功的pid 就是 uid
    NSDictionary *userInfo = [self GetUserInfo];
    return userInfo[@"pid"];
}

/** @获取Token */
- (NSString *)GetUserToken
{
    NSDictionary *userInfo = [self GetUserInfo];
    return userInfo[@"token"];
}

/** @获取Mobile */
- (NSString *)GetUserMobile
{
    NSDictionary *userInfo = [self GetUserInfo];
    return userInfo[@"mobile"];
}

/** @获取用户名 */
- (NSString *)GetUserName
{
    NSDictionary *userInfo = [self GetUserInfo];
    return userInfo[@"userName"];
}

/** @设置登录的账号名*/
- (void)SetLoginName:(NSString *)name
{
    [USERDEFAULTS setValue:name forKey:LOGINNAME];
    [USERDEFAULTS synchronize];
}

/** @获取登录的账号名*/
- (NSString *)GetLoginName;
{
    NSString *name = [USERDEFAULTS objectForKey:LOGINNAME];
    return name;
}

#pragma mark - userList
/** @获取userList */
- (NSArray *)GetUserList
{
    NSArray *userList = [USERDEFAULTS objectForKey:USERLIST];
    return userList;
}

/** @添加数据到userList */
- (void)InsertToUserList:(NSDictionary *)info;
{
    long pid = [info[@"pid"] longValue];
    NSArray *userList = [self GetUserList];
    NSMutableArray *mutArray = [NSMutableArray arrayWithArray:userList];
    for(int i=0; i<mutArray.count; i++)
    {
        NSDictionary *data = mutArray[i];
        if ([data[@"pid"] longValue] == pid)
        {
            [mutArray removeObjectAtIndex:i];
            break;
        }
    }
    [mutArray insertObject:info atIndex:0];
    [self SetUserList:mutArray];
}

/** @储存userList */
- (void)SetUserList:(NSArray *)userList
{
    [USERDEFAULTS setValue:userList forKey:USERLIST];
    [USERDEFAULTS synchronize];
}

/** @移除玩家信息 */
- (NSArray *)RemoveUserListByIndex:(NSInteger)index
{
    NSArray *userList = [self GetUserList];
    NSMutableArray *resultList = [NSMutableArray arrayWithArray:userList];
    //移除账号时，若是自己账号也移除默认数据
    NSDictionary *userInfo = [resultList objectAtIndex:index];
    NSDictionary *curUserInfo = [self GetUserInfo];
    if(userInfo[@"pid"] == curUserInfo[@"pid"])
    {
        [USERDEFAULTS setValue:nil forKey:USERINFO];
        [USERDEFAULTS setValue:@(NO) forKey:USERLOGIN];
        [USERDEFAULTS setValue:@(NO) forKey:AUTOLOGIN];
        [USERDEFAULTS setValue:@(NO) forKey:EMPTYPASSWORD];
        [USERDEFAULTS synchronize];
    }
    [resultList removeObjectAtIndex:index];
    [self SetUserList:resultList];
    return resultList;
}

/** @获取玩家最常用支付方式 */
- (NSString *)GetMainPayType:(NSArray *)typeArray
{
    NSString *tPay = [USERDEFAULTS objectForKey:MAINPAYTYPE];
    if (tPay == nil)
    {
        tPay = [typeArray firstObject];
        [USERDEFAULTS setValue:tPay forKey:MAINPAYTYPE];
        [USERDEFAULTS synchronize];
    }
    else
    {
        BOOL bExist = NO;
        for (NSString *type in typeArray) {
            if ([type isEqualToString:tPay])
            {
                bExist = YES;
                break;
            }
        }
        if (!bExist)
        {
            tPay = [typeArray firstObject];
            [USERDEFAULTS setValue:tPay forKey:MAINPAYTYPE];
            [USERDEFAULTS synchronize];
        }
    }
    return tPay;
}

/** @设置玩家最常用支付方式 */
- (void)SetMainPayType:(NSString *)tPay
{
    [USERDEFAULTS setValue:tPay forKey:MAINPAYTYPE];
    [USERDEFAULTS synchronize];
}

#pragma mark - WebService
// @拼接URL
- (NSString *)HandleServerURL:(NSString *)host withURL:(NSString *)url withParams:(NSDictionary *)dict
{
    NSString *msg = [NSString stringWithFormat:@"%@%@?",host,url];
    NSArray *keys = [dict allKeys];
    for (int i=0; i<keys.count; i++)
    {
        NSString *str = (i == keys.count - 1)? @"%@=%@" : @"%@=%@&";
        NSString *oldString = [NSString stringWithFormat:@"%@",[dict valueForKey:keys[i]]];
        NSString *encodeString = [QY_SecurityUtil URLEncodedString:oldString];
        msg = [msg stringByAppendingFormat:str,keys[i],encodeString];
    }
    return msg;
}

// @处理GET请求头 字典参数
- (NSString *)HandleServerHead:(NSString *)url withKeys:(NSDictionary *)keys withParams:(NSDictionary *)dict withSymbol:(NSString *)symbol withClientKey:(NSString *)clientKey
{
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionaryWithDictionary:keys];
    [mutDict addEntriesFromDictionary:dict];
    
    //排序
    NSArray *allKeys = [mutDict allKeys];
    NSArray *sortKeys = [allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    //拼接
    NSString *msg = url;
    for(int i=0; i<sortKeys.count; i++)
    {
        msg = [msg stringByAppendingFormat:@"&%@=%@",sortKeys[i], [mutDict objectForKey:sortKeys[i]]];
    }
    //拼末尾
    msg = [msg stringByAppendingFormat:@"%@%@",symbol,clientKey];
    //签名
    //NSLog(@" 签名前：%@",msg);
    NSString *datamsg = [QY_SecurityUtil SHA1StringWithKey:msg];
    //NSLog(@" 签名后：%@",datamsg);
    return datamsg;
}

@end
