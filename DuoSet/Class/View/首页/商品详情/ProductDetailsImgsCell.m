//
//  ProductDetailsImgsCell.m
//  DuoSet
//
//  Created by fanfans on 12/29/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import "ProductDetailsImgsCell.h"

@interface ProductDetailsImgsCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) NSMutableArray *imgVArr;
@property (nonatomic,strong) UIImageView *lastImgV;
//模型数组
@property (nonatomic,strong) NSMutableArray *imgArr;
@property (nonatomic,strong) NSMutableArray *imgsHightArr;

@end

@implementation ProductDetailsImgsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withImgArr:(NSMutableArray *)imgArr andImgHightArr:(NSMutableArray *)imgsHightArr{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgArr = imgArr;
        _imgsHightArr = imgsHightArr;
        _imgVArr = [NSMutableArray array];
        for (int i = 0; i < imgArr.count; i++) {
            UIImageView *imgV = [UIImageView newAutoLayoutView];
            imgV.contentMode = UIViewContentModeScaleAspectFill;
            imgV.layer.masksToBounds = true;
            [self.contentView addSubview:imgV];
            [imgV sd_setImageWithURL:[NSURL URLWithString:_imgArr[i]] placeholderImage:[UIImage imageNamed:@"数据加载失败"] options:0];
            [_imgVArr addObject:imgV];
        }
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        for (int i = 0; i < _imgVArr.count; i++) {
            UIImageView *imgV = _imgVArr[i];
            NSNumber *num = _imgsHightArr[i];
            CGFloat imgH = num.floatValue;
            if (i == 0) {
                [imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
                [imgV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
                [imgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
                [imgV autoSetDimension:ALDimensionHeight toSize:imgH];
                _lastImgV = imgV;
            }
            [imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
            [imgV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
            [imgV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_lastImgV withOffset:0];
            [imgV autoSetDimension:ALDimensionHeight toSize:imgH];
            _lastImgV = imgV;
        }
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
