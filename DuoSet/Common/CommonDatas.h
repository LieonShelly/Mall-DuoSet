//
//  CommonDatas.h
//  DuoSet
//
//  Created by fanfans on 12/28/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#ifndef CommonDatas_h
#define CommonDatas_h


typedef enum : NSUInteger {
    /** 今日新品*/
    AppNavIconTodayNewItem,
    /** 设计馆*/
    AppNavIconDesigning,
    /** 全球购*/
    AppNavIconGlobalBuy,
    /** 客服中心*/
    AppNavIconService,
    /** 分类*/
    AppNavIconClassification
}AppNavIconStatus;


typedef enum : NSUInteger {
    ProductDetailsWithDefault,//正常状态
    ProductDetailsWithSoldOut//下架状态
} ProductDetailsStatus;


typedef enum : NSUInteger {
    BillChoiceStatusWithNoNeed,//不要发票
    BillChoiceStatusWithPaperCompany,//单位纸值发票
    BillChoiceStatusWithPaperPersion,//个人纸值发票
    BillChoiceStatusWithElectronicCompany,//单位电子发票
    BillChoiceStatusWithElectronicPersion,//个人电子发票
    BillChoiceStatusWithQualification//增值税发票
} BillChoiceStyle;

typedef enum : NSUInteger {
    SecKillWillBegin,
    SecKillBedoing,
    SecKillisEnd,
    SeckillisOver
} SecKillStatus;


typedef enum : NSUInteger {
    ThirdpartyLoginWithQQ,
    ThirdpartyLoginWithWechat,
    ThirdpartyLoginWithSina,
    ThirdpartyLoginWithOther
} ThirdpartyLoginType;

typedef enum : NSUInteger {
    BannerProduct,
    BannerWeb,
    BannerSubObject,//专题
    BannerClsaaify,//分类
    BannerOrther
} HomePageTopBannerStyle;


typedef enum : NSUInteger {
    ProductDetailDefault,
    ProductDetailSeckill,
} ProductDetailStyle;

typedef enum : NSUInteger {
    PayWayForWeChat,
    PayWayForAlipay,
    PayWayForDuoSet,
    PayWayForOther,
}DuoSetPayWay;

typedef enum : NSUInteger {
    OrderStatesDeleted,//订单删除
    OrderStatesCancel,//订单取消
    OrderStatesCreate,//创建(待支付)
    OrderStatesPaid,//支付完成(待发货,正在出库)
    OrderStatesBeforSendCancel,//发货之前 申请退款
    OrderStatesSend,//已发货(待收货)
    OrderStatesWaitComment,//订单待评价
    OrderStatesDone,//已完成
    
    //新版本，后面的状态值 废弃了
    OrderStatesRecive,//已收货(待评价)
    OrderStatesDiscussed,//已评价（完成）
    OrderStatesReturn,//退货
    OrderStatesExchange,//换货
    OrderStatesOther,//其他
    OrderStatesWaitOrrecive
}OrderStates;

typedef enum : NSUInteger {
    OrderProductStatesdefault,//商品无纠纷
    OrderProductStatesExchangeCheking,//换货(审核中)
    OrderProductStatesReturnCheking,//退货(审核中)
    OrderProductStatesExchangeHandling,//换货(处理中)
    OrderProductStatesReturnHandling,//退货(处理中)
    OrderProductStatesExchangeRefuse,//换货驳回
    OrderProductStatesReturnRefuse,//退货驳回
    OrderProductStatesExchangeFinish,//换货完成
    OrderProductStatesReturnFinish,//退货完成
    OrderProductStatesOther
}OrderProductStates;

typedef enum : NSUInteger {
    OrderProductCommentNoComment,//商品未评论
    OrderProductCommentCommented//商品已评论
}OrderProductCommentStates;


typedef enum : NSUInteger {
    GET,
    POST,
    DELETE
}NetRequestWay;


typedef enum : NSUInteger{
    MessageTypeSystem,
    MessageTypeOrder,
    MessageTypeVipDyn,
    MessageTypePrivilege,
    MessageTypeFriend,
    MessageTypeLogistics,
    MessageTypeAsset
}MessageType;

typedef enum : NSUInteger {
    ShopCarProductSellStatusNormal,
    ShopCarProductSellStatusSellEnd
} ShopCarProductSellStatus;

typedef enum : NSUInteger {
    OrderSuerStatusByCart,
    OrderSuerStatusBySingleItem
} OrderSuerStatus;

#endif /* CommonDatas_h */
