//
//  RequestManager.m
//  DuoSet
//
//  Created by fanfans on 2017/2/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "RequestManager.h"
#import "AFNetworking.h"
#import "AFURLRequestSerialization.h"
#import "SVProgressHUD.h"
#import "FFLoaddingView.h"
#import "MQToast.h"

@implementation RequestManager

static AFURLSessionManager *urlsession ;

+ (AFURLSessionManager *)sharedURLSession{
    static dispatch_once_t onceToken2;
    dispatch_once(&onceToken2, ^{
        urlsession = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return urlsession;
}

+ (void)requestWithMethod:(NetRequestWay)way  WithUrlPath:(NSString *)urlPath params:(NSDictionary *)params from:(UIViewController *)controller showHud:(BOOL)showHud loadingText:(NSString *)loadingText enableUserActions:(BOOL)enableUserActions success:(void (^)(id responseDic))success fail:(void (^)(NSError *err))fail{
    
    [self showHud:showHud showString:loadingText enableUserActions:enableUserActions withViewController:controller];
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@", BaseUrl, urlPath];
    AFURLSessionManager *manager = [self sharedURLSession];
    NSString *methodStr = @"";
    switch (way) {
        case POST:
            methodStr = @"POST";
            break;
        case GET:
            methodStr = @"GET";
            break;
        case DELETE:
            methodStr = @"DELETE";
            break;
            
        default:
            methodStr = @"POST";
            break;
    }
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:methodStr URLString:requestUrl parameters:nil error:nil];
    request.timeoutInterval= 60;
    UserInfo *info = [Utils getUserInfo];
    if (info.token.length > 0) {
        [request setValue:info.token forHTTPHeaderField:@"token"];
    }
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[Utils getUUID] forHTTPHeaderField:@"deviceId"];
    [request setValue:[Utils getDeviceOs] forHTTPHeaderField:@"deviceType"];
    [request setValue:[Utils getIphoneType] forHTTPHeaderField:@"deviceName"];
    NSLog(@"requestUrl:%@",requestUrl);
    if (info.token.length > 0) {
        NSLog(@"token:%@",info.token);
    }
    NSLog(@"Content-Type:application/json");
    NSLog(@"deviceId:%@",[Utils getUUID]);
    NSLog(@"deviceType:%@",[Utils getDeviceOs]);
    NSLog(@"deviceName:%@",[Utils getIphoneType]);
    if (params != nil) {
        NSData *data =   [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
        [request setHTTPBody:data];
    }
    NSLog(@"params:%@",params);
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                 @"text/html",
                                                 @"text/json",
                                                 @"text/javascript",
                                                 @"text/plain",
                                                 nil];
    manager.responseSerializer = responseSerializer;

    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nonnull responseObject, NSError * _Nonnull error) {
        if (!error) {
            NSDictionary* json = [NSJSONSerialization
                                  JSONObjectWithData:responseObject
                                  options:kNilOptions
                                  error:&error];
            NSLog(@"responseDic:%@",json);
            NSString *resultCode = [NSString stringWithFormat:@"%@",[json objectForKey:@"result"]];
            if (![resultCode isEqualToString:@"ok"]) {
                if ([json objectForKey:@"errorCode"]) {
                    NSString *errorCode = [NSString stringWithFormat:@"%@",[json objectForKey:@"errorCode"]];
                    if (errorCode.integerValue == 1001) {
                        [Utils setUserInfo:[[UserInfo alloc]init]];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"LogoutSuccess" object:nil];
                        [MQToast showToast:@"登录已失效，请重新登录" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
                        return ;
                    }
                }else{
                    if ([json objectForKey:@"errorMsg"]) {
                        NSString *errorMeg = [NSString stringWithFormat:@"%@",[json objectForKey:@"errorMsg"]];
                        [MQToast showToast:errorMeg duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
                    }
                }
            }
            success(json);
            [self showHud:false showString:loadingText enableUserActions:enableUserActions withViewController:controller];
        }else{
            [self showHud:false showString:loadingText enableUserActions:enableUserActions withViewController:controller];
            NSLog(@"error:%@",error.description);
            if (error.code == -1011) {
                NSLog(@"404错误");
            }
            if (error.code == -1001) {
                NSLog(@"请求超时");
            }
            if (error.code == -1009) {
                NSLog(@"断开连接");
            }
            fail(error);
        }
    }] resume];
}

+(void)showHud:(BOOL)show showString:(NSString *)text enableUserActions:(BOOL)enableUserActions withViewController:(UIViewController *)controller{
    if (text.length == 0) {
        if (show) {
            if (enableUserActions) {
                [[UIApplication sharedApplication].keyWindow addSubview:[FFLoaddingView shareLoaddingView]];
                [FFLoaddingView shareLoaddingView].center = [UIApplication sharedApplication].keyWindow.center;
                [[FFLoaddingView shareLoaddingView] startAnimationLoadding];
            }else{
//                [controller.view addSubview:[FFLoaddingView shareLoaddingView]];
//                [FFLoaddingView shareLoaddingView].center = controller.view.center;
//                [[FFLoaddingView shareLoaddingView] startAnimationLoadding];
                [[UIApplication sharedApplication].keyWindow addSubview:[FFLoaddingView shareLoaddingView]];
                [FFLoaddingView shareLoaddingView].center = [UIApplication sharedApplication].keyWindow.center;
                [[FFLoaddingView shareLoaddingView] startAnimationLoadding];
            }
        }else{
            [[FFLoaddingView shareLoaddingView] endAnimationLoadding];
            [[FFLoaddingView shareLoaddingView] removeFromSuperview];
        }
    }else{
        if (show) {
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
            [SVProgressHUD setBackgroundColor:[UIColor colorFromHex:0x000000 alpha:1]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
            [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
            [SVProgressHUD showWithStatus:text];
        }else{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            });
        }
    }
}

+(void)showAlertFrom:(UIViewController *)controller title:(NSString *)title mesaage:(NSString *)msg success:(void (^)())success{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        success();
    }]];
    [controller presentViewController:alert animated:true completion:nil];
}

+(void)showAlertFrom:(UIViewController *)controller title:(NSString *)title mesaage:(NSString *)msg doneActionTitle:(NSString *)done handle:(void (^)())handle{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:done style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        handle();
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [controller presentViewController:alert animated:true completion:nil];
    
}

+(void)refershTokenSuccess:(void (^)())successHandle{
    //刷新token
    if ([Utils getUserInfo].token.length > 0) {
        UserInfo *info = [Utils getUserInfo];
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
                    [Utils setUserInfo:info];
                }
                successHandle();
            }
            if (![resultCode isEqualToString:@"ok"]) {
                [Utils setUserInfo:[[UserInfo alloc]init]];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LogoutSuccess" object:nil];
            }
        } fail:^(NSError *error) {
            //
        }];
    }
}


@end
