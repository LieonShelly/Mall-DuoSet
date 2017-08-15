//
//  CommonTitleImageCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/8.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CommonTitleImageCell.h"

@interface CommonTitleImageCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,assign) CGFloat imgW;
@property (nonatomic,assign) CGFloat imgH;

@end

@implementation CommonTitleImageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imgW = FitWith(220.0);
        _imgH = FitHeight(27.0);
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        
        _titleImgV = [UIImageView newAutoLayoutView];
//        _titleImgV.contentMode = UIViewContentModeScaleAspectFill;
        [_bgView addSubview:_titleImgV];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithTitleImageUrlStr:(NSString *)titleimgStr{
    [_titleImgV sd_setImageWithURL:[NSURL URLWithString:titleimgStr] placeholderImage:nil options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            _imgW = FitWith(image.size.width);
            _imgH = FitHeight(image.size.height);
            _didUpdateConstraints = false;
            [self updateConstraints];
        }
    }];
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgesToSuperviewEdges];
        
        [_titleImgV autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_titleImgV autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_titleImgV autoSetDimension:ALDimensionHeight toSize:_imgH];
        [_titleImgV autoSetDimension:ALDimensionWidth toSize:_imgW];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
