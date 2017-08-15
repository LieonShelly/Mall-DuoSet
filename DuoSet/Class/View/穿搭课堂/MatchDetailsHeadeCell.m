//
//  MatchDetailsHeadeCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "MatchDetailsHeadeCell.h"

@interface MatchDetailsHeadeCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UILabel *titleName;
@property(nonatomic,strong) UILabel *contentLable;

@end

@implementation MatchDetailsHeadeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _titleName = [UILabel newAutoLayoutView];
        _titleName.text = @"【设计作品】怎么让设计稿变美";
        _titleName.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        _titleName.textAlignment = NSTextAlignmentLeft;
        _titleName.textColor = [UIColor colorFromHex:0x222222];
        [self.contentView addSubview:_titleName];
        
        _contentLable = [UILabel newAutoLayoutView];
        _contentLable.textColor = [UIColor colorFromHex:0x808080];
        _contentLable.font = CUSFONT(14);
        _contentLable.text = @"一段很长的话。一段很长的话。一段很长的话。一段很长的话。一段很长的话。一段很长的话。";
        _contentLable.numberOfLines = 0;
        [self.contentView addSubview:_contentLable];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithTitle:(NSString *)title andContent:(NSString *)content{
    _titleName.text = title;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:CUSFONT(14),
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    
    NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:content attributes:attributes];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,content.length)];
    _contentLable.attributedText = attributedString;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_titleName autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_titleName autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(40.0)];
        
        [_contentLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_titleName];
        [_contentLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleName withOffset:FitHeight(28.0)];
        [_contentLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(20.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
