//
//  SiginTipCell.m
//  DuoSet
//
//  Created by fanfans on 2017/2/27.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SiginTipCell.h"

@interface SiginTipCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;

@property (nonatomic,strong) UIImageView *bgView;
@property (nonatomic,strong) UILabel *tipsTitle;
@property (nonatomic,strong) UIView *line;

@end

@implementation SiginTipCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
//        _bgView = [UIImageView newAutoLayoutView];
//        _bgView.contentMode = UIViewContentModeScaleToFill;
//        _bgView.image = [UIImage imageNamed:@"singinTips_bgimg"];
//        [self.contentView addSubview:_bgView];
        
        _tipsTitle = [UILabel newAutoLayoutView];
        _tipsTitle.textColor = [UIColor blackColor];
        _tipsTitle.text = @"今日推荐";
        _tipsTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        [self.contentView addSubview:_tipsTitle];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
//        [_bgView autoPinEdgesToSuperviewMargins];
        
        [_tipsTitle autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_tipsTitle autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(62.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
