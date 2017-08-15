//
//  GlobalAreaCell.m
//  DuoSet
//
//  Created by mac on 2017/1/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "GlobalAreaCell.h"
#import "GlobalProductView.h"

@interface GlobalAreaCell()

@property(nonatomic,strong) UIImageView *coverImgV;
@property(nonatomic,strong) NSMutableArray *productArr;
@property(nonatomic,strong) UIView *line;

@end

@implementation GlobalAreaCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _coverImgV = [UIImageView newAutoLayoutView];
        _coverImgV.contentMode = UIViewContentModeScaleAspectFill;
        _coverImgV.image = [UIImage imageNamed:@"替代11"];
        _coverImgV.layer.masksToBounds = true;
        [self.contentView addSubview:_coverImgV];
        
        _productArr = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            GlobalProductView *view = [GlobalProductView newAutoLayoutView];
            view.userInteractionEnabled = true;
            view.tag = i;
            UITapGestureRecognizer*singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
            singleRecognizer.numberOfTapsRequired = 1;
            [view addGestureRecognizer:singleRecognizer];
            [self.contentView addSubview:view];
            [_productArr addObject:view];
        }
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe8e8e8];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)SingleTap:(UITapGestureRecognizer *)tap{
    GlobalProductBlock  block = _productTapHandle;
    if (block) {
        block(tap.view.tag);
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_coverImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
        [_coverImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_coverImgV autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_coverImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(500.0)];
        
        CGFloat productW = FitWith(227.0);
        for (int i = 0; i < 3; i++) {
            GlobalProductView *view = _productArr[i];
            [view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_coverImgV withOffset:FitHeight(20.0)];
            [view autoSetDimension:ALDimensionWidth toSize:productW];
            [view autoSetDimension:ALDimensionHeight toSize:FitHeight(370.0)];
            [view autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(20.0) + (productW + FitWith(15.0)) * i];
        }
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
