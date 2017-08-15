//
//  HomeMatchNewCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/5.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "HomeMatchNewCell.h"

@interface HomeMatchNewCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *titleImgV;
@property (nonatomic,strong) UIImageView *coverImgV;
@property (nonatomic,strong) NSMutableArray *coverImgVArr;
@property (nonatomic,assign) CGFloat imgW;
@property (nonatomic,assign) CGFloat imgH;

@end

@implementation HomeMatchNewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgW = FitWith(280.0);
        _imgH = FitHeight(27.0);
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        
        _titleImgV = [UIImageView newAutoLayoutView];
        [_bgView addSubview:_titleImgV];
        
        _coverImgV = [UIImageView newAutoLayoutView];
        _coverImgV.contentMode = UIViewContentModeScaleAspectFill;
        _coverImgV.layer.masksToBounds = true;
        _coverImgV.tag = 0;
        _coverImgV.userInteractionEnabled = true;
        UITapGestureRecognizer*singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
        singleRecognizer.numberOfTapsRequired = 1;
        [_coverImgV addGestureRecognizer:singleRecognizer];
        [self.contentView addSubview:_coverImgV];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)SetupInfoWithHomeMatchData:(HomeMatchData *)item{
    [_titleImgV sd_setImageWithURL:[NSURL URLWithString:item.titleIcon] placeholderImage:nil options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            _imgW = FitWith(image.size.width);
            _imgH = FitHeight(image.size.height);
            _didUpdateConstraints = false;
            [self updateConstraints];
        }
    }];
    [_coverImgV sd_setImageWithURL:[NSURL URLWithString:item.picture] placeholderImage:nil options:0];
}

-(void)SingleTap:(UITapGestureRecognizer *)tap{
    HomeMatchNewCellImgVTapBlock block = _imgVTapHandle;
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
        
        [_coverImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(16.0)];
        [_coverImgV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(16.0)];
        [_coverImgV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_bgView];
        [_coverImgV autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
