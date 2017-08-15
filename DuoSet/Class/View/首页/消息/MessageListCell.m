//
//  MessageListCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/29.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "MessageListCell.h"

@interface MessageListCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UILabel *timeLable;
@property (nonatomic,strong) UILabel *subTitleLable;

@end

@implementation MessageListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.borderColor = [UIColor colorFromHex:0xe5e5e5].CGColor;
        _bgView.layer.borderWidth = 1;
        _bgView.layer.cornerRadius = 3;
        [self.contentView addSubview:_bgView];
        
        _titleLable = [UILabel newAutoLayoutView];
        _titleLable.textAlignment = NSTextAlignmentLeft;
        _titleLable.font = CUSFONT(13);
        _titleLable.numberOfLines = 0;
        _titleLable.textColor = [UIColor colorFromHex:0x222222];
        [_bgView addSubview:_titleLable];
        
        _timeLable = [UILabel newAutoLayoutView];
        _timeLable.textAlignment = NSTextAlignmentRight;
        _timeLable.font = CUSFONT(13);
        _timeLable.numberOfLines = 0;
        _timeLable.textColor = [UIColor colorFromHex:0x808080];
        [_bgView addSubview:_timeLable];
        
        _subTitleLable = [UILabel newAutoLayoutView];
        _subTitleLable.textAlignment = NSTextAlignmentLeft;
        _subTitleLable.font = CUSFONT(13);
        _subTitleLable.numberOfLines = 0;
        _subTitleLable.textColor = [UIColor colorFromHex:0x808080];
        [_bgView addSubview:_subTitleLable];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithSystemMessageModel:(SystemMessageModel *)item{
    _titleLable.text = item.title;
    _subTitleLable.text = item.content;
    _timeLable.text = item.createTime;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [_titleLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_titleLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_titleLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
        
        [_subTitleLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_subTitleLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_subTitleLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleLable withOffset:FitHeight(10.0)];
        
        [_timeLable autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(20.0)];
        [_timeLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
