//
//  QualificationRegistPicCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "QualificationRegistPicCell.h"

@interface QualificationRegistPicCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UILabel *tipLable;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) UILabel *subTitle;

@end

@implementation QualificationRegistPicCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _tipLable = [UILabel newAutoLayoutView];
        _tipLable.text = @"上传资质";
        _tipLable.textAlignment = NSTextAlignmentLeft;
        _tipLable.font = CUSFONT(12);
        _tipLable.textColor = [UIColor colorFromHex:0x222222];
        [self.contentView addSubview:_tipLable];
        
        _picView = [UIImageView newAutoLayoutView];
        _picView.image = [UIImage imageNamed:@"upload_pic_img"];
        _picView.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigPic)];
        [_picView addGestureRecognizer:tap];
        [self.contentView addSubview:_picView];
        
        _deletedBtn = [UIButton newAutoLayoutView];
        _deletedBtn.contentMode = UIViewContentModeCenter;
        [_deletedBtn setImage:[UIImage imageNamed:@"pulic_pic_deleted"] forState:UIControlStateNormal];
        [_deletedBtn addTarget:self action:@selector(deletedBtnHandle) forControlEvents:UIControlEventTouchUpInside];
        [_picView addSubview:_deletedBtn];
        
        _subTitle = [UILabel newAutoLayoutView];
        _subTitle.text = @"委托证书";
        _subTitle.textAlignment = NSTextAlignmentCenter;
        _subTitle.font = CUSFONT(10);
        _subTitle.textColor = [UIColor colorFromHex:0x222222];
        [self.contentView addSubview:_subTitle];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)showBigPic{
    QualificationRegistPicBlock block = _showbigPicHandle;
    if (block) {
        block();
    }
}

-(void)deletedBtnHandle{
    QualificationRegistDeletedBlock block = _deletedPicHandle;
    if (block) {
        block();
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tipLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_tipLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
        
        [_picView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_tipLable];
        [_picView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_tipLable withOffset:FitHeight(20.0)];
        [_picView autoSetDimension:ALDimensionHeight toSize:FitHeight(190.0)];
        [_picView autoSetDimension:ALDimensionWidth toSize:FitHeight(190.0)];
        
        [_deletedBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_deletedBtn autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_deletedBtn autoSetDimension:ALDimensionHeight toSize:FitWith(50.0)];
        [_deletedBtn autoSetDimension:ALDimensionWidth toSize:FitWith(50.0)];
        
        [_subTitle autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_picView withOffset:FitHeight(20)];
        [_subTitle autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_picView];
        [_subTitle autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_picView];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
