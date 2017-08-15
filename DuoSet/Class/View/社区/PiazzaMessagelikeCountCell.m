//
//  PiazzaMessagelikeCountCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/10.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaMessagelikeCountCell.h"

@interface PiazzaMessagelikeCountCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UILabel *likeCountLable;
@property(nonatomic,strong) NSMutableArray *likeUserArr;

@end

@implementation PiazzaMessagelikeCountCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        
        _likeCountLable = [UILabel newAutoLayoutView];
        _likeCountLable.textAlignment = NSTextAlignmentLeft;
        _likeCountLable.font = CUSFONT(12);
        _likeCountLable.textColor = [UIColor colorFromHex:0x666666];
        _likeCountLable.text = @"";
        [self.contentView addSubview:_likeCountLable];
        
        _likeUserArr = [NSMutableArray array];
        for (int i = 0; i < 4; i++) {
            UIImageView *avatar = [UIImageView newAutoLayoutView];
            avatar.layer.cornerRadius = FitWith(48.0) *0.5;
            avatar.layer.masksToBounds = true;
            [_likeUserArr addObject:avatar];
            [self.contentView addSubview:avatar];
        }
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithPiazzaData:(PiazzaData *)item{
    NSString *text = [NSString stringWithFormat:@"共有%@人喜欢",item.likeCount];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeString addAttribute:NSFontAttributeName value:CUSFONT(12) range:NSMakeRange(2, item.likeCount.length)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2, item.likeCount.length)];
    _likeCountLable.attributedText = attributeString;
    NSArray *newArr = [NSArray array];
    if (item.communityLikeReponses.count > 3) {
        NSMutableArray *arr = [NSMutableArray arrayWithArray:item.communityLikeReponses];
        newArr = [arr subarrayWithRange:NSMakeRange(0, 3)];
    }else{
        newArr = item.communityLikeReponses;
    }
    for (int i = 0; i < 4; i++) {
        UIImageView *imgV = _likeUserArr[i];
        if (newArr.count == 0) {
            imgV.hidden = true;
            continue;
        }
        if (i < newArr.count) {
            imgV.hidden = false;
            PiazzaUserData *user = newArr[i];
            [imgV sd_setImageWithURL:[NSURL URLWithString:user.avastar] placeholderImage:placeholderImage_avatar options:0];
        }else if (i == newArr.count){
            imgV.image = [UIImage imageNamed:@"piazza_more_avatar"];
            continue;
        }else{
            imgV.hidden = true;
            continue;
        }
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_likeCountLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_likeCountLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_likeCountLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(23.0)];
        
        for (int i = 0; i < 4; i++) {
            UIImageView *imgV = _likeUserArr[i];
            [imgV autoAlignAxisToSuperviewMarginAxis:ALAxisHorizontal];
            [imgV autoSetDimension:ALDimensionWidth toSize:FitWith(48.0)];
            [imgV autoSetDimension:ALDimensionHeight toSize:FitWith(48.0)];
            [imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(510.0) + (FitWith(48.0) + 2) * i];
        }
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
