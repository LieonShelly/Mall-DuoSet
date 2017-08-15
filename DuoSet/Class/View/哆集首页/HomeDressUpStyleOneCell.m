//
//  HomeDressUpStyleOneCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/10.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "HomeDressUpStyleOneCell.h"

@interface HomeDressUpStyleOneCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) NSMutableArray *imgVArr;
@property(nonatomic,strong) UIImageView *upBigImgV;
@property(nonatomic,strong) UIImageView *upSmallImgV1;
@property(nonatomic,strong) UIImageView *upSmallImgV2;
@property(nonatomic,strong) UIImageView *upSmallImgV3;

@property(nonatomic,strong) UIImageView *downBigImgV;
@property(nonatomic,strong) UIImageView *downSmallImgV1;
@property(nonatomic,strong) UIImageView *downSmallImgV2;
@property(nonatomic,strong) UIImageView *downSmallImgV3;

@end

@implementation HomeDressUpStyleOneCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        
        _upBigImgV = [UIImageView newAutoLayoutView];
        _upSmallImgV1 = [UIImageView newAutoLayoutView];
        _upSmallImgV2 = [UIImageView newAutoLayoutView];
        _upSmallImgV3 = [UIImageView newAutoLayoutView];
        
        _imgVArr = [NSMutableArray array];
        [_imgVArr addObject:_upBigImgV];
        [_imgVArr addObject:_upSmallImgV1];
        [_imgVArr addObject:_upSmallImgV2];
        [_imgVArr addObject:_upSmallImgV3];
        
        _downBigImgV = [UIImageView newAutoLayoutView];
        _downSmallImgV1 = [UIImageView newAutoLayoutView];
        _downSmallImgV2 = [UIImageView newAutoLayoutView];
        _downSmallImgV3 = [UIImageView newAutoLayoutView];
        
        [_imgVArr addObject:_downBigImgV];
        [_imgVArr addObject:_downSmallImgV1];
        [_imgVArr addObject:_downSmallImgV2];
        [_imgVArr addObject:_downSmallImgV3];
        
        for (int i = 0; i < 8; i++) {
            UIImageView *imgV = _imgVArr[i];
//            imgV.image = [UIImage imageNamed:@"替代9"];
            imgV.backgroundColor = [UIColor whiteColor];
            imgV.contentMode = UIViewContentModeScaleAspectFill;
            imgV.layer.masksToBounds = true;
            imgV.userInteractionEnabled = true;
            imgV.tag = i;
            UITapGestureRecognizer*singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
            singleRecognizer.numberOfTapsRequired = 1;
            [imgV addGestureRecognizer:singleRecognizer];
            [self.contentView addSubview:imgV];
        }
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithHomeMainData:(HomeMainData *)item{
    if (item.matchList.count > 0) {
        HomeMatchData *match1 = item.matchList[0];
        [_upBigImgV sd_setImageWithURL:[NSURL URLWithString:match1.picture] placeholderImage:placeholderImage_372_440 options:0];
        [_upSmallImgV1 sd_setImageWithURL:[NSURL URLWithString:match1.productEntityOne.cover] placeholderImage:placeholderImage_702_420 options:0];
        [_upSmallImgV2 sd_setImageWithURL:[NSURL URLWithString:match1.productEntityTwo.cover] placeholderImage:placeholderImage_702_420 options:0];
        [_upSmallImgV3 sd_setImageWithURL:[NSURL URLWithString:match1.productEntityThree.cover] placeholderImage:placeholderImage_702_420 options:0];
    }
    if (item.matchList.count > 1) {
        HomeMatchData *match1 = item.matchList[1];
        [_downBigImgV sd_setImageWithURL:[NSURL URLWithString:match1.picture] placeholderImage:placeholderImage_702_420 options:0];
        [_downSmallImgV1 sd_setImageWithURL:[NSURL URLWithString:match1.productEntityOne.cover] placeholderImage:placeholderImage_702_420 options:0];
        [_downSmallImgV2 sd_setImageWithURL:[NSURL URLWithString:match1.productEntityTwo.cover] placeholderImage:placeholderImage_702_420 options:0];
        [_downSmallImgV3 sd_setImageWithURL:[NSURL URLWithString:match1.productEntityThree.cover] placeholderImage:placeholderImage_702_420 options:0];
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_upBigImgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_upBigImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(20.0)];
        [_upBigImgV autoSetDimension:ALDimensionWidth toSize:FitWith(408.0)];
        [_upBigImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(660.0)];
        
        [_upSmallImgV1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_upBigImgV withOffset:FitWith(12)];
        [_upSmallImgV1 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_upBigImgV];
        [_upSmallImgV1 autoSetDimension:ALDimensionWidth toSize:FitWith(290.0)];
        [_upSmallImgV1 autoSetDimension:ALDimensionHeight toSize:FitHeight(212.0)];
        
        [_upSmallImgV2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_upSmallImgV1];
        [_upSmallImgV2 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_upSmallImgV1];
        [_upSmallImgV2 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_upSmallImgV1];
        [_upSmallImgV2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_upSmallImgV1 withOffset:FitHeight(12.0)];
        
        [_upSmallImgV3 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_upSmallImgV1];
        [_upSmallImgV3 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_upSmallImgV1];
        [_upSmallImgV3 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_upSmallImgV1];
        [_upSmallImgV3 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_upSmallImgV2 withOffset:FitHeight(12.0)];
        
        [_downBigImgV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_upBigImgV withOffset:FitHeight(20.0)];
        [_downBigImgV autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_upBigImgV];
        [_downBigImgV autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_upSmallImgV1];
        [_downBigImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(420.0)];
        
        [_downSmallImgV1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_downBigImgV];
        [_downSmallImgV1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_downBigImgV withOffset:FitHeight(12.0)];
        [_downSmallImgV1 autoSetDimension:ALDimensionWidth toSize:FitWith(229.0)];
        [_downSmallImgV1 autoSetDimension:ALDimensionHeight toSize:FitHeight(260.0)];
        
        [_downSmallImgV2 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_downSmallImgV1];
        [_downSmallImgV2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_downSmallImgV1 withOffset:FitWith(12.0)];
        [_downSmallImgV2 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_downSmallImgV1];
        [_downSmallImgV2 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_downSmallImgV1];
        
        [_downSmallImgV3 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_downSmallImgV1];
        [_downSmallImgV3 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_downSmallImgV2 withOffset:FitWith(12.0)];
        [_downSmallImgV3 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_downSmallImgV1];
        [_downSmallImgV3 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_downSmallImgV1];
        
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
