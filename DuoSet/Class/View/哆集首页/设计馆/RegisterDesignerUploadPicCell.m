//
//  RegisterDesignerUploadPicCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "RegisterDesignerUploadPicCell.h"

@interface RegisterDesignerUploadPicCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UILabel *leftLable;
@property(nonatomic,strong) UILabel *rightLable;
@property(nonatomic,strong) UIView *line;

@end

@implementation RegisterDesignerUploadPicCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _leftImgV = [UIImageView newAutoLayoutView];
        _leftImgV.image = [UIImage imageNamed:@"upload_pic_img"];
        _leftImgV.tag = 0;
        _leftImgV.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgViewTap:)];
        [_leftImgV addGestureRecognizer:tap];
        [self.contentView addSubview:_leftImgV];
        
        _leftDeletedBtn = [UIButton newAutoLayoutView];
        _leftDeletedBtn.contentMode = UIViewContentModeCenter;
        _leftDeletedBtn.tag = 0;
        [_leftDeletedBtn setImage:[UIImage imageNamed:@"pulic_pic_deleted"] forState:UIControlStateNormal];
        [_leftDeletedBtn addTarget:self action:@selector(deletedBtnHandle:) forControlEvents:UIControlEventTouchUpInside];
        _leftDeletedBtn.hidden = true;
        [_leftImgV addSubview:_leftDeletedBtn];
        
        _rightImgV = [UIImageView newAutoLayoutView];
        _rightImgV.image = [UIImage imageNamed:@"upload_pic_img"];
        _rightImgV.tag = 1;
        _rightImgV.userInteractionEnabled = true;
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgViewTap:)];
        [_rightImgV addGestureRecognizer:tap2];
        [self.contentView addSubview:_rightImgV];
        
        _rightDeletedBtn = [UIButton newAutoLayoutView];
        _rightDeletedBtn.contentMode = UIViewContentModeCenter;
        _rightDeletedBtn.tag = 1;
        [_rightDeletedBtn setImage:[UIImage imageNamed:@"pulic_pic_deleted"] forState:UIControlStateNormal];
        [_rightDeletedBtn addTarget:self action:@selector(deletedBtnHandle:) forControlEvents:UIControlEventTouchUpInside];
        _rightDeletedBtn.hidden = true;
        [_rightImgV addSubview:_rightDeletedBtn];
        
        _leftLable = [UILabel newAutoLayoutView];
        _leftLable.text = @"身份证正面";
        _leftLable.textColor = [UIColor colorFromHex:0x222222];
        _leftLable.font = CUSFONT(12);
        _leftLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_leftLable];
        
        _rightLable = [UILabel newAutoLayoutView];
        _rightLable.text = @"身份证背面";
        _rightLable.textColor = [UIColor colorFromHex:0x222222];
        _rightLable.font = CUSFONT(12);
        _rightLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_rightLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)deletedBtnHandle:(UIButton *)btn{
    ImgVDeletedBlock block = _deletedHandle;
    if (block) {
        block(btn.tag);
    }
}

-(void)imgViewTap:(UITapGestureRecognizer *)tap{
    ImgVTapBlock block = _imgVTapHandle;
    if (block) {
        block(tap.view.tag);
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_leftImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_leftImgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_leftImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(190.0)];
        [_leftImgV autoSetDimension:ALDimensionWidth toSize:FitHeight(190.0)];
        
        [_leftDeletedBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_leftDeletedBtn autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_leftDeletedBtn autoSetDimension:ALDimensionHeight toSize:FitWith(50.0)];
        [_leftDeletedBtn autoSetDimension:ALDimensionWidth toSize:FitWith(50.0)];
        
        [_leftLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_leftImgV];
        [_leftLable autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_leftImgV];
        [_leftLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_leftImgV withOffset:FitHeight(10)];
        
        [_rightImgV autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_leftImgV withOffset:FitWith(26.0)];
        [_rightImgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_rightImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(190.0)];
        [_rightImgV autoSetDimension:ALDimensionWidth toSize:FitHeight(190.0)];
        
        [_rightDeletedBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_rightDeletedBtn autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_rightDeletedBtn autoSetDimension:ALDimensionHeight toSize:FitWith(50.0)];
        [_rightDeletedBtn autoSetDimension:ALDimensionWidth toSize:FitWith(50.0)];
        
        [_rightLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_rightImgV];
        [_rightLable autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_rightImgV];
        [_rightLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_rightImgV withOffset:FitHeight(10)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
