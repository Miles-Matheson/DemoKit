//
//  PayController.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/19.
//

#import "QY_PayController.h"
#import "PayContainer.h"
#import "PayView.h"
#import "PayModeView.h"
#import "BaseMaskView.h"
#import "PayWebView.h"

#import "QY_PayModel.h"
#import "KeyController.h"
#import "QY_StatusController.h"

@interface QY_PayController()<PayViewDelegate,PayModeViewDelegate,PayWebViewDelegate>

@property (nonatomic, strong) BaseMaskView *BaseMaskView;
@property (nonatomic, strong) PayContainer *PayContainer;
@property (nonatomic, strong) PayView *PayView;
@property (nonatomic, strong) PayModeView *PayModeView;
@property (nonatomic, strong) PayWebView *PayWebView;

@property (nonatomic, copy) NSString *PayKey;  //支付类型
@property (nonatomic, copy) NSString *OrderId;  //订单ID
@property (nonatomic, copy) NSString *PayType;  //支付类型
@property (nonatomic, strong) NSArray *PayTypeList; //支付类型列表
@property (nonatomic, strong) NSDictionary *OrderData; //订单数据
@property (nonatomic, strong) NSMutableArray *payList; //支付选择列表

@end

@implementation QY_PayController

static id _instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return  _instance;
}

+ (instancetype)sharedPayController
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

- (NSMutableArray *)payList
{
    if (!_payList)
    {
        _payList = [[KeyController sharedKeyController] GetPayList];
    }
    return _payList;
}

#pragma mark - 懒加载
- (BaseMaskView *)BaseMaskView
{
    if (!_BaseMaskView)
    {
        _BaseMaskView = [[BaseMaskView alloc] init];
        [_BaseMaskView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f]];
        [_BaseMaskView setFrame:CGRectMake(0, 0, self.nScreenW, self.nScreenH)];
    }
    return _BaseMaskView;
}

- (PayContainer *)PayContainer
{
    if (!_PayContainer)
    {
        CGFloat nItemW = self.nScreenW >= self.nScreenH? 0.9 * self.nScreenH : 0.9 * self.nScreenW;
        nItemW = nItemW > 400 ? 400 : nItemW;
        CGFloat nItemH = nItemW * (7.0 / 8.0);
        _PayContainer = [[PayContainer alloc] init];
        [_PayContainer setFrame:CGRectMake(0, 0, nItemW, nItemH)];
        [_PayContainer setCenter:CGPointMake(self.nScreenW/2.0, self.nScreenH/2.0)];
        [_BaseMaskView addSubview:_PayContainer];
    }
    return _PayContainer;
}

- (PayView *)PayView
{
    if (!_PayView)
    {
        _PayView = [[PayView alloc] init];
        [_PayContainer addSubview:_PayView];
        CGSize SuperSize = _PayView.superview.frame.size;
        [_PayView setFrame:CGRectMake(0, 0, SuperSize.width, SuperSize.height)];
        [_PayView setDelegate:self];
    }
    return _PayView;
}

- (PayModeView *)PayModeView
{
    if (!_PayModeView)
    {
        _PayModeView = [[PayModeView alloc] init];
        [_PayContainer addSubview:_PayModeView];
        CGSize SuperSize = _PayModeView.superview.frame.size;
        [_PayModeView setFrame:CGRectMake(0, 0, SuperSize.width, SuperSize.height)];
        [_PayModeView setDelegate:self];
    }
    return _PayModeView;
}

- (PayWebView *)PayWebView
{
    if (!_PayWebView)
    {
        _PayWebView = [[PayWebView alloc] init];
        [_PayWebView setFrame:CGRectMake(0, 0, self.nScreenW, self.nScreenH)];
        [_PayWebView setDelegate:self];
        [_BaseMaskView addSubview:_PayWebView];
    }
    return _PayWebView;
}

/**  @初始化payview */
- (void)InitPayView:(NSDictionary *)dictionary
{
    [self InitController];
    QY_PayModel *vm = [[QY_PayModel alloc] init];
    vm.appId = [[KeyController sharedKeyController] GetAppId];
    vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
    vm.uid = [[KeyController sharedKeyController] GetUserUid];
    vm.token = [[KeyController sharedKeyController] GetUserToken];
    
    vm.callbackInfo = dictionary[@"callbackInfo"];
    vm.amount = dictionary[@"amount"];
    vm.itemId = dictionary[@"itemId"];
    vm.itemName = dictionary[@"itemName"];
    vm.roleId = dictionary[@"roleId"];
    vm.roleName = dictionary[@"roleName"];
    vm.roleLevel = dictionary[@"roleLevel"];
    vm.serverId = dictionary[@"serverId"];
    vm.serverName = dictionary[@"serverName"];
    vm.cpOrderId = dictionary[@"cpOrderId"];
    vm.notifyUrl = dictionary[@"notifyUrl"];
    
    __weak typeof(self) weakSelf = self;
    weakSelf.OrderData = dictionary; //储存订单信息
    [vm doPlaceOrderCompleted:^(QY_ResultBase * _Nonnull result) {
        if (result.success)
        {
            NSDictionary *data = result.result;
            NSArray *payTypes = data[@"payTypes"];
            NSLog(@" ====== payTypes %@", payTypes);
            weakSelf.OrderId = data[@"orderId"];
            [weakSelf InitPayOrderInfo:payTypes];
        }
        else
        {
            //NSLog(@" ===== Get Pay Info Failed ===== ");
        }
    }];
}

/** @初始化订单数据 */
- (void)InitPayOrderInfo:(NSArray *)payTypes
{
    self.PayTypeList = [self HandlePayTypeList:payTypes];
    self.PayKey = [[KeyController sharedKeyController] GetMainPayType:payTypes];
    NSDictionary *mainPay = [self GetMainPayTypeInfo:self.PayTypeList withMainKey:self.PayKey];
    
    UIViewController *unityController = [[KeyController sharedKeyController] GetMainController];
    [unityController.view addSubview:self.BaseMaskView];
    [self.BaseMaskView setCenter:unityController.view.center];
    [self.PayContainer setHidden:NO];
    [self.PayView ViewDidAppear:YES];
    __weak typeof(self) weakSelf = self;
    [self.PayView setPayTypeBlock:^(NSString * _Nonnull tPay) {
        weakSelf.PayType = tPay;
    }];
    [self.PayView InitPayView:self.OrderData withMainPay:mainPay];
    [self handleDeviceOrientationChange];
}

//获取配置文件的支付列表
- (NSArray *)HandlePayTypeList:(NSArray *)list
{
    for (NSInteger index=self.payList.count-1; index>=0; index--)
    {
        NSDictionary *item = self.payList[index];
        NSString *payKey = item[@"key"];
        BOOL bExist = NO;
        for (NSString *key in list)
        {
            if ([key isEqualToString:payKey])
            {
                bExist = YES;
                break;
            }
        }
        if (bExist == NO)
        {
            [self.payList removeObjectAtIndex:index];
        }
    }
    return self.payList;
}

//获取主要支付方式数据
- (NSDictionary *)GetMainPayTypeInfo:(NSArray *)payList withMainKey:(NSString *)key
{
    for (NSDictionary *item in payList)
    {
        NSString *payKey = item[@"key"];
        if ([payKey isEqualToString:key])
        {
            return item;
        }
    }
    NSDictionary *firstItem = [payList firstObject];
    return firstItem;
}

/**  @移除PayView */
- (void)RemovePayView
{
    [self.PayView setDelegate:nil];
    [self.PayView setDelegate:nil];
    
    [self.PayView DestroyView];
    [self.PayModeView DestroyView];
    [self.PayContainer DestroyView];
    [self.BaseMaskView DestroyView];
    [self.PayWebView DestroyView];
    
    self.PayView = nil;
    self.PayModeView = nil;
    self.PayContainer = nil;
    self.BaseMaskView = nil;
    self.PayWebView = nil;
}

/**  @支付方式显示 */
- (void)PayModeViewShow
{
    
    [self.PayModeView ViewDidAppear:YES];
    [self.PayModeView UpdateTableViewData:self.PayTypeList];
}

/**  @支付方式隐藏 */
- (void)PayModeViewHide
{
    [self.PayView ViewDidAppear:YES];
    [self.PayModeView ViewDidDisappear];
    [self.PayWebView ViewDidDisappear];
}

/** @显示支付webview */
- (void)PayWebViewShow:(NSString *)url
{
    [self.PayWebView ViewDidAppear:YES];
    [self.PayWebView UpdatePayWebView:url];
    [self.PayContainer ViewDidDisappear];
    [self handleDeviceOrientationChange];
}

/** @显示支付页面 */
- (void)PayViewShow
{
    [self.PayWebView ViewDidDisappear];
    [self.PayContainer ViewDidAppear:YES];
}

#pragma mark - PayViewDelegate
/**  @代理 退出支付页面 */
- (void)QuitPayDelegate
{
    [self RemovePayView];
}

/**  @代理 选择其他支付方式 */
- (void)ChangePayModeDelegate
{
    [self PayModeViewShow];
}

/**  @代理 支付功能 */
- (void)PayDelegate
{
    //NSBundle *bundle = [[ComController sharedComController] GetCurrentBundle];
    //NSString *paths = [[NSBundle mainBundle] pathForResource:@"HFConfig" ofType:@"plist"];
    //NSDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:paths];
    //NSString *serverHost = dict[@"serverHost"];
    //NSString *serverIndex = dict[@"serverIndex"];
    //NSString *serverSign = dict[@"serverSign"];
    //NSString *serverSymbol = dict[@"serverSymbol"];
    NSString *serverHost = [[KeyController sharedKeyController] GetServerHost];
    NSString *serverIndex = [[KeyController sharedKeyController] GetServerIndex];
    NSString *serverSign = [[KeyController sharedKeyController] GetServerSign];
    NSString *serverSymbol = [[KeyController sharedKeyController] GetServerSymbol];
    NSString *hostURL = [NSString stringWithFormat:@"%@%@",serverHost,serverIndex];
    NSString *url = @"/pay/startH5Pay";
    
    NSString *appId = [[KeyController sharedKeyController] GetAppId];
    NSString *requestTs = [[KeyController sharedKeyController] GetServerTime];
    NSString *uid = [[KeyController sharedKeyController] GetUserUid];
    NSString *token = [[KeyController sharedKeyController] GetUserToken];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:appId forKey:@"appId"];
    [params setValue:requestTs forKey:@"requestTs"];
    [params setValue:uid forKey:@"uid"];
    [params setValue:token forKey:@"token"];
    [params setValue:self.PayType forKey:@"payway"];
    [params setValue:self.OrderId forKey:@"orderId"];
    
    NSString *clientKey = [[KeyController sharedKeyController] GetClientKey];
    NSString *headURL = [NSString stringWithFormat:@"%@%@",serverIndex,url];
    NSMutableDictionary *keys = [NSMutableDictionary dictionary];
    NSString *serverHead = [[KeyController sharedKeyController] HandleServerHead:headURL withKeys:keys withParams:params withSymbol:serverSymbol withClientKey:clientKey];
    [params setValue:serverHead forKey:serverSign];
    
    NSString *serverURL = [[KeyController sharedKeyController] HandleServerURL:hostURL withURL:url withParams:params];
    //url不能包含ASSIC码
    serverURL = [serverURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self PayWebViewShow:serverURL];
}

#pragma mark - PayModeViewDelegate
/**  @代理 返回支付页面 */
- (void)BackPayDelegate
{
    [self PayModeViewHide];
}

/**  @代理 更新支付模式 */
- (void)UpdatePayModeDelegate:(NSDictionary *)info
{
    //存储主要的支付方式
    self.PayKey = [info objectForKey:@"key"];
    [[KeyController sharedKeyController] SetMainPayType:self.PayKey];
    
    [self.PayView UpdatePayModeInfo:info];
    [self PayModeViewHide];
}

#pragma mark - PayWebViewDelegate
/**  @代理 支付成功 */
- (void)PaySuccessDelegate
{
    QY_PayModel *vm = [[QY_PayModel alloc] init];
    vm.appId = [[KeyController sharedKeyController] GetAppId];
    vm.requestTs = [[KeyController sharedKeyController] GetServerTime];
    vm.uid = [[KeyController sharedKeyController] GetUserUid];
    vm.token = [[KeyController sharedKeyController] GetUserToken];
    vm.orderId = self.OrderId;
    __weak typeof(self) weakSelf = self;
    [vm doQueryOrderCompleted:^(QY_ResultBase * _Nonnull result) {
        NSNumber * boolNum = result.result;
        BOOL bSuccess = [boolNum boolValue];
        if (result.success && bSuccess)
        {
            [weakSelf PaySuccessEvent];
        }
        else
        {
            [weakSelf PayFailedEvent];
        }
    }];
}

/**  @代理 支付失败 */
- (void)PayFailedDelegate
{
    [self PayFailedEvent];
}

//支付成功
- (void)PaySuccessEvent
{
    [self QuitPayDelegate];
    [[QY_StatusController sharedLoadController] showSuccessWithStatus:@"支付成功"];
    if (self.PayCallBack)
    {
        [[KeyController sharedKeyController] SetMainPayType:self.PayKey];
        NSMutableDictionary *mutDict = [NSMutableDictionary dictionary];
        [mutDict setObject:@(YES) forKey:@"Success"];
        self.PayCallBack(mutDict);
    }
}

//支付失败
- (void)PayFailedEvent
{
    [self QuitPayDelegate];
    [[QY_StatusController sharedLoadController] showErrorWithStatus:@"支付失败"];
    if (self.PayCallBack)
    {
        NSMutableDictionary *mutDict = [NSMutableDictionary dictionary];
        [mutDict setObject:@(NO) forKey:@"Success"];
        self.PayCallBack(mutDict);
    }
}

@end
