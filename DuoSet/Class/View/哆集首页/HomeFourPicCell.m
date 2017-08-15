//
//  HomeFourPicCell.m
//  DuoSet
//
//  Created by mac on 2017/1/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "HomeFourPicCell.h"

@interface HomeFourPicCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) NSMutableArray *imgVArr;
@property(nonatomic,strong) UIImageView *ImgV1;
@property(nonatomic,strong) UIImageView *ImgV2;
@property(nonatomic,strong) UIImageView *ImgV3;
@property(nonatomic,strong) UIImageView *ImgV4;

@end

@implementation HomeFourPicCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        
        _ImgV1 = [UIImageView newAutoLayoutView];
        _ImgV2 = [UIImageView newAutoLayoutView];
        _ImgV3 = [UIImageView newAutoLayoutView];
        _ImgV4 = [UIImageView newAutoLayoutView];
        
        _imgVArr = [NSMutableArray array];
        [_imgVArr addObject:_ImgV1];
        [_imgVArr addObject:_ImgV2];
        [_imgVArr addObject:_ImgV3];
        [_imgVArr addObject:_ImgV4];
        
        for (int i = 0; i < 4; i++) {
            UIImageView *imgV = _imgVArr[i];
            imgV.contentMode = UIViewContentModeScaleAspectFill;
            imgV.layer.masksToBounds = true;
            imgV.userInteractionEnabled = true;
            UITapGestureRecognizer*singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
            singleRecognizer.numberOfTapsRequired = 1;
            imgV.tag = i;
            [imgV addGestureRecognizer:singleRecognizer];
            [self.contentView addSubview:imgV];
        }
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
    
}

-(void)setupInfoWithHomeMainData:(HomeMainData *)item{
    for (int i = 0 ; i < 4; i++) {
        UIImageView *imgV = _imgVArr[i];
        if (i < item.homePageCurrentFashion.count) {
            NSArray *arr = item.homePageCurrentFashion;
            CurrentFashionData *item = arr[i];
            [imgV sd_setImageWithURL:[NSURL URLWithString:item.picture] placeholderImage:placeholderImage_226_256 options:0];
            imgV.hidden = false;
        }else{
            imgV.hidden = true;
        }
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_ImgV1 autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_ImgV1 autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_ImgV1 autoSetDimension:ALDimensionWidth toSize:mainScreenWidth *0.5 - FitWith(3)];
        [_ImgV1 autoSetDimension:ALDimensionHeight toSize:FitHeight(245.0)];
        
        [_ImgV2 autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_ImgV2 autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_ImgV2 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_ImgV1];
        [_ImgV2 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_ImgV1];
        
        [_ImgV3 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_ImgV1 withOffset:FitWith(5)];
        [_ImgV3 autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_ImgV3 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_ImgV1];
        [_ImgV3 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_ImgV1];
        
        [_ImgV4  autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_ImgV3];
        [_ImgV4 autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_ImgV4 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_ImgV1];
        [_ImgV4 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_ImgV1];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

-(void)SingleTap:(UITapGestureRecognizer *)tap{
    FouPicTapBlock block = _clickHandle;
    if (block) {
        block(tap.view.tag);
    }
}

@end
