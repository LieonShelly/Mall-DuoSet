//
//  HomeTwoPicCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/10.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "HomeTwoPicCell.h"

@interface HomeTwoPicCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) NSMutableArray *imgVArr;
@property(nonatomic,strong) UIImageView *ImgV1;
@property(nonatomic,strong) UIImageView *ImgV2;

@end

@implementation HomeTwoPicCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        
        _ImgV1 = [UIImageView newAutoLayoutView];
        _ImgV2 = [UIImageView newAutoLayoutView];
        
        _imgVArr = [NSMutableArray array];
        [_imgVArr addObject:_ImgV1];
        [_imgVArr addObject:_ImgV2];
        
//        NSArray *imgArr = @[@"have_good_product",@"must_buylist"];
        for (int i = 0; i < 2; i++) {
            UIImageView *imgV = _imgVArr[i];
//            imgV.image = [UIImage imageNamed:imgArr[i]];
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
    [_ImgV1 sd_setImageWithURL:[NSURL URLWithString:item.homePageGoodsProductCover] placeholderImage:placeholderImage_226_256 options:0];
    [_ImgV2 sd_setImageWithURL:[NSURL URLWithString:item.homePageMustShopProductCover] placeholderImage:placeholderImage_226_256 options:0];
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_ImgV1 autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10.0)];
        [_ImgV1 autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_ImgV1 autoSetDimension:ALDimensionWidth toSize:mainScreenWidth *0.5 - FitWith(3)];
        [_ImgV1 autoSetDimension:ALDimensionHeight toSize:FitHeight(245.0)];
        
        [_ImgV2 autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10.0)];
        [_ImgV2 autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_ImgV2 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_ImgV1];
        [_ImgV2 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_ImgV1];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

-(void)SingleTap:(UITapGestureRecognizer *)tap{
    TwoPicTapBlock block = _clickHandle;
    if (block) {
        block(tap.view.tag);
    }
}
@end
