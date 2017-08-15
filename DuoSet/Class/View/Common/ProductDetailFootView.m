//
//  ProductDetailFootView.m
//  DuoSet
//
//  Created by mac on 2017/1/19.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ProductDetailFootView.h"

@interface ProductDetailFootView()

@property(nonatomic,strong) ProductDetailsData *item;
@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIButton *chatWithServer;
@property(nonatomic,strong) UIButton *shopCartBtn;
@property(nonatomic,strong) UIButton *addToShopCart;
@property(nonatomic,strong) UIButton *buyNowBtn;
@property(nonatomic,strong) UIButton *noRepertoryBtn;
@property(nonatomic,strong) UILabel *shopcartCountLable;

@end

@implementation ProductDetailFootView

-(instancetype)initWithFrame:(CGRect)frame andProductDetailsData:(ProductDetailsData *)item{
    self = [super initWithFrame:frame];
    if (self) {
        _item = item;
        self.backgroundColor = [UIColor whiteColor];
        if (item.status == ProductDetailsWithSoldOut) {//下架状态
            UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, frame.size.height)];
            imgV.image = [UIImage imageNamed:@"loginBtn_highlighted"];
            [self addSubview:imgV];
            
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, frame.size.height)];
            lable.textColor = [UIColor whiteColor];
            lable.text = @"该商品已下架";
            lable.textAlignment = NSTextAlignmentCenter;
            lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
            [self addSubview:lable];
            return self;
        }
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 0.5)];
        line.backgroundColor = [UIColor colorFromHex:0xe8e8e8];
        [self addSubview:line];
        
        _chatWithServer = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, (mainScreenWidth * 0.5) / 3, frame.size.height)];
        _chatWithServer.titleLabel.font = CUSFONT(9);
        [_chatWithServer setImageEdgeInsets:UIEdgeInsetsMake(-10, 0, 0, -50)];
        [_chatWithServer setTitleEdgeInsets:UIEdgeInsetsMake(0, -5, -25, 0)];
        [_chatWithServer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_chatWithServer setTitle:@"联系客服" forState:UIControlStateNormal];
        [_chatWithServer setImage:[UIImage imageNamed:@"Contact-customer-service_1"] forState:UIControlStateNormal];
        _chatWithServer.tag = 0;
        [_chatWithServer addTarget:self action:@selector(footViewBtnActionsWithBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_chatWithServer];
        
        _collectBtn = [[UIButton alloc]initWithFrame:CGRectMake(_chatWithServer.frame.origin.x + _chatWithServer.frame.size.width, 0, _chatWithServer.frame.size.width, frame.size.height)];
        _collectBtn.titleLabel.font = CUSFONT(9);
        [_collectBtn setImageEdgeInsets:UIEdgeInsetsMake(-10, 0, 0, -25)];
        [_collectBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, -25, 0)];
        [_collectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [_collectBtn setTitle:@"已收藏" forState:UIControlStateSelected];
        [_collectBtn setImage:[UIImage imageNamed:@"collection_1"] forState:UIControlStateNormal];
        [_collectBtn setImage:[UIImage imageNamed:@"details_iscollect_btn"] forState:UIControlStateSelected];
        _collectBtn.selected = item.isCollect;
        if (_collectBtn.selected) {
            [_collectBtn setImageEdgeInsets:UIEdgeInsetsMake(-10, 0, 0, -35)];
        }else{
            [_collectBtn setImageEdgeInsets:UIEdgeInsetsMake(-10, 0, 0, -25)];
        }
        _collectBtn.tag = 1;
        [_collectBtn addTarget:self action:@selector(footViewBtnActionsWithBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_collectBtn];
        
        _shopCartBtn = [[UIButton alloc]initWithFrame:CGRectMake(_collectBtn.frame.origin.x + _collectBtn.frame.size.width, 0, _chatWithServer.frame.size.width, frame.size.height)];
        _shopCartBtn.titleLabel.font = CUSFONT(9);
        [_shopCartBtn setImageEdgeInsets:UIEdgeInsetsMake(-10, 0, 0, -17)];
        [_shopCartBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, -25, 0)];
        [_shopCartBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_shopCartBtn setTitle:@"购物车" forState:UIControlStateNormal];
        [_shopCartBtn setImage:[UIImage imageNamed:@"product_detail_shopcart"] forState:UIControlStateNormal];
        _shopCartBtn.tag = 2;
        [_shopCartBtn addTarget:self action:@selector(footViewBtnActionsWithBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_shopCartBtn];
        
        _shopcartCountLable = [[UILabel alloc]initWithFrame:CGRectMake(_shopCartBtn.frame.origin.x + FitWith(50.0), FitHeight(10.0), FitWith(30.0), FitWith(30.0))];
        _shopcartCountLable.backgroundColor = [UIColor mainColor];
        _shopcartCountLable.layer.cornerRadius = FitWith(30.0) *0.5;
        _shopcartCountLable.layer.masksToBounds = true;
        _shopcartCountLable.textAlignment = NSTextAlignmentCenter;
        _shopcartCountLable.font = CUSFONT(9);
        _shopcartCountLable.adjustsFontSizeToFitWidth = true;
        _shopcartCountLable.textColor = [UIColor whiteColor];
        _shopcartCountLable.hidden = true;
        [self addSubview:_shopcartCountLable];
        
        _addToShopCart = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth * 0.5, 0, mainScreenWidth * 0.25, frame.size.height)];
        _addToShopCart.titleLabel.font = CUSFONT(13);
        _addToShopCart.backgroundColor = [UIColor orangeColor];
        [_addToShopCart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addToShopCart setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_addToShopCart addTarget:self action:@selector(footViewBtnActionsWithBtn:) forControlEvents:UIControlEventTouchUpInside];
        _addToShopCart.tag = 3;
        [self addSubview:_addToShopCart];
        
        _buyNowBtn = [[UIButton alloc]initWithFrame:CGRectMake(_addToShopCart.frame.origin.x + _addToShopCart.frame.size.width, 0, (mainScreenWidth * 0.5) *0.5, frame.size.height)];
        _buyNowBtn.titleLabel.font = CUSFONT(13);
        _buyNowBtn.backgroundColor = [UIColor mainColor];
        [_buyNowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buyNowBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        _buyNowBtn.tag = 4;
        [_buyNowBtn addTarget:self action:@selector(footViewBtnActionsWithBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_buyNowBtn];
        
        _noRepertoryBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth * 0.5, 0, mainScreenWidth * 0.5, frame.size.height)];
        _noRepertoryBtn.backgroundColor = [UIColor colorFromHex:0xcccccc];
        _noRepertoryBtn.titleLabel.font = CUSFONT(15);
        [_noRepertoryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_noRepertoryBtn setTitle:@"暂无库存" forState:UIControlStateNormal];
        _noRepertoryBtn.userInteractionEnabled = false;
        _noRepertoryBtn.hidden = true;
        [self addSubview:_noRepertoryBtn];
        [self setupInfoWithProductDetailsData:item];
    }
    return self;
}

-(void)setupInfoWithProductDetailsData:(ProductDetailsData *)item{
    _item = item;
    NSString *repertoryNum = @"";
    if (item.seckillStatus == ProductDetailsSeckilling) {
        repertoryNum = [NSString stringWithFormat:@"%@",item.productNewRobResponse.curDetailResponse.robCount];
    }else{
        repertoryNum = [NSString stringWithFormat:@"%@",item.repertorySelect.count];
    }
    _noRepertoryBtn.hidden = repertoryNum.integerValue != 0;
    _addToShopCart.hidden = repertoryNum.integerValue == 0;
    _buyNowBtn.hidden = repertoryNum.integerValue == 0;
}

-(void)resetShopcartCountlableShowCount:(NSString *)countStr{
    _shopcartCountLable.text = countStr.integerValue > 99 ? @"99+" : countStr;
    _shopcartCountLable.hidden = countStr.integerValue == 0;
}

-(void)footViewBtnActionsWithBtn:(UIButton *)btn{
    FootViewBtnActionBlock block = _btnActionHandle;
    if (block) {
        block(btn);
    }
}

@end
