//
//  AllOrderTableViewCell.m
//  DuoSet
//
//  Created by fanfans on 2017/4/10.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "AllOrderTableViewCell.h"
#import "OrderProductView.h"

@interface AllOrderTableViewCell()

@property(nonatomic,assign) DuojiOrderData *order;
@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UILabel *duosetLable;
@property(nonatomic,strong) UILabel *statusLable;
@property(nonatomic,strong) UIView *vLine;//小竖线
@property(nonatomic,strong) UIButton *deleteBtn;
@property(nonatomic,strong) NSMutableArray *productViews;
@property(nonatomic,strong) OrderProductView *lastProductV;
@property(nonatomic,strong) UILabel *productCountLable;
@property(nonatomic,strong) UILabel *priceLable;

@end

@implementation AllOrderTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDuoSetOrder:(DuojiOrderData *)order{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _order = order;
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor colorFromHex:0xffffff];
        [self.contentView addSubview:_bgView];
        
        _duosetLable = [UILabel newAutoLayoutView];
        _duosetLable.text = @"哆集";
        _duosetLable.font = CUSFONT(14);
        _duosetLable.textColor = [UIColor colorFromHex:0x666666];
        [_bgView addSubview:_duosetLable];
        
        _statusLable = [UILabel newAutoLayoutView];
        _statusLable.text = @"已完成";
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
            [_productViews addObject:productView];
            productView.userInteractionEnabled = true;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OrderProductTap:)];
            [productView addGestureRecognizer:tap];
            [_bgView addSubview:productView];
        }
        
        _productCountLable = [UILabel newAutoLayoutView];
        _productCountLable.text = @"共1件商品 实付款:";
        _productCountLable.textColor = [UIColor colorFromHex:0x666666];
        _productCountLable.textAlignment = NSTextAlignmentRight;
        _productCountLable.font = CUSFONT(13);
        [_bgView addSubview:_productCountLable];
        
        _priceLable = [UILabel newAutoLayoutView];
        _priceLable.textColor = [UIColor mainColor];
        _priceLable.text = @"¥ 320";
        _priceLable.font = CUSFONT(16);
        _priceLable.textAlignment = NSTextAlignmentRight;
        [_bgView addSubview:_priceLable];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)OrderProductTap:(UITapGestureRecognizer *)tap{
    OrderProductTapBlock block = _productTapHandle;
    if (block) {
        block(tap.view.tag);
    }
}

-(void)setupInfoWithDuoSetOrder:(DuojiOrderData *)item{
    _order = item;
    NSInteger count = 0;
    for (DuojiOrderProductData *item in _order.orderDetailResponses) {
        count += item.count.integerValue;
    }
    _statusLable.text = item.statusName;
    _productCountLable.text = (item.orderState != OrderStatesDeleted || item.orderState != OrderStatesCreate) ? [NSString stringWithFormat:@"共%ld件商品 需付款:",count]  : [NSString stringWithFormat:@"共%ld件商品 实付款:",count];
    NSString *text = [NSString stringWithFormat:@"¥ %.2f",_order.totalPrice.floatValue];
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
        
        [_duosetLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_duosetLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_duosetLable autoSetDimension:ALDimensionWidth toSize:FitWith(240)];
        [_duosetLable autoSetDimension:ALDimensionHeight toSize:FitHeight(80.0)];
        
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
                [view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_duosetLable];
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
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
