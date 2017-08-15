//
//  WebRequest.m
//  XPlanUsers
//
//  Created by Seven-Augus on 16/6/3.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "WebRequest.h"
#import "AFNetworking.h"
//#import <SDWebImageManager.h>

@implementation WebRequest

/**
 *  @pragma 一般数据上传  post方式
 *  url 地址
 *  params 参数
 */
+ (void)webRequestWithURLPostMethod:(NSString *)url params:(id)params success:(void(^)(id result))success fail:(void(^)(NSString * result))fail
{
    //    // 把参数转换成json格式
    //    NSData * data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    //    NSString * jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //    // 将数据放入后台Key值中
    //    NSDictionary * paramDic = @{@"paramJson":jsonStr};
    
    // 该类封装与Web应用程序进行通信通过HTTP，包括要求制作，相应序列化，网络可达性监控和安全性，以及要求经营管理的常见模式
    AFHTTPSessionManager *requestManager = [AFHTTPSessionManager manager];
    requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"application/json", nil];
    NSString *urlStr = [NSString stringWithFormat:@"%@", url];
    
    [requestManager POST:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 请求成功返回数据
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        // 请求失败返回错误描述
        fail([error localizedDescription]);
    }];
}

/**
 *  @pragma 一般数据上传  get方式
 *  url 地址
 *  params 参数
 */
+ (void)webRequestWithURLGetMethod:(NSString *)url params:(id)params success:(void(^)(id result))success fail:(void(^)(NSString * result))fail
{
    // 该类封装与Web应用程序进行通信通过HTTP，包括要求制作，相应序列化，网络可达性监控和安全性，以及要求经营管理的常见模式
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
   NSString *urlStr = [NSString stringWithFormat:@"%@", url];
    NSLog(@"%@", urlStr);
    
    [manager GET:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 请求成功返回数据
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"%@", params);
        // 请求失败返回错误描述
        fail([error localizedDescription]);
    }];
}

+ (void)webRequestWithURLGetMethod:(NSString *)url success:(void(^)(id result)) success fail: (void(^)(NSString *result))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        fail([error localizedDescription]);
    }];
}

/**
 *  @pragma 支付宝支付  get方式
 *  url 地址
 *  params 参数
 */
+ (void)webRequestWithURLGetMethodPay:(NSString *)url params:(id)params success:(void(^)(id result))success fail:(void(^)(NSString * result))fail
{
    // 把参数转换成json格式
    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    // 将数据放入后台Key值中
    NSDictionary *paramDic = @{@"data":jsonStr};
    
    // 该类封装与Web应用程序进行通信通过HTTP，包括要求制作，相应序列化，网络可达性监控和安全性，以及要求经营管理的常见模式
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", ZhiFuBaoPayURL, url];
    [manager GET:urlStr parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 请求成功返回数据
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        // 请求失败返回错误描述
        fail([error localizedDescription]);
    }];
}

/**
 *  @pragma 微信支付  get方式
 *  url 地址
 *  params 参数
 */
+ (void)webRequestWithURLGetMethodWeiXinPay:(NSString *)url params:(id)params success:(void(^)(id result))success fail:(void(^)(NSString * result))fail
{
    // 把参数转换成json格式
    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    // 将数据放入后台Key值中
    NSDictionary *paramDic = @{@"data":jsonStr};
    
    // 该类封装与Web应用程序进行通信通过HTTP，包括要求制作，相应序列化，网络可达性监控和安全性，以及要求经营管理的常见模式
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", WeiXinPayURL, url];
    [manager GET:urlStr parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 请求成功返回数据
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        // 请求失败返回错误描述
        fail([error localizedDescription]);
    }];
}


/**
 *  @pragma 上传图片
 *  url 地址
 *  params 参数
 */
+ (void)webRequestWithUrlMethodImage:(NSString *)url params:(id)params success:(void(^)(id result))success fail:(void(^)(NSString * result))fail
{
    AFHTTPSessionManager *requestManager = [AFHTTPSessionManager manager];
    requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlStr = [NSString stringWithFormat:@"%@", url];
    [requestManager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:params name:@"myfiles" fileName:fileName mimeType:@"image/jpeg"];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 请求成功返回数据
        NSDictionary *paramDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        success(paramDic);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        // 请求失败返回错误描述
        fail([error localizedDescription]);
    }];
}

/**
 *  @pragma 下载
 *  url 地址
 *  params 参数
 */
+ (void)webRequestWithUrlDownLoadImage:(NSString *)url params:(id)params success:(void(^)(id result))success fail:(void(^)(NSString * result))fail
{
    // 覆盖方法，指哪打哪，这个方法是下载的时候响应
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    [manager downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
//        NSLog(@"显示当前进度 == %ld/%ld", receivedSize, expectedSize);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (!error) {
            success(image);
        } else {
            fail([error localizedDescription]);
        }
    }];
}

/**
 *  @pragma 监听网络状态
 */
+ (void)AFNetworkStatus{
    
    // 创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable: // 无网络
                NSLog(@"无网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 蜂窝数据网
                NSLog(@"蜂窝数据网");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WiFi网络
                NSLog(@"WiFi网络");
                break;
            default:
                break;
        }
    }] ;
}

+(void)showAlertFrom:(UIViewController *)controller title:(NSString *)title mesaage:(NSString *)msg doneActionTitle:(NSString *)done
              handle:(void (^)())handle{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:done style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        handle();\
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [controller presentViewController:alert animated:true completion:nil];
    
}

@end
