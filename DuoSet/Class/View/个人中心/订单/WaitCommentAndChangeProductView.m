//
//  WaitCommentAndChangeProductView.m
//  DuoSet
//
//  Created by fanfans on 1/4/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import "WaitCommentAndChangeProductView.h"

@interface WaitCommentAndChangeProductView()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *productImgV;
@property(nonatomic,strong) UILabel *productName;
@property(nonatomic,strong) UILabel *productSubLable;
@property(nonatomic,strong) UILabel *priceLable;

@end

@implementation WaitCommentAndChangeProductView

-(instancetype)init{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor colorFromHex:0xfef9f5];
        
        _productImgV = [UIImageView newAutoLayoutView];
        _productImgV.layer.borderWidth = 0.5;
        _productImgV.layer.borderColor = [UIColor colorFromHex:0xa09f9d].CGColor;
        [self addSubview:_productImgV];
        
        _productName = [UILabel newAutoLayoutView];
        _productName.textColor = [UIColor colorFromHex:0x222222];
        _productName.numberOfLines = 2;
        _productName.font = CUSFONT(12);
        [self addSubview:_productName];
        
        _productSubLable = [UILabel newAutoLayoutView];
        _productSubLable.textColor = [UIColor colorFromHex:0x999999];
        _productSubLable.font = CUSFONT(10);
        [self addSubview:_productSubLable];
        
        _priceLable = [UILabel newAutoLayoutView];
        _priceLable.textColor = [UIColor colorFromHex:0x666666];
        _priceLable.font = CUSFONT(12);
        [self addSubview:_priceLable];
        
        _btn0 = [UIButton newAutoLayoutView];
        _btn0.titleLabel.font = CUSFONT(10);
        [_btn0 setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        _btn0.layer.borderColor = [UIColor mainColor].CGColor;
        _btn0.layer.borderWidth = 1;
        _btn0.layer.cornerRadius = 2;
        _btn0.layer.masksToBounds = true;
        _btn0.tag = 0;
        [_btn0 addTarget:self action:@selector(btnActionWithBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn0];
        
        _btn1 = [UIButton newAutoLayoutView];
        _btn1.titleLabel.font = CUSFONT(10);
        [_btn1 setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        _btn1.layer.borderColor = [UIColor mainColor].CGColor;
        _btn1.layer.borderWidth = 1;
        _btn1.layer.cornerRadius = 2;
        _btn1.layer.masksToBounds = true;
        _btn1.tag = 1;
        [_btn1 addTarget:self action:@selector(btnActionWithBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn1];
        
        _btn2 = [UIButton newAutoLayoutView];
        _btn2.titleLabel.font = CUSFONT(10);
        [_btn2 setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        _btn2.layer.borderColor = [UIColor mainColor].CGColor;
        _btn2.layer.borderWidth = 1;
        _btn2.layer.cornerRadius = 2;
        _btn2.layer.masksToBounds = true;
        _btn2.tag = 2;
        [_btn2 addTarget:self action:@selector(btnActionWithBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn2];
        
        [self updateConstraints];
    }
    return self;
}
//

-(void)btnActionWithBtn:(UIButton *)btn{
    ProductViewBtnsActionBlock block = _btnActionHandle;
    if (block) {
        block(btn.tag);
    }
}
-(void)setupIndoWithDuojiOrderData:(DuojiOrderData *)order andDuojiOrderProductData:(DuojiOrderProductData *)item{
    [_productImgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImage_226_256 options:0];
    _productName.text = item.productName;
    _productSubLable.text = item.propertyName;
    _priceLable.text = [NSString stringWithFormat:@"￥%@ x %@",[NSString stringWithFormat:@"%.2lf",item.price.floatValue],item.count];
    if (order.orderState == OrderStatesRecive) {
        [self setBtnShowOrHiddenWithDuojiOrderProductData:item];
    }else{
        _btn0.hidden = true;
        _btn1.hidden = true;
        _btn2.hidden = true;
    }
}

-(void)setupInfoReturnAndChangeData:(ReturnAndChangeData *)item{
    [_productImgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImage_226_256 options:0];
    _productName.text = item.productName;
    _productSubLable.text = item.propertyName;
    _priceLable.text = [NSString stringWithFormat:@"￥%@ x %@",item.price,item.count];
    if (item.productStatus == OrderProductStatesExchangeCheking || item.productStatus == OrderProductStatesReturnCheking) {
        if (item.commentStatus == OrderProductCommentNoComment) {
            _btn0.hidden = true;
            _btn1.hidden = true;
            _btn2.hidden = false;
            
            [_btn2 setTitle:@"审核中" forState:UIControlStateNormal];
            _btn2.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
            [_btn2 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        }
        if (item.commentStatus == OrderProductCommentCommented) {
            _btn0.hidden = true;
            _btn1.hidden = false;
            _btn2.hidden = false;
            
            [_btn1 setTitle:@"审核中" forState:UIControlStateNormal];
            _btn1.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
            [_btn1 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
            
            [_btn2 setTitle:@"查看评价" forState:UIControlStateNormal];
            _btn2.layer.borderColor = [UIColor mainColor].CGColor;
            [_btn2 setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        }
    }
    if (item.productStatus == OrderProductStatesExchangeHandling || item.productStatus == OrderProductStatesReturnHandling) {
        if (item.commentStatus == OrderProductCommentNoComment) {
            _btn0.hidden = true;
            _btn1.hidden = true;
            _btn2.hidden = false;
            
            [_btn2 setTitle:@"处理中" forState:UIControlStateNormal];
            _btn2.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
            [_btn2 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        }
        if (item.commentStatus == OrderProductCommentCommented) {
            _btn0.hidden = true;
            _btn1.hidden = false;
            _btn2.hidden = false;
            
            [_btn1 setTitle:@"处理中" forState:UIControlStateNormal];
            _btn1.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
            [_btn1 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
            
            [_btn2 setTitle:@"查看评价" forState:UIControlStateNormal];
            _btn2.layer.borderColor = [UIColor mainColor].CGColor;
            [_btn2 setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        }
    }
    if (item.productStatus == OrderProductStatesExchangeRefuse || item.productStatus == OrderProductStatesReturnRefuse) {
        _btn0.hidden = true;
        _btn1.hidden = false;
        _btn2.hidden = false;
        
        [_btn1 setTitle:@"审核失败" forState:UIControlStateNormal];
        _btn1.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
        [_btn1 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        
        if (item.commentStatus == OrderProductCommentNoComment) {
            [_btn2 setTitle:@"评价晒单" forState:UIControlStateNormal];
        }
        if (item.commentStatus == OrderProductCommentCommented) {
            [_btn2 setTitle:@"查看评价" forState:UIControlStateNormal];
        }
        _btn2.layer.borderColor = [UIColor mainColor].CGColor;
        [_btn2 setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
    }
    
    if (item.productStatus == OrderProductStatesExchangeFinish || item.productStatus == OrderProductStatesReturnFinish) {
        _btn0.hidden = true;
        _btn1.hidden = true;
        _btn2.hidden = false;
        
        [_btn1 setTitle:item.productStatus == OrderProductStatesExchangeFinish ? @"换货完成" : @"退货完成" forState:UIControlStateNormal];
        _btn1.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
        [_btn1 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        
        if (item.commentStatus == OrderProductCommentNoComment) {
            [_btn2 setTitle:@"评价晒单" forState:UIControlStateNormal];
        }
        if (item.commentStatus == OrderProductCommentCommented) {
            [_btn2 setTitle:@"查看评价" forState:UIControlStateNormal];
        }
        _btn2.layer.borderColor = [UIColor mainColor].CGColor;
        [_btn2 setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
    }
}

-(void)setupInfoWithOrderProduct:(DuojiOrderProductData *)item{
    [_productImgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImage_226_256 options:0];
    _productName.text = item.productName;
    _productSubLable.text = item.propertyName;
    _priceLable.text = [NSString stringWithFormat:@"￥%@ x %@",item.price,item.count];
    [self setBtnShowOrHiddenWithDuojiOrderProductData:item];
}

-(void)setBtnShowOrHiddenWithDuojiOrderProductData:(DuojiOrderProductData *)item{
    if (item.productStatus == OrderProductStatesdefault) {
        _btn0.hidden = true;
        _btn1.hidden = false;
        _btn2.hidden = false;
        [_btn1 setTitle:@"退换货" forState:UIControlStateNormal];
        _btn1.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
        [_btn1 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        
        if (item.commentStatus == OrderProductCommentNoComment) {
            [_btn2 setTitle:@"评价晒单" forState:UIControlStateNormal];
        }
        if (item.commentStatus == OrderProductCommentCommented) {
            [_btn2 setTitle:@"查看评价" forState:UIControlStateNormal];
        }
        _btn2.layer.borderColor = [UIColor mainColor].CGColor;
        [_btn2 setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
    }
    if (item.productStatus == OrderProductStatesExchangeCheking || item.productStatus == OrderProductStatesReturnCheking) {
        if (item.commentStatus == OrderProductCommentNoComment) {
            _btn0.hidden = true;
            _btn1.hidden = true;
            _btn2.hidden = false;
            
            [_btn2 setTitle:@"审核中" forState:UIControlStateNormal];
            _btn2.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
            [_btn2 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        }
        if (item.commentStatus == OrderProductCommentCommented) {
            _btn0.hidden = true;
            _btn1.hidden = false;
            _btn2.hidden = false;
            
            [_btn1 setTitle:@"审核中" forState:UIControlStateNormal];
            _btn1.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
            [_btn1 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
            
            [_btn2 setTitle:@"查看评价" forState:UIControlStateNormal];
            _btn2.layer.borderColor = [UIColor mainColor].CGColor;
            [_btn2 setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        }
    }
    if (item.productStatus == OrderProductStatesExchangeHandling || item.productStatus == OrderProductStatesReturnHandling) {
        if (item.commentStatus == OrderProductCommentNoComment) {
            _btn0.hidden = true;
            _btn1.hidden = true;
            _btn2.hidden = false;
            
            [_btn2 setTitle:@"处理中" forState:UIControlStateNormal];
            _btn2.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
            [_btn2 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        }
        if (item.commentStatus == OrderProductCommentCommented) {
            _btn0.hidden = true;
            _btn1.hidden = false;
            _btn2.hidden = false;
            
            [_btn1 setTitle:@"处理中" forState:UIControlStateNormal];
            _btn1.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
            [_btn1 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
            
            [_btn2 setTitle:@"查看评价" forState:UIControlStateNormal];
            _btn2.layer.borderColor = [UIColor mainColor].CGColor;
            [_btn2 setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        }
    }
    if (item.productStatus == OrderProductStatesExchangeRefuse || item.productStatus == OrderProductStatesReturnRefuse) {
        _btn0.hidden = true;
        _btn1.hidden = false;
        _btn2.hidden = false;
        
        [_btn1 setTitle:@"审核失败" forState:UIControlStateNormal];
        _btn1.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
        [_btn1 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        
        if (item.commentStatus == OrderProductCommentNoComment) {
            [_btn2 setTitle:@"评价晒单" forState:UIControlStateNormal];
        }
        if (item.commentStatus == OrderProductCommentCommented) {
            [_btn2 setTitle:@"查看评价" forState:UIControlStateNormal];
        }
        _btn2.layer.borderColor = [UIColor mainColor].CGColor;
        [_btn2 setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
    }
    
    if (item.productStatus == OrderProductStatesExchangeFinish || item.productStatus == OrderProductStatesReturnFinish) {
        _btn0.hidden = true;
        _btn1.hidden = false;
        _btn2.hidden = false;
        
        [_btn1 setTitle:item.productStatus == OrderProductStatesExchangeFinish ? @"换货完成" : @"退货完成" forState:UIControlStateNormal];
        _btn1.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
        [_btn1 setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        
        if (item.commentStatus == OrderProductCommentNoComment) {
            [_btn2 setTitle:@"评价晒单" forState:UIControlStateNormal];
        }
        if (item.commentStatus == OrderProductCommentCommented) {
            [_btn2 setTitle:@"查看评价" forState:UIControlStateNormal];
        }
        _btn2.layer.borderColor = [UIColor mainColor].CGColor;
        [_btn2 setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10.0)];
        [_productImgV autoSetDimension:ALDimensionWidth toSize:FitHeight(140.0)];
        [_productImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(140.0)];
        
        [_productName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_productImgV withOffset:FitWith(26.0)];
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_productName autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_productImgV];
        
        [_productSubLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productName];
        [_productSubLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productName withOffset:8];
        
        [_priceLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productName];
        [_priceLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productSubLable withOffset:8];
        
        [_btn0 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(290.0)];
        [_btn0 autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(150.0)];
        [_btn0 autoSetDimension:ALDimensionWidth toSize:FitWith(110.0)];
        [_btn0 autoSetDimension:ALDimensionHeight toSize:FitHeight(50.0)];
        
        [_btn1 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(160.0)];
        [_btn1 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_btn0];
        [_btn1 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_btn0];
        [_btn1 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_btn0];;
        
        [_btn2 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_btn2 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_btn0];
        [_btn2 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_btn0];
        [_btn2 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_btn0];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
