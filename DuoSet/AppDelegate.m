//
//  AppDelegate.m
//  DuoSet
//
//  Created by Seven-Augus on 2016/11/22.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"
#import "SourceFileHeader.h"
#import <AlipaySDK/AlipaySDK.h>
#import "UMMobClick/MobClick.h"
#import "AFNetworking.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WeiboSDK.h"
#import <CoreLocation/CoreLocation.h>

#import "DuojiHomeViewController.h"
#import "ShoppingCartViewController.h" // 购物车
#import "PiazzaMainController.h"
#import "PiazzaMainController.h"
#import "ClassificationViewController.h" // 分类
#import "ClassificationWebController.h"
#import "UserCenterController.h"
#import "CustomNavController.h"

#import "HcdGuideView.h"

@interface AppDelegate ()<WXApiDelegate,QQApiInterfaceDelegate,WeiboSDKDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, strong) NSString *currentCity;
@property (nonatomic, strong) NSString *currentProvince;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.rootViewController = [self addViewControllers];
    [_window makeKeyAndVisible];
    
    NSMutableArray *images = [NSMutableArray new];
    [images addObject:[UIImage imageNamed:@"guideimg_01"]];
    [images addObject:[UIImage imageNamed:@"guideimg_02"]];
    [images addObject:[UIImage imageNamed:@"guideimg_03"]];
    HcdGuideView *guideView = [HcdGuideView sharedInstance];
    guideView.window = self.window;
    [guideView showGuideViewWithImages:images
                        andButtonTitle:@"开启购物之旅"
                   andButtonTitleColor:[UIColor mainColor]
                      andButtonBGColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5]
                  andButtonBorderColor:[UIColor mainColor]
                  andShowPageControl:false];
    
    // 获取系统版本
        CGFloat deviceFloat = [[[UIDevice currentDevice] systemVersion] floatValue];
    NSString *deviceOs = [NSString stringWithFormat:@"ios %.1f", deviceFloat];
//    NSString *deviceOs = [NSString stringWithFormat:@"ios"];
    [Utils setDeviceOs:deviceOs];
    
    //刷新token
//    [self refershToken];
    //定位
    [self locationhandle];
    //注册微信
    [WXApi registerApp:WeChat_AppID withDescription:@"cn.hlhdj.duoji"];
    //IQKeyboardManager
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = true;
    manager.shouldResignOnTouchOutside = false;
    manager.shouldToolbarUsesTextFieldTintColor = true;
    manager.enableAutoToolbar = true;
    manager.shouldShowTextFieldPlaceholder = false;
    manager.enableAutoToolbar = false;
    
    [MQManager initWithAppkey:@"dad5c044b02b12f2d4a7c2ba3641d9b6" completion:^(NSString *clientId, NSError *error) {
        if (!error) {
            NSLog(@"美洽 SDK：初始化成功");
        } else {
            NSLog(@"error:%@",error);
        }
        [MQServiceToViewInterface getUnreadMessagesWithCompletion:^(NSArray *messages, NSError *error) {
            NSLog(@">> unread message count: %d", (int)messages.count);
        }];
    }];
    
    
    // shareSDK分享
    [ShareSDK registerApp:shareSDKAppKey activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformSubTypeQZone), @(SSDKPlatformSubTypeQQFriend), @(SSDKPlatformSubTypeWechatSession), @(SSDKPlatformSubTypeWechatTimeline)] onImport:^(SSDKPlatformType platformType) {
        switch (platformType) {
            case SSDKPlatformTypeSinaWeibo:
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                break;
                
            case SSDKPlatformTypeQQ:
                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                break;
                
            case SSDKPlatformTypeWechat:
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
                
            default:
                break;
        }
        
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch (platformType) {
            case SSDKPlatformTypeSinaWeibo:
                [appInfo SSDKSetupSinaWeiboByAppKey:SinaWeibo_AppID appSecret:SinaWeibo_AppSecret redirectUri:kAppRedirectURI authType:SSDKAuthTypeBoth];
                break;
                
            case SSDKPlatformTypeQQ:
                [appInfo SSDKSetupQQByAppId:QQ_AppID appKey:QQ_AppSecret authType:SSDKAuthTypeBoth];
                break;
                
            case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:WeChat_AppID appSecret:WeChat_AppSecret];
                break;
            default:
                break;
        }
    }];
    
    //Umeng
    UMConfigInstance.appKey = UMAppKay;
    [MobClick startWithConfigure:UMConfigInstance];
    
    //网络监听
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager ] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case -1:
                NSLog(@"未知网络");
                break;
            case 0:
                NSLog(@"网络不可达");
                [[UIApplication sharedApplication].keyWindow makeToast:@"网络连接失败，请检查网络连接设置"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"netWorkFailNotify" object:nil];
                break;
            case 1:
                NSLog(@"GPRS网络");
//                [[UIApplication sharedApplication].keyWindow makeToast:@"2g/3g/4g网络已连接"];
                break;
            case 2:
                NSLog(@"wifi网络");
//                [[UIApplication sharedApplication].keyWindow makeToast:@"wifi网络已连接"];
                break;
            default:
                break;
        }
        if(status ==AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi)
        {
            NSLog(@"有网");
        }else
        {
            [[UIApplication sharedApplication].keyWindow makeToast:@"网络连接失败，请检查网络连接设置"];
        }
    }];
    return YES;
}

-(void)locationhandle{
    //获取定位城市
    self.currentCity = [[NSString alloc] init];
    // 判断是否开启定位
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startUpdatingLocation];
    } else {
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0)
        {
            CLPlacemark *placemark = [array objectAtIndex:0];
            NSLog(@"%@",placemark.name);
            NSString *city = placemark.locality;
            if (!city) {
                city = placemark.administrativeArea;
            }
            NSString *province = placemark.administrativeArea;
            if ([province hasSuffix:@"省"]) {
                _currentProvince =  [province stringByReplacingOccurrencesOfString:@"省" withString:@""];
            }
            CLLocation *location = locations[0];
            CLLocationCoordinate2D baidu = [Utils BD09FromGCJ02:location.coordinate];
            _currentCity = city;
            UserInfo *info = [Utils getUserInfo];
            info.latitude = [NSString stringWithFormat:@"%f", baidu.latitude];
            info.longitude = [NSString stringWithFormat:@"%f", baidu.longitude];
            if ([_currentCity hasSuffix:@"市"]) {
                _currentCity =  [_currentCity stringByReplacingOccurrencesOfString:@"市" withString:@""];
            }
            info.currentCity = _currentCity;
            info.currentProvince = _currentProvince;
            [Utils setUserInfo:info];
            if (_currentCity.length > 0) {
                [_locationManager stopUpdatingLocation];
            }
        }
        else if (error == nil && [array count] == 0) {
            NSLog(@"No results were returned.");
        }else if (error != nil){
            NSLog(@"An error occurred = %@", error);
        }
    }];
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    UserInfo *info = [Utils getUserInfo];
    info.latitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
    info.longitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
    [Utils setUserInfo:info];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (error.code == kCLErrorDenied) {
        NSLog(@"无法获取位置信息");;
    }
}

//微博回调
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    if ([response isKindOfClass:WBAuthorizeResponse.class]){
        NSString *userId = [(WBAuthorizeResponse *)response userID];
        NSString *accessToken = [(WBAuthorizeResponse *)response accessToken];
        NSLog(@"userId %@",userId);
        NSLog(@"accessToken %@",accessToken);
        if (userId != nil && accessToken != nil) {
            NSDictionary *notification = @{
                                           @"userId" : userId,
                                           @"accessToken" : accessToken
                                           };
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"weiboDidLoginNotification"
                                                                object:self userInfo:notification];
        }
    }
}

-(UITabBarController *)addViewControllers{
    UITabBarController *tb = [[UITabBarController alloc]init];
    DuojiHomeViewController *homeVC = [[DuojiHomeViewController alloc] init]; // 首页
    CustomNavController *homeNavc = [[CustomNavController alloc] initWithRootViewController:homeVC];
    UITabBarItem *homeItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[[UIImage imageNamed:@"home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"home_seletced"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [homeItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor mainColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [homeItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor colorFromHex:0x222222], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    homeVC.tabBarItem = homeItem;
    
//    ClassificationViewController *classificationVC = [[ClassificationViewController alloc] init]; // 分类
    ClassificationWebController *classificationVC = [[ClassificationWebController alloc] init]; // 分类
    CustomNavController *classificationNavc = [[CustomNavController alloc] initWithRootViewController:classificationVC];
    UITabBarItem *classificationItem = [[UITabBarItem alloc]initWithTitle:@"分类" image:[[UIImage imageNamed:@"class_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"class_seletced"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [classificationItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor mainColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [classificationItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor colorFromHex:0x222222], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    classificationVC.tabBarItem = classificationItem;
    
    PiazzaMainController *piazzaVC = [[PiazzaMainController alloc] init]; // 社区
    CustomNavController *piazzaNavc = [[CustomNavController alloc] initWithRootViewController:piazzaVC];
    UITabBarItem *piazzaItem = [[UITabBarItem alloc]initWithTitle:@"社区" image:[[UIImage imageNamed:@"piazza_mormal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"piazza_seletced"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [piazzaItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor mainColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [piazzaItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor colorFromHex:0x222222], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    piazzaVC.tabBarItem = piazzaItem;
    
    ShoppingCartViewController *shoppingCartVC = [[ShoppingCartViewController alloc] init]; // 购物车
    CustomNavController *shoppingCartNavc = [[CustomNavController alloc] initWithRootViewController:shoppingCartVC];
    UITabBarItem *shoppingCartItem = [[UITabBarItem alloc]initWithTitle:@"购物车" image:[[UIImage imageNamed:@"cart_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"cart_seletced"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [shoppingCartItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor mainColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [shoppingCartItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor colorFromHex:0x222222], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    shoppingCartVC.tabBarItem = shoppingCartItem;
    
    UserCenterController *userCenterVC = [[UserCenterController alloc] init]; // 个人中心
    CustomNavController *userCenterNavc = [[CustomNavController alloc] initWithRootViewController:userCenterVC];
    UITabBarItem *userCenterItem = [[UITabBarItem alloc]initWithTitle:@"个人中心" image:[[UIImage imageNamed:@"me_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"me_seletced"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [userCenterItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor mainColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [userCenterItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor colorFromHex:0x222222], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    userCenterVC.tabBarItem = userCenterItem;
    
    tb.viewControllers = @[homeNavc,classificationNavc,piazzaNavc,shoppingCartNavc,userCenterNavc];
    tb.tabBar.translucent = NO;
    
    return tb;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [MQManager closeMeiqiaService];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [MQManager openMeiqiaService];
//    [self refershToken];
    NSLog(@"applicationWillEnterForeground");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ApplicationWillEnterForegroundNotify" object:nil];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    NSLog(@"application-openURL-sourceApplication:%@",url.absoluteString);
    if ([url.absoluteString hasPrefix:@"wb2264393756://"]) {
        return [WeiboSDK handleOpenURL:url delegate:self];
    }
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSLog(@"result = %@",resultDic);
            if ([resultDic objectForKey:@"resultStatus"]) {
                NSString *str = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
                if (str.integerValue == 9000) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"AliPayResult" object:nil];
                }
            }
        }];
    }
    
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSLog(@"result = %@",resultDic);
            if ([resultDic objectForKey:@"resultStatus"]) {
                NSString *str = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
                if (str.integerValue == 9000) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"AliPayResult" object:nil];
                }
            }
        }];
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@",url];
    
    if ([urlStr hasPrefix:WeChat_AppID]) {
        return  [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options{
    
    NSLog(@"application-openURL:%@",url.absoluteString);
    if ([url.absoluteString hasPrefix:@"tencent1106130858://"]) {
        [QQApiInterface handleOpenURL:url delegate:self];
        return [TencentOAuth HandleOpenURL:url];
    }
    if ([url.absoluteString hasPrefix:@"wb2264393756://"]) {
        return [WeiboSDK handleOpenURL:url delegate:self];
    }
    
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSLog(@"result = %@",resultDic);
            if ([resultDic objectForKey:@"resultStatus"]) {
                NSString *str = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
                if (str.integerValue == 9000) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"AliPayResult" object:nil];
                }
            }
        }];
    }
    
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSLog(@"result = %@",resultDic);
            if ([resultDic objectForKey:@"resultStatus"]) {
                NSString *str = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
                if (str.integerValue == 9000) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"AliPayResult" object:nil];
                }
            }
        }];
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@",url];
    if ([urlStr hasPrefix:WeChat_AppID]) {
        return  [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //上传设备deviceToken，以便美洽自建推送后，迁移推送
    [MQManager registerDeviceToken:deviceToken];
}

-(void)onResp:(BaseResp *)resp{
    if ([resp isKindOfClass:[SendAuthResp class]]) {   //授权登录的类。
        if (resp.errCode == 0) {
            SendAuthResp *authResp = (SendAuthResp *)resp;
            NSDictionary *dic = @{@"code":authResp.code};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"WechatLoginHandle" object:nil userInfo:dic];
        }
    }else{//支付返回结果，实际支付结果需要去微信服务器端查询
        if (resp.errCode == 0) {//支付成功
            [[NSNotificationCenter defaultCenter]postNotificationName:@"AliPayResult" object:nil];//通知名字，均为支付成功名称
        }
    }
}

-(void)refershToken{
    //刷新token
    if ([Utils getUserInfo].token.length > 0) {
        UserInfo *info = [Utils getUserInfo];
        NSDate *now = [NSDate date];
        NSInteger tmp = [now timeIntervalSinceDate:info.refreshTokenDate];
        if (tmp < (info.expiresIn.integerValue)/1000) {//还没过期了
            return;
        }
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:info.refreshToken forKey:@"refreshToken"];
        [RequestManager requestWithMethod:POST WithUrlPath:@"user/refreshToken" params:params from:nil showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dic = [responseDic objectForKey:@"object"];
                    if ([dic objectForKey:@"refreshToken"]) {
                        info.refreshToken = [NSString stringWithFormat:@"%@",[dic objectForKey:@"refreshToken"]];
                    }
                    if ([dic objectForKey:@"token"]) {
                        info.token = [NSString stringWithFormat:@"%@",[dic objectForKey:@"token"]];
                    }
                    if ([dic objectForKey:@"expiresIn"]) {
                        info.expiresIn = [NSString stringWithFormat:@"%@",[dic objectForKey:@"expiresIn"]];
                    }
                    info.refreshTokenDate = [NSDate date];
                    [Utils setUserInfo:info];
                }
            }
        } fail:^(NSError *error) {
            //
        }];
    }
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    NSLog(@"内存警告了⚠️⚠️⚠️⚠️⚠️⚠️⚠️");
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    [mgr cancelAll];
    [mgr.imageCache clearMemory];
    [[SDWebImageManager sharedManager].imageCache cleanDisk];
}

@end
