//
//  HomeFashionCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/5.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "HomeFashionCell.h"

@interface HomeFashionCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *titleImgV;
@property (nonatomic,strong) NSMutableArray *coverImgVArr;
@property (nonatomic,assign) CGFloat imgW;
@property (nonatomic,assign) CGFloat imgH;

@end

@implementation HomeFashionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _imgW = FitWith(220.0);
        _imgH = FitHeight(27.0);
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        
        _titleImgV = [UIImageView newAutoLayoutView];
        [_bgView addSubview:_titleImgV];
        
        _coverImgVArr = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            UIImageView *imgV = [UIImageView newAutoLayoutView];
            imgV.contentMode = UIViewContentModeScaleAspectFill;
            imgV.layer.masksToBounds = true;
            imgV.backgroundColor = [UIColor mainColor];
            [self.contentView addSubview:imgV];
            imgV.tag = i;
            imgV.userInteractionEnabled = true;
            UITapGestureRecognizer*singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
            singleRecognizer.numberOfTapsRequired = 1;
            imgV.tag = i;
            [imgV addGestureRecognizer:singleRecognizer];
            [_coverImgVArr addObject:imgV];
        }
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithHomeMainData:(HomeMainData *)item{
    [_titleImgV sd_setImageWithURL:[NSURL URLWithString:item.homePageCurrentFashionTitleIcon] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            _imgW = FitWith(image.size.width);
            _imgH = FitHeight(image.size.height);
            _didUpdateConstraints = false;
            [self updateConstraints];
        }
    }];
    
    for (int i = 0 ; i < 3; i++) {
        UIImageView *imgV = _coverImgVArr[i];
        if (i < item.homePageCurrentFashion.count) {
            NSArray *arr = item.homePageCurrentFashion;
            CurrentFashionData *item = arr[i];
            [imgV sd_setImageWithURL:[NSURL URLWithString:item.picture] placeholderImage:placeholderImageSize(200, 200) options:0];
            imgV.hidden = false;
        }else{
            imgV.hidden = true;
        }
    }
}

-(void)SingleTap:(UITapGestureRecognizer *)tap{
    HomeFashionCellImgVTapBlock block = _imgVTapHandle;
    if (block) {
        block(tap.view.tag);
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_bgView autoSetDimension:ALDimensionHeight toSize:FitHeight(100.0)];
        
        [_titleImgV autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_titleImgV autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_titleImgV autoSetDimension:ALDimensionHeight toSize:_imgH];
        [_titleImgV autoSetDimension:ALDimensionWidth toSize:_imgW];
        
        CGFloat imgW = (mainScreenWidth - FitWith(32.0) - FitWith(16)) / 3;
        for (int i = 0 ; i < 3; i++) {
            UIImageView *imgV = _coverImgVArr[i];
            [imgV autoSetDimension:ALDimensionHeight toSize:imgW];
            [imgV autoSetDimension:ALDimensionWidth toSize:imgW];
            [imgV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_bgView];
            [imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(16.0) + (imgW + FitWith(8.0)) * i];
        }
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
