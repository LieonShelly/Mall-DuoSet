//
//  OrderListMainCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OrderListMainCell.h"
#import "OrderListProductView.h"

@interface OrderListMainCell()

@property(nonatomic,assign) DuojiOrderData *order;
@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIImageView *doojeeLogo;
@property(nonatomic,strong) UILabel *doojeeName;
@property(nonatomic,strong) UILabel *statusLable;

@property(nonatomic,strong) UIView *vLine;//小竖线
@property(nonatomic,strong) UIButton *deleteBtn;
@property(nonatomic,strong) UILabel *deletdStatusLable;

@property(nonatomic,strong) NSMutableArray *productViews;
@property(nonatomic,strong) OrderListProductView *lastProductV;
@property(nonatomic,strong) UILabel *productCountLable;
@property(nonatomic,strong) UILabel *priceLable;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) UIButton *btn1;
@property(nonatomic,strong) UIButton *btn2;

@end

@implementation OrderListMainCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDuoSetOrder:(DuojiOrderData *)order{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _order = order;
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor colorFromHex:0xffffff];
        [self.contentView addSubview:_bgView];
        
        _doojeeLogo = [UIImageView newAutoLayoutView];
        _doojeeLogo.image = [UIImage imageNamed:@"order_logo_image"];
        [_bgView addSubview:_doojeeLogo];
        
        _doojeeName = [UILabel newAutoLayoutView];
        _doojeeName.textColor = [UIColor colorFromHex:0x212121];
        _doojeeName.font = CUSNEwFONT(15);
        _doojeeName.text = @"哆集";
        _doojeeName.textAlignment = NSTextAlignmentLeft;
        [_bgView addSubview:_doojeeName];
        
        _statusLable = [UILabel newAutoLayoutView];
        _statusLable.textAlignment = NSTextAlignmentRight;
        _statusLable.font = CUSNEwFONT(15);
        _statusLable.textColor = [UIColor mainColor];
        [_bgView addSubview:_statusLable];
        
        _vLine = [UIView newAutoLayoutView];
        _vLine.backgroundColor = [UIColor lightGrayColor];
        [_bgView addSubview:_vLine];
        
        _deleteBtn = [UIButton newAutoLayoutView];
        [_deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteBtnActionHandle) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_deleteBtn];
        
        _deletdStatusLable = [UILabel newAutoLayoutView];
        _deletdStatusLable.textAlignment = NSTextAlignmentRight;
        _deletdStatusLable.font = CUSNEwFONT(15);
        _deletdStatusLable.textColor = [UIColor mainColor];
        [_bgView addSubview:_deletdStatusLable];

        _productViews = [NSMutableArray array];
        for (int i = 0; i < _order.orderDetailResponses.count ; i++) {
            OrderListProductView *productView = [OrderListProductView newAutoLayoutView];
            productView.tag = i;
            productView.userInteractionEnabled = false;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(productViewTapHandle:)];
            [productView addGestureRecognizer:tap];
            [_productViews addObject:productView];
            [_bgView addSubview:productView];
        }
        
        _productCountLable = [UILabel newAutoLayoutView];
        _productCountLable.textColor = [UIColor colorFromHex:0x212121];
        _productCountLable.textAlignment = NSTextAlignmentRight;
        _productCountLable.font = CUSFONT(13);
        [_bgView addSubview:_productCountLable];
        
        _priceLable = [UILabel newAutoLayoutView];
        _priceLable.textColor = [UIColor colorFromHex:0x212121];
        _priceLable.font = CUSFONT(16);
        _priceLable.textAlignment = NSTextAlignmentRight;
        [_bgView addSubview:_priceLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        [_bgView addSubview:_line];
        
        _btn1 = [UIButton newAutoLayoutView];
        _btn1.titleLabel.font = CUSFONT(10);
        [_btn1 setTitleColor:[UIColor colorFromHex:0x212121] forState:UIControlStateNormal];
        _btn1.layer.borderWidth = 1;
        _btn1.layer.borderColor = [UIColor colorFromHex:0x999999].CGColor;
        _btn1.layer.cornerRadius = 2;
        _btn1.layer.masksToBounds = true;
        _btn1.tag = 0;
        [_btn1 addTarget:self action:@selector(btnAciton:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_btn1];
        
        _btn2 = [UIButton newAutoLayoutView];
        _btn2.titleLabel.font = CUSFONT(10);
        [_btn2 setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        _btn2.layer.borderColor = [UIColor mainColor].CGColor;
        _btn2.layer.borderWidth = 1;
        _btn2.layer.cornerRadius = 2;
        _btn2.layer.masksToBounds = true;
        _btn2.tag = 1;
        [_btn2 addTarget:self action:@selector(btnAciton:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_btn2];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)deleteBtnActionHandle{
    CellDeletedButtonActionBlock block = _cellDeletedHandle;
    if (block) {
        block(_order);
    }
}


-(void)btnAciton:(UIButton *)btn{
    OrderCellBtnActionBlock block = _btnActionHandle;
    if (block) {
        block(_order,btn.tag);
    }
}

-(void)productViewTapHandle:(UITapGestureRecognizer *)tap{
    CellProductViewTapBlock block = _productTapHandle;
    if (block) {
        block(_order,tap.view.tag);
    }
}

/** 处理是否隐藏 删除按钮 */
-(void)hiddenMainStatusLableWithDuoSetOrder:(DuojiOrderData *)item{
    if (item.orderState == OrderStatesCancel || item.orderState == OrderStatesDone || item.orderState == OrderStatesWaitComment) {
        _statusLable.hidden = true;
        _vLine.hidden = false;
        _deleteBtn.hidden = false;
        _deletdStatusLable.hidden = false;
        _deletdStatusLable.text = item.statusName;
    }else{
        _vLine.hidden = true;
        _deleteBtn.hidden = true;
        _deletdStatusLable.hidden = true;
        _statusLable.hidden = false;
        _statusLable.text = item.statusName;
    }
}

-(void)setupInfoWithDuoSetOrder:(DuojiOrderData *)item{
    _order = item;
    [self hiddenMainStatusLableWithDuoSetOrder:item];
    if (_order.orderState == OrderStatesCancel) {//已取消
        _btn1.hidden = true;
        _btn2.hidden = false;
        [_btn2 setTitle:@"再次购买" forState:UIControlStateNormal];
    }
    if (_order.orderState == OrderStatesCreate) {//待付款
        _btn1.hidden = true;
        _btn2.hidden = false;
        [_btn2 setTitle:@"去支付" forState:UIControlStateNormal];
    }
    if (_order.orderState == OrderStatesBeforSendCancel) {//申请退款
        _btn1.hidden = true;
        _btn2.hidden = false;
        [_btn2 setTitle:@"再次购买" forState:UIControlStateNormal];
    }
    if (_order.orderState == OrderStatesPaid) {//待发货
        _statusLable.text = item.statusName;
        _btn1.hidden = true;
        _btn2.hidden = false;
        [_btn2 setTitle:@"再次购买" forState:UIControlStateNormal];
    }
    if (_order.orderState == OrderStatesSend) {//待收货
        _btn1.hidden = false;
        _btn2.hidden = false;
        [_btn2 setTitle:@"查看物流" forState:UIControlStateNormal];
        [_btn1 setTitle:@"再次购买" forState:UIControlStateNormal];
    }
    if (_order.orderState == OrderStatesWaitComment) {//待评价
        _btn1.hidden = false;
        _btn2.hidden = false;
        [_btn2 setTitle:@"评价晒单" forState:UIControlStateNormal];
        [_btn1 setTitle:@"再次购买" forState:UIControlStateNormal];
    }
    if (_order.orderState == OrderStatesDone) {//已完成
        _btn1.hidden = false;
        _btn2.hidden = false;
        [_btn2 setTitle:@"再次购买" forState:UIControlStateNormal];
        [_btn1 setTitle:@"查看评价" forState:UIControlStateNormal];
    }
    _productCountLable.text = [NSString stringWithFormat:@"共%ld种商品 实付款:",(unsigned long)item.orderDetailResponses.count];
    NSString *text = [NSString stringWithFormat:@"¥ %.2f",_order.totalPrice != nil ?  _order.totalPrice.floatValue : _order.amountPrice.floatValue ];
    _priceLable.text = text;
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    if (text.length > 1) {
        [attributeString addAttribute:NSFontAttributeName value:CUSFONT(12) range:NSMakeRange(0, 1)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHex:0x212121] range:NSMakeRange(0, 1)];
    }
    _priceLable.attributedText = attributeString;
    for (int i = 0; i < item.orderDetailResponses.count; i++) {
        OrderListProductView *view = _productViews[i];
        DuojiOrderProductData *product = item.orderDetailResponses[i];
        [view setupInfoWithOrderProduct:product];
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(20.0)];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        
        [_statusLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_statusLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10.0)];
        [_statusLable autoSetDimension:ALDimensionHeight toSize:FitHeight(80.0)];
        
        UIImage *logoImage = [UIImage imageNamed:@"order_logo_image"];
        [_doojeeLogo autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_doojeeLogo autoSetDimension:ALDimensionWidth toSize:logoImage.size.width];
        [_doojeeLogo autoSetDimension:ALDimensionHeight toSize:logoImage.size.height];
        [_doojeeLogo autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_statusLable];
        
        [_doojeeName autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_statusLable];
        [_doojeeName autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(80.0)];
        
        [_deleteBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10.0)];
        [_deleteBtn autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_deleteBtn autoSetDimension:ALDimensionWidth toSize:FitHeight(85.0)];
        [_deleteBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(85.0)];

        [_vLine autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(28.0)];
        [_vLine autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_deleteBtn];
        [_vLine autoSetDimension:ALDimensionWidth toSize:1];
        [_vLine autoSetDimension:ALDimensionHeight toSize:FitHeight(45.0)];
        
        [_deletdStatusLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_statusLable];
        [_deletdStatusLable autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_vLine withOffset: -FitWith(26)];
        
        for (int i = 0; i < _order.orderDetailResponses.count; i++) {
            OrderListProductView *view = _productViews[i];
            if (i == 0) {
                [view autoPinEdgeToSuperviewEdge:ALEdgeLeft];
                [view autoPinEdgeToSuperviewEdge:ALEdgeRight];
                [view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_statusLable withOffset:FitHeight(10.0)];
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
        [_priceLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_priceLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_lastProductV];
        [_priceLable autoSetDimension:ALDimensionHeight toSize:FitHeight(80.0)];
        
        [_productCountLable autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_priceLable];
        [_productCountLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_priceLable];
        [_productCountLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_priceLable];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_priceLable];
        [_line autoSetDimension:ALDimensionHeight toSize:1];
        
        [_btn1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(445.0)];
        [_btn1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_line withOffset:FitHeight(25.0)];
        [_btn1 autoSetDimension:ALDimensionWidth toSize:FitWith(120.0)];
        [_btn1 autoSetDimension:ALDimensionHeight toSize:FitHeight(50.0)];
        
        [_btn2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_btn1 withOffset:FitWith(25.0)];
        [_btn2 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_btn1];
        [_btn2 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_btn1];
        [_btn2 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_btn1];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
