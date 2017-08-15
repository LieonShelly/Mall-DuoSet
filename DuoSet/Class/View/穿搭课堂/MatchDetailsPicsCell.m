//
//  MatchDetailsPicsCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "MatchDetailsPicsCell.h"

@interface MatchDetailsPicsCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *titleImgV;
@property (nonatomic,strong) UIImageView *coverImgV;
@property (nonatomic,strong) NSMutableArray *coverImgVArr;
@property (nonatomic,assign) CGFloat imgW;
@property (nonatomic,assign) CGFloat imgH;

@end

@implementation MatchDetailsPicsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        
        _coverImgV = [UIImageView newAutoLayoutView];
        _coverImgV.contentMode = UIViewContentModeScaleAspectFill;
        _coverImgV.layer.masksToBounds = true;
        _coverImgV.tag = 0;
        _coverImgV.userInteractionEnabled = true;
        UITapGestureRecognizer*singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
        singleRecognizer.numberOfTapsRequired = 1;
        [_coverImgV addGestureRecognizer:singleRecognizer];
        [_bgView addSubview:_coverImgV];
        
        _coverImgVArr = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            UIImageView *imgV = [UIImageView newAutoLayoutView];
            imgV.backgroundColor = [UIColor whiteColor];
            imgV.contentMode = UIViewContentModeScaleAspectFit;
            imgV.layer.cornerRadius = 4;
            imgV.layer.masksToBounds = true;
            imgV.tag = i + 1;
            imgV.userInteractionEnabled = true;
            UITapGestureRecognizer*singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
            singleRecognizer.numberOfTapsRequired = 1;
            [imgV addGestureRecognizer:singleRecognizer];
            [_coverImgV addSubview:imgV];
            [_coverImgVArr addObject:imgV];
        }
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupIndoWithMatchDetailsData:(MatchDetailsData *)item{
    [_coverImgV sd_setImageWithURL:[NSURL URLWithString:item.picture] placeholderImage:nil options:0];
    if (item.productEntityOne) {
        UIImageView *imgV = _coverImgVArr[0];
        [imgV sd_setImageWithURL:[NSURL URLWithString:item.productEntityOne.cover] placeholderImage:nil options:0];
    }
    if (item.productEntityTwo) {
        UIImageView *imgV = _coverImgVArr[1];
        [imgV sd_setImageWithURL:[NSURL URLWithString:item.productEntityTwo.cover] placeholderImage:nil options:0];
    }
    if (item.productEntityThree) {
        UIImageView *imgV = _coverImgVArr[2];
        [imgV sd_setImageWithURL:[NSURL URLWithString:item.productEntityThree.cover] placeholderImage:nil options:0];
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgesToSuperviewEdges];
        
        [_coverImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(16.0)];
        [_coverImgV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(16.0)];
        [_coverImgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_coverImgV autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        CGFloat imgW = (mainScreenWidth - FitWith(52.0) - FitWith(24)) / 3;
        for (int i = 0 ; i < 3; i++) {
            UIImageView *imgV = _coverImgVArr[i];
            [imgV autoSetDimension:ALDimensionHeight toSize:imgW];
            [imgV autoSetDimension:ALDimensionWidth toSize:imgW];
            [imgV autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(10.0)];
            [imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(10.0) + (imgW + FitWith(12.0)) * i];
        }
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

-(void)SingleTap:(UIGestureRecognizer *)tap{
    DressUpSingleItemBlock block = _dressupHandle;
    if (block) {
        block(tap.view.tag);
    }
}
@end
