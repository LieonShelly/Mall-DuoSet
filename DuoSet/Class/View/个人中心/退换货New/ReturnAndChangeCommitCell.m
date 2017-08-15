//
//  ReturnAndChangeCommitCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ReturnAndChangeCommitCell.h"

@interface ReturnAndChangeCommitCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *tipLable;
@property (nonatomic,strong) UIButton *commitBtn;
@property (nonatomic,strong) UIView *line;

@end

@implementation ReturnAndChangeCommitCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        
        _tipLable = [UILabel newAutoLayoutView];
        _tipLable.textColor = [UIColor colorFromHex:0x808080];
        _tipLable.font = CUSNEwFONT(14);
        _tipLable.text = @"提交申请后，售后专员可能与您电话沟通，请保持手机畅通";
        _tipLable.textAlignment = NSTextAlignmentCenter;
        [_bgView addSubview:_tipLable];
        
        _commitBtn = [UIButton newAutoLayoutView];
        [_commitBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_normal"] forState:UIControlStateNormal];
        [_commitBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_highlighted"] forState:UIControlStateHighlighted];
        _commitBtn.titleLabel.font = CUSFONT(16);
        [_commitBtn setTitle:@"提 交" forState:UIControlStateNormal];
        [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_commitBtn];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)commitBtnAction{
    CommitBlock block = _commitHandle;
    if (block) {
        block();
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [_tipLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(26.0)];
        [_tipLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(26.0)];
        [_tipLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        
        [_commitBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(26.0)];
        [_commitBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(26.0)];
        [_commitBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(88.0)];
        [_commitBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(16.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
