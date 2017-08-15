//
//  LogisticInfoCell.m
//  DuoSet
//
//  Created by mac on 2017/1/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "LogisticInfoCell.h"

@interface LogisticInfoCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *circleView;
@property (nonatomic,strong) UILabel *infoLable;
@property (nonatomic,strong) UILabel *dateLable;
@property (nonatomic,strong) UIView *cuttingLine;

@end

@implementation LogisticInfoCell- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _upLine = [UIView newAutoLayoutView];
        _upLine.backgroundColor = [UIColor colorFromHex:0xe8e8e8];
        [self.contentView addSubview:_upLine];
        
        _circleView = [UIView newAutoLayoutView];
        _circleView.backgroundColor = [UIColor colorFromHex:0xe8e8e8];
        _circleView.layer.cornerRadius = FitWith(20);
        _circleView.layer.masksToBounds = true;
        [self.contentView addSubview:_circleView];
        
        _downLine = [UIView newAutoLayoutView];
        _downLine.backgroundColor = [UIColor colorFromHex:0xe8e8e8];
        [self.contentView addSubview:_downLine];
        
        _infoLable = [UILabel newAutoLayoutView];
        _infoLable.textColor = [UIColor colorFromHex:0x666666];
        _infoLable.font = CUSFONT(11);
        _infoLable.textAlignment = NSTextAlignmentLeft;
        _infoLable.numberOfLines = 0;
        [self.contentView addSubview:_infoLable];
        
        _dateLable = [UILabel newAutoLayoutView];
        _dateLable.textColor = [UIColor colorFromHex:0x999999];
        _dateLable.font = CUSFONT(11);
        _dateLable.textAlignment = NSTextAlignmentLeft;
        _dateLable.numberOfLines = 1;
        [self.contentView addSubview:_dateLable];
        
        _cuttingLine = [UIView newAutoLayoutView];
        _cuttingLine.backgroundColor = [UIColor colorFromHex:0xe8e8e8];
//        _cuttingLine.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_cuttingLine];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithReturnAndChangeDetailData:(ReturnAndChangeDetailData *)item{
    _infoLable.text = item.message;
    _dateLable.text = item.createTime;
}

-(void)setupInfoWithTraceData:(TraceData *)item{
    _infoLable.text = item.acceptStation;
    _dateLable.text = item.acceptTime;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_upLine autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_upLine autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(40.0)];
        [_upLine autoSetDimension:ALDimensionWidth toSize:1];
        [_upLine autoSetDimension:ALDimensionHeight toSize:FitHeight(30.0)];
        
        [_circleView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_circleView autoSetDimension:ALDimensionWidth toSize:FitWith(20.0)];
        [_circleView autoSetDimension:ALDimensionHeight toSize:FitWith(20.0)];
        [_circleView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_upLine];
        
        [_downLine autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_circleView];
        [_downLine autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_downLine autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_upLine];
        [_downLine autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_upLine];
        
        [_infoLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(80.0)];
        [_infoLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        [_infoLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        
        [_dateLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_infoLable withOffset:5];
        [_dateLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_infoLable];
        
        [_cuttingLine autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_infoLable];
        [_cuttingLine autoSetDimension:ALDimensionHeight toSize:0.5];
        [_cuttingLine autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_cuttingLine autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
