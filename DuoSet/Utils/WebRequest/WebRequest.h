//
//  WebRequest.h
//  XPlanUsers
//
//  Created by Seven-Augus on 16/6/3.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebRequest : NSObject

/**
 *  @pragma 一般数据上传
 *  url 地址
 *  params 参数
 */
+ (void)webRequestWithURLPostMethod:(NSString *)url params:(id)params success:(void(^)(id result))success fail:(void(^)(NSString * result))fail;

/**
 *  @pragma 一般数据上传
 *  url 地址
 *  params 参数
 */
+ (void)webRequestWithURLGetMethod:(NSString *)url params:(id)params success:(void(^)(id result))success fail:(void(^)(NSString * result))fail;

+ (void)webRequestWithURLGetMethod:(NSString *)url success:(void(^)(id result)) success fail: (void(^)(NSString *result))fail;

/**
 *  @pragma 支付宝支付  get方式
 *  url 地址
 *  params 参数
 */
+ (void)webRequestWithURLGetMethodPay:(NSString *)url params:(id)params success:(void(^)(id result))success fail:(void(^)(NSString * result))fail;

/**
 *  @pragma 微信支付  get方式
 *  url 地址
 *  params 参数
 */
+ (void)webRequestWithURLGetMethodWeiXinPay:(NSString *)url params:(id)params success:(void(^)(id result))success fail:(void(^)(NSString * result))fail;


/**
 *  @pragma 上传图片
 *  url 地址
 *  params 参数
 */
+ (void)webRequestWithUrlMethodImage:(NSString *)url params:(id)params success:(void(^)(id result))success fail:(void(^)(NSString * result))fail;

/**
 *  @pragma 下载
 *  url 地址
 *  params 参数
 */
+ (void)webRequestWithUrlDownLoadImage:(NSString *)url params:(id)params success:(void(^)(id result))success fail:(void(^)(NSString * result))fail;

/**
 *  @pragma 监听网络状态
 */
+ (void)AFNetworkStatus;

+(void)showAlertFrom:(UIViewController *)controller title:(NSString *)title mesaage:(NSString *)msg doneActionTitle:(NSString *)done
              handle:(void (^)())handle;

@end
