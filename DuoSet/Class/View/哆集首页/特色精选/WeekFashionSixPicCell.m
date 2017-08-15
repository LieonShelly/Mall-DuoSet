//
//  WeekFashionSixPicCell.m
//  DuoSet
//
//  Created by mac on 2017/1/18.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "WeekFashionSixPicCell.h"

@interface WeekFashionSixPicCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) NSMutableArray *imgVArr;

@end

@implementation WeekFashionSixPicCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imgVArr = [NSMutableArray array];
        for (int i = 0; i < 6; i++) {
            UIImageView *imgV = [UIImageView newAutoLayoutView];
            imgV.image = [UIImage imageNamed:@"替代8"];
//            imgV.backgroundColor = [UIColor mainColor];
            imgV.layer.masksToBounds = true;
            [self.contentView addSubview:imgV];
            imgV.userInteractionEnabled = true;
            imgV.tag = i;
            UITapGestureRecognizer*singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
            singleRecognizer.numberOfTapsRequired = 1;
            [imgV addGestureRecognizer:singleRecognizer];
            [_imgVArr addObject:imgV];
        }
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)SingleTap:(UITapGestureRecognizer *)tap{
    WeekFashionSixPicCellBlock block = _picHandle;
    if (block) {
        block(tap.view.tag);
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        CGFloat imgVW = (mainScreenWidth - FitWith(60.0) - FitWith(20)) / 3;
        CGFloat imgVH = FitHeight(185.0);
        for (int i = 0; i < _imgVArr.count; i++) {
            UIImageView *imgV = _imgVArr[i];
            [imgV autoSetDimension:ALDimensionWidth toSize:imgVW];
            [imgV autoSetDimension:ALDimensionHeight toSize:imgVH];
            if (i < 3) {
                [imgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
                [imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0) + (imgVW + FitWith(10.0)) * i ];
            }else{
                [imgV autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(30.0)];
                [imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0) + (imgVW + FitWith(10.0)) * (i - 3)];
            }
        }
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
