//
//  SinginWindowView.m
//  DuoSet
//
//  Created by fanfans on 2017/2/27.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SinginWindowView.h"

@interface SinginWindowView()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UIImageView *bgImgView;
@property(nonatomic,strong) UIImageView *allImgV;
@property(nonatomic,strong) UILabel *allCountLable;
@property(nonatomic,strong) UILabel *signDaysLable;
@property(nonatomic,strong) NSMutableArray *btnArr;
@property(nonatomic,strong) UILabel *allSinginLable;

@end

@implementation SinginWindowView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _bgImgView = [UIImageView newAutoLayoutView];
        _bgImgView.image = [UIImage imageNamed:@"singin_window_Img"];
        [self addSubview:_bgImgView];
        
        _allImgV = [UIImageView newAutoLayoutView];
        _allImgV.image = [UIImage imageNamed:@"singin_all_img"];
        [_bgImgView addSubview:_allImgV];
        
        _allCountLable = [UILabel newAutoLayoutView];
        _allCountLable.text = @"100";
        _allCountLable.font = CUSFONT(13);
        _allCountLable.textAlignment = NSTextAlignmentLeft;
        _allCountLable.textColor = [UIColor colorFromHex:0xffc104];
        [_bgImgView addSubview:_allCountLable];
        
        _signDaysLable = [UILabel newAutoLayoutView];
        _signDaysLable.textColor = [UIColor colorFromHex:0xffffff];
        _signDaysLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:27];
        _signDaysLable.textAlignment = NSTextAlignmentCenter;
        _signDaysLable.text = @"1";
        [_bgImgView addSubview:_signDaysLable];
        
        _btnArr = [NSMutableArray array];
        for (int i = 0; i < 7; i++) {
            UIButton *btn = [UIButton newAutoLayoutView];
            btn.tag = i + 1;
            btn.titleLabel.font = CUSFONT(9);
            [btn setTitle:[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"+%d",(int)pow(2,i)]] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"singin_img_normal"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"singin_img_selected"] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor colorFromHex:0x90727d] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorFromHex:0xec6f18] forState:UIControlStateSelected];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, -6, 0)];
            [_bgImgView addSubview:btn];
            
            [_btnArr addObject:btn];
        }
        
        _allSinginLable = [UILabel newAutoLayoutView];
        _allSinginLable.textColor = [UIColor whiteColor];
        _allSinginLable.textAlignment = NSTextAlignmentLeft;
        _allSinginLable.font = CUSFONT(9);
        [_bgImgView addSubview:_allSinginLable];
        
        [self updateConstraints];
    }
    return self;
}

-(void)setSignDaysWithDays:(NSString *)days{
    _signDaysLable.text = days;
    _allSinginLable.text = [NSString stringWithFormat:@"已签到%@天",days];
//    CGRect frame = _allSinginLable.frame;
//    frame.origin.x = FitWith(50.0) + (FitWith(35.0) + FitWith(45.0)) * days.integerValue;
//    _allSinginLable.frame = frame;
    for (UIButton *btn in _btnArr) {
        if (btn.tag <= days.integerValue) {
            btn.selected = true;
        }
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgImgView autoPinEdgesToSuperviewEdges];
        
        [_allImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(20.0)];
        [_allImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
        [_allImgV autoSetDimension:ALDimensionWidth toSize:FitWith(60.0)];
        [_allImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(40.0)];
        
        [_allCountLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_allImgV];
        [_allCountLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_allImgV];
        [_allCountLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_allImgV withOffset:5];
        
        [_signDaysLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(260.0)];
        [_signDaysLable autoAlignAxisToSuperviewMarginAxis:ALAxisVertical];
        
        for (int i = 0; i < 7; i++) {
            UIButton *btn = _btnArr[i];
            [btn autoSetDimension:ALDimensionWidth toSize:FitWith(50.0)];
            [btn autoSetDimension:ALDimensionHeight toSize:FitWith(50.0)];
            [btn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(520.0)];
            [btn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(50.0) + (FitWith(35.0) + FitWith(45.0)) * i];
        }
        
        [_allSinginLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(50.0)];
        [_allSinginLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(590.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}


@end
