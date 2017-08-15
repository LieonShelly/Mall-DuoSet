//
//  PiazzaDetailsLikeAndClloctionCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaDetailsLikeAndClloctionCell.h"

@interface PiazzaDetailsLikeAndClloctionCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UILabel *timeLable;
@property(nonatomic,strong) UILabel *collectLable;
@property(nonatomic,strong) UILabel *likeLable;
@property(nonatomic,strong) UIView *line;

@end

@implementation PiazzaDetailsLikeAndClloctionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _timeLable = [UILabel newAutoLayoutView];
        _timeLable.textColor = [UIColor colorFromHex:0x808080];
        _timeLable.font = CUSNEwFONT(13);
        [self.contentView addSubview:_timeLable];
        
        _collectLable = [UILabel newAutoLayoutView];
        _collectLable.textColor = [UIColor colorFromHex:0x808080];
        _collectLable.font = CUSNEwFONT(13);
        [self.contentView addSubview:_collectLable];
        
        _likeLable = [UILabel newAutoLayoutView];
        _likeLable.textColor = [UIColor colorFromHex:0x808080];
        _likeLable.font = CUSNEwFONT(13);
        [self.contentView addSubview:_likeLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
    
}

-(void)setupInfoWithPiazzaItemCollectAndLikeData:(PiazzaItemCollectAndLikeData *)item{
    _timeLable.text = item.createTime;
    _collectLable.text = [NSString stringWithFormat:@"%@次收藏",item.collectCount];
    _likeLable.text = [NSString stringWithFormat:@"%@次赞",item.likeCount];
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_timeLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(20.0)];
        [_timeLable autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [_likeLable autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_likeLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(20.0)];
        
        [_collectLable autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_collectLable autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_likeLable withOffset:-FitWith(40.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
