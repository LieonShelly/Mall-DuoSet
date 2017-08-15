//
//  NoPassProductCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/21.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "NoPassProductCell.h"

@interface NoPassProductCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *itemImgV;
@property(nonatomic,strong) UILabel *itemName;
@property(nonatomic,strong) UILabel *noPasslable;
@property(nonatomic,strong) UILabel *noPassReson;
@property(nonatomic,strong) UIButton *editBtn;
@property(nonatomic,strong) UIView *line;

@end

@implementation NoPassProductCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _itemImgV = [UIImageView newAutoLayoutView];
        [self.contentView addSubview:_itemImgV];
        
        _itemName = [UILabel newAutoLayoutView];
        _itemName.textColor = [UIColor colorFromHex:0x222222];
        _itemName.font = CUSFONT(14);
        _itemName.text = @"作品名字作品名字";
        _itemName.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_itemName];
        
        _noPasslable = [UILabel newAutoLayoutView];
        _noPasslable.textColor = [UIColor colorFromHex:0x222222];
        _noPasslable.font = CUSFONT(14);
        _noPasslable.text = @"被驳回原因";
        _noPasslable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_noPasslable];
        
        _noPassReson = [UILabel newAutoLayoutView];
        _noPassReson.textColor = [UIColor colorFromHex:0x808080];
        _noPassReson.font = CUSFONT(12);
        _noPassReson.text = @"被驳回原因被驳回原因被驳回原因被驳回原因被驳回原因被驳回原因被驳回原因被驳回原因";
        _noPassReson.numberOfLines = 1;
        _noPassReson.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_noPassReson];
        
        _editBtn = [UIButton newAutoLayoutView];
        _editBtn.backgroundColor = [UIColor mainColor];
        _editBtn.titleLabel.font = CUSFONT(12);
        _editBtn.layer.masksToBounds = true;
        _editBtn.layer.cornerRadius = 3;
        [_editBtn setTitle:@"修改" forState:UIControlStateNormal];
        [_editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _editBtn.userInteractionEnabled = false;
        [self.contentView addSubview:_editBtn];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithNoPassProductData:(NoPassProductData *)item{
    [_itemImgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImage_226_256 options:0];
    _itemName.text = item.name;
    _noPassReson.text = item.reason;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_itemImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_itemImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10.0)];
        [_itemImgV autoSetDimension:ALDimensionWidth toSize:FitHeight(170.0)];
        [_itemImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(170.0)];
        
        [_itemName autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(220.0)];
        [_itemName autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_itemImgV withOffset:FitHeight(10.0)];
        [_itemName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(180.0)];
        
        [_noPasslable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_itemName];
        [_noPasslable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_itemName withOffset:FitHeight(10.0)];
        
        [_noPassReson autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_itemName];
        [_noPassReson autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_noPasslable withOffset:FitHeight(10.0)];
        [_noPassReson autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        
        [_editBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_editBtn autoSetDimension:ALDimensionWidth toSize:FitWith(120.0)];
        [_editBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(54.0)];
        [_editBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
