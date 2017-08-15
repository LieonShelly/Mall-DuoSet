//
//  GlobalBuyDetailSectionView.m
//  DuoSet
//
//  Created by fanfans on 2017/3/15.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "GlobalBuyDetailSectionView.h"

@interface GlobalBuyDetailSectionView()

@property(nonatomic,strong) UIImageView *ImgV;

@end

@implementation GlobalBuyDetailSectionView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _ImgV = [[UIImageView alloc]initWithFrame:frame];
        _ImgV.contentMode = UIViewContentModeScaleAspectFill;
        _ImgV.layer.masksToBounds = true;
        [self addSubview:_ImgV];
    }
    return self;
}

-(void)setupInfoWithGloballistData:(GloballistData *)item{
    [_ImgV sd_setImageWithURL:[NSURL URLWithString:item.picture] placeholderImage:placeholderImageSize(750, 400) options:0];
}
//

@end
