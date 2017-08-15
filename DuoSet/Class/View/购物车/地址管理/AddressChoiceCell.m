//
//  AddressChoiceCell.m
//  DuoSet
//
//  Created by fanfans on 2017/2/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "AddressChoiceCell.h"

@interface AddressChoiceCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIButton *markBtn;

@end

@implementation AddressChoiceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _tipsLable = [UILabel newAutoLayoutView];
        _tipsLable.textColor = [UIColor colorFromHex:0x222222];
        _tipsLable.textAlignment = NSTextAlignmentLeft;
        _tipsLable.font = CUSFONT(14);
        [self.contentView addSubview:_tipsLable];
        
        _arrowImgV = [UIImageView newAutoLayoutView];
        _arrowImgV.contentMode = UIViewContentModeRight;
        _arrowImgV.image = [UIImage imageNamed:@"right_arrow"];
        [self.contentView addSubview:_arrowImgV];
        
        _rightSubLable = [UITextField newAutoLayoutView];
        _rightSubLable.textColor = [UIColor colorFromHex:0x222222];
        _rightSubLable.font = CUSFONT(13);
        _rightSubLable.textAlignment = NSTextAlignmentLeft;
        _rightSubLable.userInteractionEnabled = false;
        [self.contentView addSubview:_rightSubLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
        [self.contentView addSubview:_line];
        
        _markBtn = [UIButton newAutoLayoutView];
        [_markBtn addTarget:self action:@selector(cellTapAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_markBtn];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)cellTapAction{
    CellTapBlock block = _cellTapHandle;
    if (block) {
        block();
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        
        [_arrowImgV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_arrowImgV autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_arrowImgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        
        [_rightSubLable autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_arrowImgV withOffset:-FitWith(10)];
        [_rightSubLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_rightSubLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_rightSubLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(180.0)];
        
        [_line autoSetDimension:ALDimensionHeight toSize:1];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        [_markBtn autoPinEdgesToSuperviewEdges];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
