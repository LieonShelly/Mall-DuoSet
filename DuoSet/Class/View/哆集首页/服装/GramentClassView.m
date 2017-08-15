//
//  GramentClassView.m
//  DuoSet
//
//  Created by mac on 2017/1/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "GramentClassView.h"

@interface GramentClassView()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *imgV;
@property(nonatomic,strong) UILabel *nameLable;

@end

@implementation GramentClassView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        _imgV.contentMode = UIViewContentModeCenter;
        _imgV.image = [UIImage imageNamed:@"替代5"];
        [self addSubview:_imgV];
        
        _nameLable = [[UILabel alloc]initWithFrame:CGRectMake(0, _imgV.frame.origin.y + _imgV.frame.size.height, frame.size.width, FitHeight(40.0))];
        _nameLable.textColor = [UIColor colorFromHex:0x333333];
        _nameLable.text = @"当季新品";
        _nameLable.font = CUSFONT(11);
        _nameLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_nameLable];
        
        [self updateConstraints];
    }
    return self;
}


- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_imgV autoSetDimension:ALDimensionHeight toSize:FitWith(170.0)];
        
        [_nameLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_imgV];
        [_nameLable autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_nameLable autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}


@end
