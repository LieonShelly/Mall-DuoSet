//
//  OrderCancelResionCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/15.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OrderCancelResionCell.h"

@interface OrderCancelResionCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIButton *seletcedBtn;
@property (nonatomic,strong) UILabel *tipLable;

@end

@implementation OrderCancelResionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xffffff];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        
        _seletcedBtn = [UIButton newAutoLayoutView];
        [_seletcedBtn setImage:[UIImage imageNamed:@"choose_default"] forState:UIControlStateNormal];
        [_seletcedBtn setImage:[UIImage imageNamed:@"choose_selected"] forState:UIControlStateSelected];
        _seletcedBtn.userInteractionEnabled = false;
        [self.contentView addSubview:_seletcedBtn];
        
        _tipLable = [UILabel newAutoLayoutView];
        _tipLable.textColor = [UIColor colorFromHex:0x212121];
        _tipLable.font = CUSNEwFONT(15);
        _tipLable.numberOfLines = 0 ;
        [_bgView addSubview:_tipLable];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithCancelResionData:(CancelResionData *)item{
    _seletcedBtn.selected = item.isSeletced;
    _tipLable.text = item.text;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [_seletcedBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_seletcedBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10.0)];
        [_seletcedBtn autoSetDimension:ALDimensionWidth toSize:FitWith(40.0)];
        [_seletcedBtn autoSetDimension:ALDimensionHeight toSize:FitWith(40.0)];
        
        [_tipLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_seletcedBtn withOffset:FitWith(10.0)];
        [_tipLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_tipLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(15.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
