//
//  OrderMianCell.m
//  DuoSet
//
//  Created by fanfans on 1/4/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import "OrderMianCell.h"
#import "OrderProductView.h"

@interface OrderMianCell()

@property(nonatomic,assign) DuojiOrderData *order;
@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *bgView;
//@property(nonatomic,strong) UILabel *duosetLable;
@property(nonatomic,strong) UILabel *orderNoLable;
@property(nonatomic,strong) UILabel *orderTimeLable;
@property(nonatomic,strong) UILabel *statusLable;
@property(nonatomic,strong) UIView *vLine;//小竖线
@property(nonatomic,strong) UIButton *deleteBtn;
@property(nonatomic,strong) NSMutableArray *productViews;
@property(nonatomic,strong) OrderProductView *lastProductV;
@property(nonatomic,strong) UILabel *productCountLable;
@property(nonatomic,strong) UILabel *priceLable;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) UIButton *btn1;
@property(nonatomic,strong) UIButton *btn2;
@property(nonatomic,strong) UIButton *btn3;

@end

@implementation OrderMianCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDuoSetOrder:(DuojiOrderData *)order{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _order = order;
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor colorFromHex:0xffffff];
        [self.contentView addSubview:_bgView];
        
        _orderNoLable = [UILabel newAutoLayoutView];
        _orderNoLable.font = CUSFONT(12);
        _orderNoLable.textAlignment = NSTextAlignmentLeft;
        _orderNoLable.textColor = [UIColor colorFromHex:0x222222];
        [_bgView addSubview:_orderNoLable];
        
        _orderTimeLable = [UILabel newAutoLayoutView];
        _orderTimeLable.font = CUSFONT(12);
        _orderTimeLable.textAlignment = NSTextAlignmentLeft;
        _orderTimeLable.textColor = [UIColor colorFromHex:0x222222];
        [_bgView addSubview:_orderTimeLable];
        
        _statusLable = [UILabel newAutoLayoutView];
        _statusLable.textAlignment = NSTextAlignmentRight;
        _statusLable.font = CUSFONT(13);
        _statusLable.textColor = [UIColor mainColor];
        [_bgView addSubview:_statusLable];
        
        if (_order.orderState != OrderStatesCreate) {
            _vLine = [UIView newAutoLayoutView];
            _vLine.backgroundColor = [UIColor lightGrayColor];
            [_bgView addSubview:_vLine];
            
            _deleteBtn = [UIButton newAutoLayoutView];
            [_deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
            [_bgView addSubview:_vLine];
        }
        
        _productViews = [NSMutableArray array];
        for (int i = 0; i < _order.orderDetailResponses.count ; i++) {
            OrderProductView *productView = [OrderProductView newAutoLayoutView];
            productView.tag = i;
            productView.userInteractionEnabled = true;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(productViewTapHandle:)];
            [productView addGestureRecognizer:tap];
            [_productViews addObject:productView];
            [_bgView addSubview:productView];
        }
        
        _productCountLable = [UILabel newAutoLayoutView];
        _productCountLable.textColor = [UIColor colorFromHex:0x666666];
        _productCountLable.textAlignment = NSTextAlignmentRight;
        _productCountLable.font = CUSFONT(12);
        [_bgView addSubview:_productCountLable];
        
        _priceLable = [UILabel newAutoLayoutView];
        _priceLable.textColor = [UIColor mainColor];
        _priceLable.font = CUSFONT(16);
        _priceLable.textAlignment = NSTextAlignmentRight;
        [_bgView addSubview:_priceLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        [_bgView addSubview:_line];
        
        _btn1 = [UIButton newAutoLayoutView];
        _btn1.titleLabel.font = CUSFONT(10);
        [_btn1 setTitleColor:[UIColor colorWithHexString:@"ed0831"] forState:UIControlStateNormal];
        _btn1.layer.borderWidth = 1;
        _btn1.layer.borderColor = [UIColor colorWithHexString:@"ed0831"].CGColor;
        _btn1.layer.cornerRadius = 2;
        _btn1.layer.masksToBounds = true;
        _btn1.tag = 0;
        [_btn1 addTarget:self action:@selector(btnAciton:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_btn1];
        
        _btn2 = [UIButton newAutoLayoutView];
        _btn2.titleLabel.font = CUSFONT(10);
        [_btn2 setTitleColor:[UIColor colorWithHexString:@"ed0831"] forState:UIControlStateNormal];
        _btn2.layer.borderColor = [UIColor colorWithHexString:@"ed0831"].CGColor;
        _btn2.layer.borderWidth = 1;
        _btn2.layer.cornerRadius = 2;
        _btn2.layer.masksToBounds = true;
        _btn2.tag = 1;
        [_btn2 addTarget:self action:@selector(btnAciton:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_btn2];
        
        _btn3 = [UIButton newAutoLayoutView];
        _btn3.titleLabel.font = CUSFONT(10);
        [_btn3 setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        _btn3.layer.borderColor = [UIColor mainColor].CGColor;
        _btn3.layer.borderWidth = 1;
        _btn3.layer.cornerRadius = 2;
        _btn3.layer.masksToBounds = true;
        _btn3.tag = 2;
        [_btn3 addTarget:self action:@selector(btnAciton:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_btn3];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
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

-(void)setupInfoWithDuoSetOrder:(DuojiOrderData *)item{
    _order = item;
    _orderNoLable.text = [NSString stringWithFormat:@"订单编号:%@",item.no];
    _orderTimeLable.text = [NSString stringWithFormat:@"下单日期:%@",item.createTime];
    if (_order.orderState == OrderStatesCreate) {
        _statusLable.text = item.statusName;
        _statusLable.textColor = [UIColor mainColor];
        _btn1.hidden = true;
        _btn2.hidden = false;
        _btn3.hidden = false;
        [_btn2 setTitle:@"取消订单" forState:UIControlStateNormal];
        [_btn2 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        _btn2.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
        
        [_btn3 setTitle:@"去支付" forState:UIControlStateNormal];
        [_btn3 setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        _btn3.layer.borderColor = [UIColor mainColor].CGColor;
    }
    if (_order.orderState == OrderStatesPaid) {
        _statusLable.text = item.statusName;
        _statusLable.textColor = [UIColor mainColor];
        _btn1.hidden = true;
        _btn2.hidden = false;
        _btn3.hidden = false;
        [_btn2 setTitle:@"申请退款" forState:UIControlStateNormal];
        [_btn2 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        _btn2.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
        [_btn3 setTitle:@"提醒发货" forState:UIControlStateNormal];
        [_btn3 setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        _btn3.layer.borderColor = [UIColor mainColor].CGColor;
    }
    if (_order.orderState == OrderStatesSend) {
        _statusLable.text = item.statusName;
        _statusLable.textColor = [UIColor mainColor];
        _btn1.hidden = true;
        _btn2.hidden = true;
        _btn3.hidden = false;
        [_btn3 setTitle:@"查看物流" forState:UIControlStateNormal];
        [_btn3 setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        _btn3.layer.borderColor = [UIColor mainColor].CGColor;
    }
    if (_order.orderState == OrderStatesRecive) {
        _statusLable.text = item.statusName;
        _statusLable.textColor = [UIColor mainColor];
        if (_order.orderDetailResponses.count > 1) {
            _btn1.hidden = true;
            _btn2.hidden = false;
            _btn3.hidden = false;
            [_btn2 setTitle:@"退换货" forState:UIControlStateNormal];
            [_btn2 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
            _btn2.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
            
            [_btn3 setTitle:@"评价晒单" forState:UIControlStateNormal];
            [_btn3 setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
            _btn3.layer.borderColor = [UIColor mainColor].CGColor;
        }else{
            DuojiOrderProductData *item = _order.orderDetailResponses[0];
            if (item.productStatus == OrderProductStatesdefault) {
                _btn1.hidden = true;
                _btn2.hidden = false;
                _btn3.hidden = false;
                [_btn2 setTitle:@"退换货" forState:UIControlStateNormal];
                _btn2.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
                [_btn2 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
                
                if (item.commentStatus == OrderProductCommentNoComment) {
                    [_btn3 setTitle:@"评价晒单" forState:UIControlStateNormal];
                }
                if (item.commentStatus == OrderProductCommentCommented) {
                    [_btn3 setTitle:@"查看评价" forState:UIControlStateNormal];
                }
                _btn3.layer.borderColor = [UIColor mainColor].CGColor;
                [_btn3 setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
            }
            if (item.productStatus == OrderProductStatesExchangeCheking || item.productStatus == OrderProductStatesReturnCheking) {
                
                if (item.commentStatus == OrderProductCommentNoComment) {
                    _btn1.hidden = true;
                    _btn2.hidden = true;
                    _btn3.hidden = false;
                    [_btn3 setTitle:@"审核中" forState:UIControlStateNormal];
                    _btn3.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
                    [_btn3 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
                }
                if (item.commentStatus == OrderProductCommentCommented) {
                    _btn1.hidden = true;
                    _btn2.hidden = false;
                    _btn3.hidden = false;
                    [_btn2 setTitle:@"审核中" forState:UIControlStateNormal];
                    _btn2.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
                    [_btn2 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
                    
                    [_btn3 setTitle:@"查看评价" forState:UIControlStateNormal];
                    _btn3.layer.borderColor = [UIColor mainColor].CGColor;
                    [_btn3 setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
                }
            }
            if (item.productStatus == OrderProductStatesExchangeHandling || item.productStatus == OrderProductStatesReturnHandling) {
                if (item.commentStatus == OrderProductCommentNoComment) {
                    _btn1.hidden = true;
                    _btn2.hidden = true;
                    _btn3.hidden = false;
                    
                    [_btn3 setTitle:@"处理中" forState:UIControlStateNormal];
                    _btn3.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
                    [_btn3 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
                }
                if (item.commentStatus == OrderProductCommentCommented) {
                    _btn1.hidden = true;
                    _btn2.hidden = false;
                    _btn3.hidden = false;
                    [_btn2 setTitle:@"处理中" forState:UIControlStateNormal];
                    _btn2.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
                    [_btn2 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
                    
                    [_btn3 setTitle:@"查看评价" forState:UIControlStateNormal];
                    _btn3.layer.borderColor = [UIColor mainColor].CGColor;
                    [_btn3 setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
                }
            }
            if (item.productStatus == OrderProductStatesExchangeRefuse || item.productStatus == OrderProductStatesReturnRefuse) {
                if (item.commentStatus == OrderProductCommentNoComment) {
                    _btn1.hidden = true;
                    _btn2.hidden = false;
                    _btn3.hidden = false;
                    
                    _btn2.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
                    [_btn2 setTitle:@"审核失败" forState:UIControlStateNormal];
                    [_btn2 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
                    
                    [_btn3 setTitle:@"评价晒单" forState:UIControlStateNormal];
                    _btn3.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
                    [_btn3 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
                }
                if (item.commentStatus == OrderProductCommentCommented) {
                    _btn1.hidden = true;
                    _btn2.hidden = false;
                    _btn3.hidden = false;
                    
                    _btn2.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
                    [_btn2 setTitle:@"审核失败" forState:UIControlStateNormal];
                    [_btn2 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
                    
                    [_btn3 setTitle:@"查看评价" forState:UIControlStateNormal];
                    _btn3.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
                    [_btn3 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
                }
            }
            
            if (item.productStatus == OrderProductStatesExchangeFinish || item.productStatus == OrderProductStatesReturnFinish) {
                _btn1.hidden = true;
                _btn2.hidden = true;
                _btn3.hidden = false;
                
                [_btn2 setTitle:item.productStatus == OrderProductStatesExchangeFinish ? @"换货完成" : @"退货完成" forState:UIControlStateNormal];
                _btn2.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
                [_btn2 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
                
                
                if (item.commentStatus == OrderProductCommentNoComment) {
                    [_btn3 setTitle:@"评价晒单" forState:UIControlStateNormal];
                }
                if (item.commentStatus == OrderProductCommentCommented) {
                    [_btn3 setTitle:@"查看评价" forState:UIControlStateNormal];
                }
                _btn3.layer.borderColor = [UIColor mainColor].CGColor;
                [_btn3 setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
            }
        }
    }
    if (_order.orderState == OrderStatesCancel) {
        _statusLable.text = item.statusName;
        _statusLable.textColor = [UIColor mainColor];
        _btn1.hidden = true;
        _btn2.hidden = true;
        _btn3.hidden = false;
        [_btn3 setTitle:@"删除订单" forState:UIControlStateNormal];
        [_btn3 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        _btn3.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
    }
    _productCountLable.text = (_order.orderState == OrderStatesCreate || _order.orderState == OrderStatesCancel) ? [NSString stringWithFormat:@"共%ld种商品 需付款:",item.orderDetailResponses.count] : [NSString stringWithFormat:@"共%ld种商品 实付款:",item.orderDetailResponses.count];
    NSString *text = [NSString stringWithFormat:@"¥ %.2f",_order.totalPrice != nil ?  _order.totalPrice.floatValue : _order.amountPrice.floatValue ];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeString addAttribute:NSFontAttributeName value:CUSFONT(12) range:NSMakeRange(text.length - 2,2)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(text.length - 2, 2)];
    _priceLable.attributedText = attributeString;
    for (int i = 0; i < item.orderDetailResponses.count; i++) {
        OrderProductView *view = _productViews[i];
        DuojiOrderProductData *product = item.orderDetailResponses[i];
        [view setupInfoWithOrderProduct:product];
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [_orderNoLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_orderNoLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10)];
        
        [_orderTimeLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_orderNoLable];
        [_orderTimeLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_orderNoLable withOffset:FitHeight(10.0)];
        
//        if (_order.state == OrderStatesRecive) {
//            [_deleteBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
//            [_deleteBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
//            [_deleteBtn autoSetDimension:ALDimensionWidth toSize:FitWith(100)];
//            [_deleteBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(150)];
//            
//            [_vLine autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(60.0)];
//            [_vLine autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_deleteBtn];
//            [_vLine autoSetDimension:ALDimensionWidth toSize:1];
//            [_vLine autoSetDimension:ALDimensionHeight toSize:FitHeight(40.0)];
//            
//            [_statusLable autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_vLine withOffset:FitWith(30.0)];
//            [_statusLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
//            [_statusLable autoSetDimension:ALDimensionWidth toSize:FitWith(900.0)];
//        }else{
            [_statusLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(40.0)];
            [_statusLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
            [_statusLable autoSetDimension:ALDimensionHeight toSize:FitHeight(80.0)];
//        }
        
        
        for (int i = 0; i < _order.orderDetailResponses.count; i++) {
            OrderProductView *view = _productViews[i];
            if (i == 0) {
                [view autoPinEdgeToSuperviewEdge:ALEdgeLeft];
                [view autoPinEdgeToSuperviewEdge:ALEdgeRight];
                [view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_orderTimeLable withOffset:FitHeight(10.0)];
                [view autoSetDimension:ALDimensionHeight toSize:FitHeight(190.0)];
                _lastProductV = view;
            }else{
                [view autoPinEdgeToSuperviewEdge:ALEdgeLeft];
                [view autoPinEdgeToSuperviewEdge:ALEdgeRight];
                [view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_lastProductV withOffset:FitHeight(10)];
                [view autoSetDimension:ALDimensionHeight toSize:FitHeight(190.0)];
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
        
        [_btn1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(300.0)];
        [_btn1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_line withOffset:FitHeight(25.0)];
        [_btn1 autoSetDimension:ALDimensionWidth toSize:FitWith(120.0)];
        [_btn1 autoSetDimension:ALDimensionHeight toSize:FitHeight(50.0)];
        
        [_btn2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_btn1 withOffset:FitWith(25.0)];
        [_btn2 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_btn1];
        [_btn2 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_btn1];
        [_btn2 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_btn1];
        
        [_btn3 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_btn2 withOffset:FitWith(25.0)];
        [_btn3 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_btn1];
        [_btn3 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_btn1];
        [_btn3 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_btn1];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
