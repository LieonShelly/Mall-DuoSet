//
//  GarmentClassCell.m
//  DuoSet
//
//  Created by mac on 2017/1/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "GarmentClassCell.h"
#import "GramentClassView.h"

@interface GarmentClassCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) NSMutableArray *classViewArr;

@end

@implementation GarmentClassCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        
        _lineView = [UIView newAutoLayoutView];
        _lineView.backgroundColor = [UIColor mainColor];
        [self.contentView addSubview:_lineView];
        
        _titleLable = [UILabel newAutoLayoutView];
        _titleLable.textAlignment = NSTextAlignmentLeft;
        _titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        _titleLable.textColor = [UIColor colorFromHex:0x333333];
        _titleLable.text = @"当季热卖";
        [self.contentView addSubview:_titleLable];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_bgView];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
    
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_lineView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_lineView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        [_lineView autoSetDimension:ALDimensionWidth toSize:5];
        [_lineView autoSetDimension:ALDimensionHeight toSize:FitHeight(50.0)];
        
        [_titleLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_lineView];
        [_titleLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_lineView];
        [_titleLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_lineView withOffset:5];
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_bgView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_lineView withOffset:FitHeight(5.0)];
        
        _classViewArr = [NSMutableArray array];
        for (int i = 0; i < 8; i++) {
            GramentClassView *view = [[GramentClassView alloc]init];
            if (i < 4) {
                view.frame = CGRectMake((FitWith(170.0) + 2) * i, 0, FitWith(170.0), FitHeight(209));
            }else{
                view.frame = CGRectMake((FitWith(170.0) + 2) * (i - 4), FitHeight(209) + 2, FitWith(170.0), FitHeight(209));
            }
            [_bgView addSubview:view];
            view.tag = 1;
            view.userInteractionEnabled = true;
            UITapGestureRecognizer*singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
            singleRecognizer.numberOfTapsRequired = 1;
            [view addGestureRecognizer:singleRecognizer];
            [_classViewArr addObject:view];
        }
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

-(void)SingleTap:(UITapGestureRecognizer *)tap{
    GarmentClassCellBlock block = _tapHandle;
    if (block) {
        block(tap.view.tag);
    }
}

@end
