//
//  ShopCartNoLoginCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ShopCartNoLoginCell.h"

@interface ShopCartNoLoginCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIImageView *noLoginImgV;
@property (nonatomic,strong) UILabel *tipsLable;
@property (nonatomic,strong) UIButton *actionBtn;

@end

@implementation ShopCartNoLoginCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _noLoginImgV = [UIImageView newAutoLayoutView];
        _noLoginImgV.image = [UIImage imageNamed:@"defeated_no_remind"];
        [self.contentView addSubview:_noLoginImgV];
        
        _tipsLable = [UILabel newAutoLayoutView];
        _tipsLable.font = [UIFont systemFontOfSize:12];
        _tipsLable.textColor = [UIColor colorFromHex:0x808080];
        _tipsLable.text = @"亲，您还没登录哦";
        [self.contentView addSubview:_tipsLable];
        
        _actionBtn = [UIButton newAutoLayoutView];
        _actionBtn.backgroundColor = [UIColor mainColor];
        _actionBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _actionBtn.layer.cornerRadius = 3;
        _actionBtn.layer.masksToBounds = true;
        [_actionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_actionBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
        [_actionBtn setTitle:@"去登录" forState:UIControlStateNormal];
        [self.contentView addSubview:_actionBtn];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)loginAction{
    LoginActionBlock block = _loginHandle;
    if (block) {
        block();
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_noLoginImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(200)];
        [_noLoginImgV autoSetDimension:ALDimensionWidth toSize:FitWith(116)];
        [_noLoginImgV autoSetDimension:ALDimensionHeight toSize:FitWith(130)];
        [_noLoginImgV autoAlignAxisToSuperviewMarginAxis:ALAxisHorizontal];
        
        [_tipsLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_noLoginImgV withOffset:20];
        [_tipsLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_noLoginImgV withOffset:12];
        
        [_actionBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_tipsLable withOffset:11];
        [_actionBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_tipsLable withOffset:20];
        [_actionBtn autoSetDimension:ALDimensionWidth toSize:50];
        [_actionBtn autoSetDimension:ALDimensionHeight toSize:20];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
