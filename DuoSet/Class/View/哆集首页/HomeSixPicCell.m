//
//  HomeSixPicCell.m
//  DuoSet
//
//  Created by mac on 2017/1/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "HomeSixPicCell.h"

@interface HomeSixPicCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) NSMutableArray *imgVArr;
@property(nonatomic,strong) UIImageView *ImgV1;
@property(nonatomic,strong) UIImageView *ImgV2;
@property(nonatomic,strong) UIImageView *ImgV3;
@property(nonatomic,strong) UIImageView *ImgV4;
@property(nonatomic,strong) UIImageView *ImgV5;
@property(nonatomic,strong) UIImageView *ImgV6;

@end

@implementation HomeSixPicCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        
        _ImgV1 = [UIImageView newAutoLayoutView];
        _ImgV2 = [UIImageView newAutoLayoutView];
        _ImgV3 = [UIImageView newAutoLayoutView];
        _ImgV4 = [UIImageView newAutoLayoutView];
        _ImgV5 = [UIImageView newAutoLayoutView];
        _ImgV6 = [UIImageView newAutoLayoutView];
        
        _imgVArr = [NSMutableArray array];
        [_imgVArr addObject:_ImgV1];
        [_imgVArr addObject:_ImgV2];
        [_imgVArr addObject:_ImgV3];
        [_imgVArr addObject:_ImgV4];
        [_imgVArr addObject:_ImgV5];
        [_imgVArr addObject:_ImgV6];
        
        for (int i = 0; i < 6; i++) {
            UIImageView *imgV = _imgVArr[i];
            if (i == 0 || i == 3) {
                imgV.image = [UIImage imageNamed:@"替代6"];
            }else{
                imgV.image = [UIImage imageNamed:@"替代9"];
            }
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

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_ImgV1 autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_ImgV1 autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_ImgV1 autoSetDimension:ALDimensionWidth toSize:mainScreenWidth *0.5 - FitWith(3)];
        [_ImgV1 autoSetDimension:ALDimensionHeight toSize:FitHeight(245.0)];
        
        [_ImgV4 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_ImgV1 withOffset:FitWith(5)];
        [_ImgV4 autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_ImgV4 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_ImgV1];
        [_ImgV4 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_ImgV1];
        
        
        [_ImgV2 autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_ImgV2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_ImgV1 withOffset:FitWith(5)];
        [_ImgV2 autoSetDimension:ALDimensionWidth toSize: (mainScreenWidth *0.5 - FitWith(3)) * 0.5];
        [_ImgV2 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_ImgV1];
        
        [_ImgV3 autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_ImgV3 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_ImgV2 withOffset:FitWith(5)];
        [_ImgV3 autoSetDimension:ALDimensionWidth toSize: (mainScreenWidth *0.5 - FitWith(3)) * 0.5];
        [_ImgV3 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_ImgV1];
        
        [_ImgV5 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_ImgV2 withOffset:FitWith(5)];
        [_ImgV5 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_ImgV2];
        [_ImgV5 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_ImgV1];
        [_ImgV5 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_ImgV2];
        
        [_ImgV6 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_ImgV5];
        [_ImgV6 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_ImgV5 withOffset:FitWith(5)];
        [_ImgV6 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_ImgV1];
        [_ImgV6 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_ImgV2];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

-(void)SingleTap:(UIGestureRecognizer *)tap{
    HomeSixPicCellBlock block = _imgVActionHandle;
    if (block) {
        block(tap.view.tag);
    }
}

@end
