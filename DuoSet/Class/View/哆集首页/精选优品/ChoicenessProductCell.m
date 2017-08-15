//
//  ChoicenessProductCell.m
//  DuoSet
//
//  Created by mac on 2017/1/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ChoicenessProductCell.h"
#import "ChoicenessProduct.h"

@interface ChoicenessProductCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *coverImgV;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *productArr;

@end

@implementation ChoicenessProductCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.userInteractionEnabled = true;
        [self.contentView addSubview:_bgView];
        
        _coverImgV = [UIImageView newAutoLayoutView];
        _coverImgV.layer.masksToBounds = true;
        _coverImgV.layer.cornerRadius = 5;
        _coverImgV.image = [UIImage imageNamed:@"替代1"];
        [_bgView addSubview:_coverImgV];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe8e8e8];
        [_bgView addSubview:_line];
        
        _scrollView = [UIScrollView newAutoLayoutView];
        _scrollView.contentSize = CGSizeMake(FitWith(150.0) * 10 + FitWith(30.0), 0);
        _scrollView.userInteractionEnabled = true;
        [_bgView addSubview:_scrollView];
        
        _productArr = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            ChoicenessProduct *view = [[ChoicenessProduct alloc]initWithFrame:CGRectMake(FitWith(150.0) * i, 0, FitWith(150.0), FitHeight(250.0))];;
            [_scrollView addSubview:view];
            view.tag = i;
            view.userInteractionEnabled = true;
            UITapGestureRecognizer*singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
            singleRecognizer.numberOfTapsRequired = 1;
            [view addGestureRecognizer:singleRecognizer];
            [_productArr addObject:view];
        }
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)SingleTap:(UITapGestureRecognizer *)tap{
    ChoicenessProductBlock block = _productHandle;
    if (block) {
        block(tap.view.tag);
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(20.0)];
        
        [_coverImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_coverImgV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_coverImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
        [_coverImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(300.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_coverImgV withOffset:FitHeight(20.0)];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        [_scrollView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_scrollView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_scrollView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_line];
        [_scrollView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(10.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
