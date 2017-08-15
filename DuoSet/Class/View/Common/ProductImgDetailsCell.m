//
//  ProductImgDetailsCell.m
//  DuoSet
//
//  Created by mac on 2017/1/19.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ProductImgDetailsCell.h"

@interface ProductImgDetailsCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) NSMutableArray *imgvArr;
@property(nonatomic,strong) UIImageView *lastImgV;
@property(nonatomic,strong) ProductDetailsData *item;

@end

@implementation ProductImgDetailsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withProductDetailsData:(ProductDetailsData *)item{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
        
        _imgvArr = [NSMutableArray array];
        _item = item;
        for (int i = 0; i < item.detailPics.count; i++) {
            UIImageView *imgV = [UIImageView newAutoLayoutView];
            imgV.contentMode = UIViewContentModeScaleAspectFit;
            imgV.layer.masksToBounds = true;
            [imgV sd_setImageWithURL:[NSURL URLWithString:item.detailPics[i]] placeholderImage:[UIImage imageNamed:@""]  options:SDWebImageRefreshCached];
            [self.contentView addSubview:imgV];
            [_imgvArr addObject:imgV];
        }
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
    
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        for (int i = 0; i < _item.detailPics.count; i++) {
            UIImageView *imgV = _imgvArr[i];
            NSNumber *num = _item.detailPicsHight[i];
            CGFloat imgH = num.floatValue;
//            NSNumber *wNum = _item.detailPicsWidth[i];
//            CGFloat imgW = wNum.floatValue;
            if (i == 0) {
                [imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft];
                [imgV autoPinEdgeToSuperviewEdge:ALEdgeRight];
                [imgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
                [imgV autoSetDimension:ALDimensionHeight toSize:imgH];
                _lastImgV = imgV;
            }else{
                [imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft];
                [imgV autoPinEdgeToSuperviewEdge:ALEdgeRight];
                [imgV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_lastImgV];
                [imgV autoSetDimension:ALDimensionHeight toSize:imgH];
                _lastImgV = imgV;
            }
        }
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
