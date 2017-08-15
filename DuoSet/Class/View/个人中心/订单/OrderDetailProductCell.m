//
//  OrderDetailProductCell.m
//  DuoSet
//
//  Created by mac on 2017/1/5.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OrderDetailProductCell.h"
#import "OrderDetailsProductView.h"

@interface OrderDetailProductCell()

@property(nonatomic,strong) DuojiOrderData *order;
@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIImageView *doojeeLogo;
@property(nonatomic,strong) UILabel *duosetLable;
@property(nonatomic,strong) UIButton *chatWithServer;

@property(nonatomic,strong) NSMutableArray *productViews;
@property(nonatomic,strong) OrderDetailsProductView *lastProductV;

@end

@implementation OrderDetailProductCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDuoSetOrder:(DuojiOrderData *)order{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        
        _order = order;
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor colorFromHex:0xffffff];
        [self.contentView addSubview:_bgView];
        
        _doojeeLogo = [UIImageView newAutoLayoutView];
        _doojeeLogo.image = [UIImage imageNamed:@"order_logo_image"];
        [_bgView addSubview:_doojeeLogo];
        
        _duosetLable = [UILabel newAutoLayoutView];
        _duosetLable.text = @"哆集";
        _duosetLable.textColor = [UIColor colorFromHex:0x222222];
        _duosetLable.textAlignment = NSTextAlignmentLeft;
        _duosetLable.font = CUSNEwFONT(15);
        [_bgView addSubview:_duosetLable];
        
        _productViews = [NSMutableArray array];
        for (int i = 0; i < _order.orderDetailResponses.count; i++) {
            OrderDetailsProductView *view = [OrderDetailsProductView new];
            view.tag = i;
            view.userInteractionEnabled = true;
            UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(productViewTapActionHandle:)];
            [view addGestureRecognizer:g];
            [_bgView addSubview:view];
            [_productViews addObject:view];
        }
        
        _chatWithServer = [UIButton newAutoLayoutView];
        _chatWithServer.titleLabel.font = CUSNEwFONT(16);
        _chatWithServer.layer.borderColor = [UIColor mainColor].CGColor;
        _chatWithServer.layer.borderWidth = 0.5;
        _chatWithServer.layer.cornerRadius = 2;
        _chatWithServer.layer.masksToBounds = true;
        [_chatWithServer setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        [_chatWithServer setTitle:@"联系哆集客服" forState:UIControlStateNormal];
        [_chatWithServer addTarget:self action:@selector(chatWithServerBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_chatWithServer];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)productViewTapActionHandle:(UITapGestureRecognizer *)tap{
    ProductViewTapBlock block = _productTapHandle;
    if (block) {
        block(tap.view.tag);
    }
}

-(void)setupInfoWithDuoSetOrder:(DuojiOrderData *)item{
    for (int i = 0; i < item.orderDetailResponses.count; i++) {
        OrderDetailsProductView *view = _productViews[i];
        DuojiOrderProductData *product = item.orderDetailResponses[i];
        [view setupInfoWithOrderProduct:product];
    }
}

-(void)chatWithServerBtnAction{
    ChatWithServerBlock block = _chatHandle;
    if (block) {
        block();
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(20.0)];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        UIImage *logoImage = [UIImage imageNamed:@"order_logo_image"];
        [_doojeeLogo autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_doojeeLogo autoSetDimension:ALDimensionWidth toSize:logoImage.size.width];
        [_doojeeLogo autoSetDimension:ALDimensionHeight toSize:logoImage.size.height];
        [_doojeeLogo autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        
        [_duosetLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_doojeeLogo];
        [_duosetLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(80.0)];
        
        for (int i = 0; i < _order.orderDetailResponses.count; i++) {
            OrderDetailsProductView *view = _productViews[i];
            if (i == 0) {
                [view autoPinEdgeToSuperviewEdge:ALEdgeLeft];
                [view autoPinEdgeToSuperviewEdge:ALEdgeRight];
                [view autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(80.0)];
                [view autoSetDimension:ALDimensionHeight toSize:FitHeight(160.0)];
                _lastProductV = view;
            }else{
                [view autoPinEdgeToSuperviewEdge:ALEdgeLeft];
                [view autoPinEdgeToSuperviewEdge:ALEdgeRight];
                [view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_lastProductV withOffset:FitHeight(10)];
                [view autoSetDimension:ALDimensionHeight toSize:FitHeight(160.0)];
                _lastProductV = view;
            }
        }
        [_chatWithServer autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_lastProductV withOffset:FitHeight(30.0)];
        [_chatWithServer autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_chatWithServer autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_chatWithServer autoSetDimension:ALDimensionHeight toSize:FitHeight(78.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
