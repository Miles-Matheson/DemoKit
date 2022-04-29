//
//  BaseWebService.m
//  Unity-iPhone
//
//  Created by qianyu on 2019/6/16.
//

#import "QY_WebProxyBase.h"
#import "KeyController.h"
#import "QY_CommonController.h"

@interface QY_WebProxyBase()<NSURLSessionDelegate,NSURLSessionTaskDelegate>

@property (nonatomic, strong)NSMutableURLRequest *request;
@property (nonatomic, copy) NSString *ServerHost;
@property (nonatomic, copy) NSString *ServerIndex;
@property (nonatomic, copy) NSString *ServerSign;
@property (nonatomic, copy) NSString *ServerSymbol;

@end

@implementation QY_WebProxyBase


- (void) requestWithURL:(NSString *)url
                 params:(NSDictionary *)params
                success:(void (^)(id _Nonnull))success
                failure:(void (^)(NSError * _Nonnull))failure
{
    //NSBundle *bundle = [[ComController sharedComController] GetCurrentBundle];
    //NSString *paths = [[NSBundle mainBundle] pathForResource:@"HFConfig" ofType:@"plist"];
    //NSDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:paths];
    //self.ServerHost = dict[@"serverHost"];
    //self.ServerIndex = dict[@"serverIndex"];
    //self.ServerSign = dict[@"serverSign"];
    //self.ServerSymbol = dict[@"serverSymbol"];
    self.ServerHost = [[KeyController sharedKeyController] GetServerHost];
    self.ServerIndex = [[KeyController sharedKeyController] GetServerIndex];
    self.ServerSign = [[KeyController sharedKeyController] GetServerSign];
    self.ServerSymbol = [[KeyController sharedKeyController] GetServerSymbol];
    __weak typeof(self) weakSelf = self;
    
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        BOOL noLoad = [params[@"noLoad"] boolValue];
        if (!noLoad)
        {
            [[QY_CommonController sharedComController] showWithStatus:@""];
        }
        NSMutableDictionary *mutParam = [NSMutableDictionary dictionaryWithDictionary:params];
        [mutParam removeObjectForKey:@"noLoad"];
        
        // 拼接URL
        NSString *serverHost = [NSString stringWithFormat:@"%@%@",weakSelf.ServerHost,weakSelf.ServerIndex];
        //NSLog(@"serverHost ============ %@",serverHost);
        NSString *msgURL = [[KeyController sharedKeyController] HandleServerURL:serverHost withURL:url withParams:mutParam];
        //NSLog(@"msgURL11 ============ %@",msgURL);
        //url不能包含ASSIC码
        //msgURL = [msgURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        //NSLog(@"msgURL22 ============ %@",msgURL);
        NSURL *serverURL = [NSURL URLWithString:msgURL];
        
        
        //NSLog(@"serverURL ============ %@",serverURL);
        //Head
        NSString *symbol = weakSelf.ServerSymbol;
        NSString *clientKey = [[KeyController sharedKeyController] GetClientKey];
        NSMutableDictionary *keys = [[KeyController sharedKeyController] GetKeyDictionary];
        NSString *headURL = [NSString stringWithFormat:@"%@%@",weakSelf.ServerIndex,url];
        NSString *serverHead = [[KeyController sharedKeyController] HandleServerHead:headURL withKeys:keys withParams:mutParam withSymbol:symbol withClientKey:clientKey];
        [keys setValue:serverHead forKey:weakSelf.ServerSign];
        //NSLog(@"serverHead ============ %@",serverHead);
        
        weakSelf.request = [[NSMutableURLRequest alloc] initWithURL:serverURL
                                                        cachePolicy:0
                                                    timeoutInterval:30];
        
        for (NSString *key in [keys allKeys]) {
            [weakSelf.request setValue:[keys objectForKey:key] forHTTPHeaderField:key];
        }
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
        
        //NSLog(@" ===== Start ===== ");
        [[session dataTaskWithRequest:weakSelf.request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            [[QY_CommonController sharedComController] dismiss];
            NSLog(@" ===== Start ===== ");
            if (error)
            {
                failure(error);
                //NSLog(@"BaseWebService Failes ======= %@",error);
            }
            else
            {
                NSString *rstStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSData *rstData = [rstStr dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *rstDict = [NSJSONSerialization JSONObjectWithData:rstData options:NSJSONReadingAllowFragments error:nil];
                success(rstDict);
                NSLog(@"BaseWebService Success ======= %@",rstStr);
            }
            
        }] resume];
    });
}

/**
 *  @验证 证书
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    
    //获取原始域名信息
    NSString *host =  [[self.request allHTTPHeaderFields] objectForKey:@"host"];
    if (!host) {
        host = self.request.URL.host;
    }
    
    if ([[[challenge protectionSpace] authenticationMethod] isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        do
        {
            SecTrustRef serverTrust = [[challenge protectionSpace] serverTrust];
            BOOL InDev = [[KeyController sharedKeyController] GetInDevelopment];
            if (InDev)
            {
                completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:serverTrust]);
                return;
            }
            
            NSMutableArray *policies = [NSMutableArray array];
            if (host) {
                [policies addObject:(__bridge_transfer id) SecPolicyCreateSSL(true, (__bridge CFStringRef) host)];
            } else {
                [policies addObject:(__bridge_transfer id) SecPolicyCreateBasicX509()];
            }
            /*
             * 绑定校验策略到服务端的证书上
             */
            SecTrustSetPolicies(serverTrust, (__bridge CFArrayRef) policies);
            NSCAssert(serverTrust != nil, @"serverTrust is nil");
            
            if(nil == serverTrust)
                break; /* failed */
            /**
             *  导入多张CA证书（Certification Authority，支持SSL证书以及自签名的CA），请替换掉你的证书名称
             */
            NSBundle *bundle = [[QY_CommonController sharedComController] GetCurrentBundle];
            NSString *cerPath2 = [bundle pathForResource:@"qianyugame" ofType:@"cer"];//SSL证书
            NSData * caCert2 = [NSData dataWithContentsOfFile:cerPath2];
            
            //NSCAssert(caCert != nil, @"caCert is nil");
            //if(nil == caCert)
            //break; /* failed */
            
            //NSLog(@"bundle ==== %@",bundle);
            //NSLog(@"cerPath2 ==== %@",cerPath2);
            //NSLog(@"caCert2 ==== %@",caCert2);
            NSCAssert(caCert2 != nil, @"caCert2 is nil");
            if (nil == caCert2) {
                break;
            }
            
            SecCertificateRef caRef2 = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)caCert2);
            NSCAssert(caRef2 != nil, @"caRef2 is nil");
            if(nil == caRef2)
                break; /* failed */
            
            NSArray *caArray = @[(__bridge id)(caRef2)];
            
            NSCAssert(caArray != nil, @"caArray is nil");
            if(nil == caArray)
                break; /* failed */
            
            OSStatus status = SecTrustSetAnchorCertificates(serverTrust, (__bridge CFArrayRef)caArray);
            NSCAssert(errSecSuccess == status, @"SecTrustSetAnchorCertificates failed");
            if(!(errSecSuccess == status))
                break; /* failed */
            
            SecTrustResultType result = -1;
            status = SecTrustEvaluate(serverTrust, &result);
            if(!(errSecSuccess == status))
                break; /* failed */
            //NSLog(@"stutas: %d", (int)status);
            //NSLog(@"Result: %d", result);
            
            BOOL allowConnect = (result == kSecTrustResultUnspecified) || (result == kSecTrustResultProceed);
            if (allowConnect) {
                //NSLog(@"success");
            }else {
                //NSLog(@"error");
            }
            
            if(! allowConnect)
            {
                break; /* failed */
            }
            
            /* Treat kSecTrustResultConfirm and kSecTrustResultRecoverableTrustFailure as success */
            /*   since the user will likely tap-through to see the dancing bunnies */
            if(result == kSecTrustResultDeny || result == kSecTrustResultFatalTrustFailure || result == kSecTrustResultOtherError)
                break; /* failed to trust cert (good in this case) */
            
            // The only good exit point
            //NSLog(@"信任该证书");
            completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:serverTrust]);
            
        }while(0);
    }
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    //NSLog(@"接收到服务器响应");
    completionHandler(NSURLSessionResponseAllow);
}

@end
