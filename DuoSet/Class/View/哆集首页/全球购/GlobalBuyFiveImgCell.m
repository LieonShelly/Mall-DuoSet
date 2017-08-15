//
//  GlobalBuyFiveImgCell.m
//  DuoSet
//
//  Created by mac on 2017/1/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "GlobalBuyFiveImgCell.h"
#import "GlobalAreaData.h"

@interface GlobalBuyFiveImgCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIImageView *bigImgV;
@property (nonatomic,strong) UIImageView *imgV1;
@property (nonatomic,strong) UIImageView *imgV2;
@property (nonatomic,strong) UIImageView *imgV3;
@property (nonatomic,strong) UIImageView *imgV4;
@property (nonatomic,strong) NSMutableArray *imVArr;

@end

@implementation GlobalBuyFiveImgCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imVArr = [NSMutableArray array];
        _bigImgV = [UIImageView newAutoLayoutView];
        [_imVArr addObject:_bigImgV];
        
        _imgV1 = [UIImageView newAutoLayoutView];
        [_imVArr addObject:_imgV1];
        
        _imgV2 = [UIImageView newAutoLayoutView];
        [_imVArr addObject:_imgV2];
        
        _imgV3 = [UIImageView newAutoLayoutView];
        [_imVArr addObject:_imgV3];
        
        _imgV4 = [UIImageView newAutoLayoutView];
        [_imVArr addObject:_imgV4];
        
        for (int i = 0; i < _imVArr.count; i++) {
            UIImageView *imgV = _imVArr[i];
            imgV.tag = i;
            imgV.userInteractionEnabled = true;
            UITapGestureRecognizer*singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
            singleRecognizer.numberOfTapsRequired = 1;
            [imgV addGestureRecognizer:singleRecognizer];
            [self.contentView addSubview:imgV];
        }
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithGlobalAreaDataArr:(NSArray *)itemArr{
    for (int i = 0; i < 5; i++) {
        UIImageView *imgV = _imVArr[i];
        if (i > itemArr.count - 1) {
            imgV.hidden = true;
        }else{
            imgV.hidden = false;
            GlobalAreaData *data = itemArr[i];
            [imgV sd_setImageWithURL:[NSURL URLWithString:data.picture] placeholderImage:placeholderImage_702_420 options:0];
        }
    }
}


-(void)SingleTap:(UITapGestureRecognizer *)tap{
    GlobalBuyImgVBlock block = _imgTapHandle;
    if (block) {
        block(tap.view.tag);
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bigImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_bigImgV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_bigImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(15.0)];
        [_bigImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(355.0)];
        
        CGFloat smallImgVW = mainScreenWidth * 0.5 - FitWith(24.0) - FitWith(2.5);
        CGFloat smallImgVH = FitHeight(280.0);
        
        [_imgV1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_bigImgV withOffset:FitHeight(5)];
        [_imgV1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_bigImgV];
        [_imgV1 autoSetDimension:ALDimensionWidth toSize:smallImgVW];
        [_imgV1 autoSetDimension:ALDimensionHeight toSize:smallImgVH];
        
        [_imgV2 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_imgV2 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_imgV1];
        [_imgV2 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_imgV1];
        [_imgV2 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_imgV1];
        
        [_imgV3 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_imgV1];
        [_imgV3 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_imgV1 withOffset:FitHeight(5)];
        [_imgV3 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_imgV1];
        [_imgV3 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_imgV1];
        
        [_imgV4 autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_imgV2];
        [_imgV4 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_imgV3];
        [_imgV4 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_imgV1];
        [_imgV4 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_imgV1];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
