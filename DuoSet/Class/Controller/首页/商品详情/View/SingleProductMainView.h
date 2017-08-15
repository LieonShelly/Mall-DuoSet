//
//  SingleProductMainView.h
//  DuoSet
//
//  Created by fanfans on 2017/5/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//  商品详情mainView

#import <UIKit/UIKit.h>
#import "ProductDetailsData.h"
#import "AddressModel.h"
#import "CommentData.h"

typedef void(^HeaderViewCoverTapHandle)(NSInteger index);
typedef void(^SingleProductMainViewCellSeletcedBlock)(NSIndexPath *indexPath);
typedef void(^ImageViewTapBlock)(CommentData *item,NSInteger index);
typedef void(^SeckillCutdownEndBLock)();
typedef void(^SingleProductMainViewTexBtnActionBlock)();
typedef void(^WebViewPhoneCallBlock)(NSString *str);


@interface SingleProductMainView : UIView

-(instancetype)initWithFrame:(CGRect)frame andProductNum:(NSString *)productNum;
//配置商品详情
-(void)setupInfoWithProductDetailsData:(ProductDetailsData *)productItem;
//配置优惠券
-(void)setupInfoWithCouponCodeResponses:(NSMutableArray *)couponCodeResponses;
//配置收货地址
-(void)setupInfoWithAddressModel:(AddressModel *)addressItem;
-(void)setupInfoWithAddressStr:(NSString *)addressStr;
//配置选中的属性名称和个数
-(void)setupPropertiesName:(NSString *)propertiesName andSeletcedCount:(NSString *)count;
//配置评价数据
-(void)setupInfoWithCommentArr:(NSMutableArray *)commentArr;
//配置默认的第一张图
-(void)setupInfoWithFirstLangchCover:(NSString *)cover productTitle:(NSString *)productTitle productPrice:(NSString *)productPrice;

-(void)removeTimer;

@property(nonatomic,copy) HeaderViewCoverTapHandle coverTapHandle;
@property(nonatomic,copy) SingleProductMainViewCellSeletcedBlock cellHandle;
@property(nonatomic,copy) ImageViewTapBlock imgVTapHandle;
@property(nonatomic,copy) SeckillCutdownEndBLock cutdownEndHandle;
@property(nonatomic,copy) SingleProductMainViewTexBtnActionBlock texHandle;
@property(nonatomic,copy) WebViewPhoneCallBlock webCallHandle;

@end
