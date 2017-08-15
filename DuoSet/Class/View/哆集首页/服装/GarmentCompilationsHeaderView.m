//
//  GarmentCompilationsHeaderView.m
//  DuoSet
//
//  Created by mac on 2017/1/19.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "GarmentCompilationsHeaderView.h"

@interface GarmentCompilationsHeaderView()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *headerImgV;
@property(nonatomic,strong) UILabel *desLable;


@end

@implementation GarmentCompilationsHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        
        _headerImgV = [UIImageView newAutoLayoutView];
        _headerImgV.image = [UIImage imageNamed:@"替代2"];
        [self addSubview:_headerImgV];
        
        _desLable = [UILabel newAutoLayoutView];
        _desLable.text = @"寒冷的冬天，给你一份温暖！寒冷的冬天，给你一份温暖！寒冷的冬天，给你一份温暖！寒冷的冬天，给你一份温暖！寒冷的冬天，给你一份温暖！寒冷的冬天，给你一份温暖！寒冷的冬天，给你一份温暖！寒冷的冬天，给你一份温暖！寒冷的冬天，给你一份温暖！寒冷的冬天，给你一份温暖！寒冷的冬天，给你一份温暖！寒冷的冬天，给你一份温暖！寒冷的冬天，给你一份温暖！寒冷的冬天，给你一份温暖！";
        _desLable.textColor = [UIColor colorFromHex:0x666666];
        _desLable.font = CUSFONT(11);
        _desLable.numberOfLines = 0;
        [self addSubview:_desLable];
        
        [self updateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_headerImgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_headerImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_headerImgV autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_headerImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(500.0)];
        
        [_desLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(20.0)];
        [_desLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(20.0)];
        [_desLable autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitWith(20.0)];
        [_desLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_headerImgV withOffset:FitWith(10.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
