//
//  CouponCell.m
//  DuoSet
//
//  Created by fanfans on 1/3/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import "CouponCell.h"

@interface CouponCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *imgV;
@property (nonatomic,strong) UILabel *titleName;
@property (nonatomic,strong) UILabel *subTitleName;
@property (nonatomic,strong) UILabel *dateLable;
@property (nonatomic,strong) UIButton *goUseBtn;

@end

@implementation CouponCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor colorFromHex:0xffffff];
        [self.contentView addSubview:_bgView];
        
        _imgV = [UIImageView newAutoLayoutView];
        _imgV.contentMode = UIViewContentModeScaleAspectFill;
        _imgV.layer.masksToBounds = true;
        [_bgView addSubview:_imgV];
        
        _titleName = [UILabel newAutoLayoutView];
        _titleName.textColor = [UIColor colorFromHex:0x333333];
        _titleName.textAlignment = NSTextAlignmentLeft;
        _titleName.font = CUSFONT(12);
        _titleName.numberOfLines = 2;
        _titleName.text = @"满100减20";
        [_bgView addSubview:_titleName];
        
        _subTitleName = [UILabel newAutoLayoutView];
        _subTitleName.textColor = [UIColor colorFromHex:0x666666];
        _subTitleName.textAlignment = NSTextAlignmentLeft;
        _subTitleName.font = CUSFONT(11);
        _subTitleName.numberOfLines = 1;
        _subTitleName.text = @"满100减20";
        [_bgView addSubview:_subTitleName];
        
        _dateLable = [UILabel newAutoLayoutView];
        _dateLable.textColor = [UIColor colorFromHex:0x999999];
        _dateLable.textAlignment = NSTextAlignmentLeft;
        _dateLable.font = CUSFONT(10);
        _dateLable.numberOfLines = 1;
        _dateLable.text = @"2016-11-11 00:00 - 2017-01-01 23:59";
        [_bgView addSubview:_dateLable];
        
        _goUseBtn = [UIButton newAutoLayoutView];
        [_goUseBtn setTitle:@"立即使用" forState:UIControlStateNormal];
        _goUseBtn.titleLabel.font = CUSFONT(8);
        [_goUseBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        _goUseBtn.layer.cornerRadius = 1;
        _goUseBtn.layer.borderColor = [UIColor mainColor].CGColor;
        _goUseBtn.layer.borderWidth = 1;
        _goUseBtn.layer.masksToBounds = true;
        [_goUseBtn addTarget:self action:@selector(goUserButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_goUseBtn];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)goUserButtonAction{
    choiceBtnActionBlock block = _choiceHandle;
    if (block) {
        block();
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(20.0)];
        
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(20.0)];
        [_imgV autoSetDimension:ALDimensionWidth toSize:FitWith(125.0)];
        
        [_titleName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_imgV withOffset:FitWith(30.0)];
        [_titleName autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_titleName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        
        [_subTitleName autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleName withOffset:FitHeight(20.0)];
        [_subTitleName autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_titleName];
        [_subTitleName autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_titleName];
        
        [_dateLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_subTitleName withOffset:FitHeight(20.0)];
        [_dateLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_subTitleName];
        [_dateLable autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_subTitleName];
        
        [_goUseBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(60.0)];
        [_goUseBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_goUseBtn autoSetDimension:ALDimensionWidth toSize:FitWith(100.0)];
        [_goUseBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(40.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

-(void)setupInfoWithYouhuiJuanModel:(YouhuiJuanModel *)item{
    [_imgV sd_setImageWithURL:[NSURL URLWithString:item.img] placeholderImage:placeholderImage_226_256 options:0];
    _titleName.text = item.name;
    _subTitleName.text = [NSString stringWithFormat:@"满%@元减%@元",item.doorsill,item.price];
    _dateLable.text = [NSString stringWithFormat:@"%@ - %@",item.createDateStr,item.endDateStr];
}


@end
