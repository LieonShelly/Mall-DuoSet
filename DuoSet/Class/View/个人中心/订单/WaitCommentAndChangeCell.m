//
//  WaitCommentAndChangeCell.m
//  DuoSet
//
//  Created by fanfans on 1/4/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import "WaitCommentAndChangeCell.h"
#import "WaitCommentAndChangeProductView.h"

@interface WaitCommentAndChangeCell()

@property(nonatomic,strong) DuojiOrderData *order;
@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UILabel *orderNumLable;
@property(nonatomic,strong) UILabel *orderTimeLable;
@property(nonatomic,strong) UILabel *orderStatusLable;
@property(nonatomic,strong) UIView *line;

@property(nonatomic,strong) NSMutableArray *productViews;
@property(nonatomic,strong) WaitCommentAndChangeProductView *ProductV;
@property(nonatomic,strong) DuojiOrderProductData *productItem;

@end

@implementation WaitCommentAndChangeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDuoSetOrder:(DuojiOrderData *)order{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _order = order;
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor colorFromHex:0xffffff];
        [self.contentView addSubview:_bgView];
        
        _orderNumLable = [UILabel newAutoLayoutView];
        _orderNumLable.text = @"订单编号:1234567890";
        _orderNumLable.textColor = [UIColor colorFromHex:0x222222];
        _orderNumLable.textAlignment = NSTextAlignmentLeft;
        _orderNumLable.font = CUSFONT(12);
        [_bgView addSubview:_orderNumLable];
        
        _orderTimeLable = [UILabel newAutoLayoutView];
        _orderTimeLable.text = @"下单日期:2017-01-01 09:35:10";
        _orderTimeLable.textColor = [UIColor colorFromHex:0x222222];
        _orderTimeLable.textAlignment = NSTextAlignmentLeft;
        _orderTimeLable.font = CUSFONT(12);
        [_bgView addSubview:_orderTimeLable];
        
        _orderStatusLable = [UILabel newAutoLayoutView];
        _orderStatusLable.textColor = [UIColor mainColor];
        _orderStatusLable.text = @"完成";
        _orderStatusLable.textAlignment = NSTextAlignmentRight;
        _orderStatusLable.font = CUSFONT(12);
        [_bgView addSubview:_orderStatusLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe6e6e6];
        [_bgView addSubview:_line];
        
        _ProductV  = [WaitCommentAndChangeProductView new];
        __weak typeof(self) weakSelf = self;
        _ProductV.btnActionHandle = ^(NSInteger index){
            CellBtnActionsBlock block = weakSelf.cellBtnActionHandle;
            if (block) {
                block(index);
            }
        };
        [_bgView addSubview:_ProductV];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithReturnAndChangeData:(ReturnAndChangeData *)item{
    _orderNumLable.text = [NSString stringWithFormat:@"订单编号: %@",item.no];
    _orderTimeLable.text = [NSString stringWithFormat:@"下单日期: %@",item.createTime];
    _orderStatusLable.text = item.statusName;
    [_ProductV setupInfoReturnAndChangeData:item];
}

-(void)setupInfoWithDuoSetOrder:(DuojiOrderData *)item andDuojiOrderProductData:(DuojiOrderProductData *)productInfo{
    _productItem = productInfo;
    _orderNumLable.text = [NSString stringWithFormat:@"订单编号: %@",item.no];
    _orderTimeLable.text = [NSString stringWithFormat:@"下单日期: %@",item.createTime];
    _orderStatusLable.text = productInfo.statusName;
    [_ProductV setupInfoWithOrderProduct:productInfo];
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [_orderNumLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_orderNumLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        
        [_orderTimeLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_orderNumLable];
        [_orderTimeLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_orderNumLable withOffset:FitHeight(15.0)];
        
        [_orderStatusLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        [_orderStatusLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(20.0)];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(130.0)];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        [_ProductV autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_ProductV autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_ProductV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_line];
        [_ProductV autoSetDimension:ALDimensionHeight toSize:FitHeight(235.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
