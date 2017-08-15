//
//  AlixPayResult.h
//  MSPInterface
//
//  Created by WenBi on 11-5-20.
//  Copyright 2011 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AlixPayResult : NSObject {
    int		  _statusCode; /**< 状态码*/
    /**
     * 9000 订单支付成功
     * 8000 正在处理中
     * 4000 订单支付失败
     * 6001 用户中途取消
     * 6002 网络连接出错
     */
	NSString *_statusMessage; /**< 提示信息*/
    /*比如状态码为6001时，_statusMessage就是“用户中途取消”。但千万别完全依赖这个信息，如果未安装支付宝app，采用wap支付时，取消时状态码是6001，但这个memo是空的*/
	NSString *_resultString; /**< 订单信息以及验证签名信息*/
    /*如果你不想做签名验证，那这个字段可以忽略了*/
	NSString *_signString;
	NSString *_signType;
}

@property(nonatomic, readonly) int statusCode;
@property(nonatomic, readonly) NSString *statusMessage;
@property(nonatomic, readonly) NSString *resultString;
@property(nonatomic, readonly) NSString *signString;
@property(nonatomic, readonly) NSString *signType;

- (id)initWithString:(NSString *)string;
@end
