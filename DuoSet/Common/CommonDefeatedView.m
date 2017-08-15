//
//  CommonDefeatedView.m
//  DuoSet
//
//  Created by fanfans on 2017/3/31.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CommonDefeatedView.h"

typedef void(^BackBlock)();

@interface CommonDefeatedView()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIImageView *defeatedImgV;
@property(nonatomic,strong) UILabel *messageLable;
@property(nonatomic,strong) UIButton *backBlockBtn;
@property(nonatomic,copy) NSString *defeatedName;
@property(nonatomic,copy) NSString *btnName;
@property(nonatomic,copy) BackBlock backHandle;

@end

@implementation CommonDefeatedView

-(instancetype)initWithFrame:(CGRect)frame andDefeatedImageName:(NSString *)defeatedName messageName:(NSString *)message backBlockBtnName:(NSString *)btnName backBlock:(void (^)())backBlock{
    self = [super initWithFrame:frame];
    if (self) {
        _defeatedName = defeatedName;
        _btnName = btnName;
        
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _bgView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
        [self addSubview:_bgView];
        
        _defeatedImgV = [UIImageView newAutoLayoutView];
        _defeatedImgV.image = [UIImage imageNamed:defeatedName];
        _defeatedImgV.contentMode = UIViewContentModeScaleAspectFill;
        [_bgView addSubview:_defeatedImgV];
        
        _messageLable = [UILabel newAutoLayoutView];
        _messageLable.text = message;
        _messageLable.textColor = [UIColor colorFromHex:0x808080];
        _messageLable.textAlignment = NSTextAlignmentCenter;
        _messageLable.font = CUSFONT(14);
        [_bgView addSubview:_messageLable];
        
        if (btnName.length > 0) {
            _backBlockBtn = [UIButton newAutoLayoutView];
            _backBlockBtn.titleLabel.font = CUSFONT(13);
            [_backBlockBtn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
            [_backBlockBtn setTitle:btnName forState:UIControlStateNormal];
            _backBlockBtn.layer.masksToBounds = true;
            _backBlockBtn.layer.cornerRadius = 3;
            _backBlockBtn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
            _backBlockBtn.layer.borderWidth = 1;
            [_backBlockBtn addTarget:self action:@selector(backBlockBtnAction) forControlEvents:UIControlEventTouchUpInside];
            [_bgView addSubview:_backBlockBtn];
            _backHandle = backBlock;
        }
        
        [self updateConstraints];
    }
    return self;
}

-(void)backBlockBtnAction{
    BackBlock block = _backHandle;
    if (block) {
        block();
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        UIImage *img = [UIImage imageNamed:_defeatedName];
        [_defeatedImgV autoSetDimension:ALDimensionWidth toSize:img.size.width];
        [_defeatedImgV autoSetDimension:ALDimensionHeight toSize:img.size.height];
        [_defeatedImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(180.0)];
        [_defeatedImgV autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [_messageLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_defeatedImgV withOffset:FitHeight(80.0)];
        [_messageLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        if (_btnName.length > 0) {
            [_backBlockBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_messageLable withOffset:FitHeight(80.0)];
            [_backBlockBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
            [_backBlockBtn autoSetDimension:ALDimensionWidth toSize:FitWith(180.0)];
            [_backBlockBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(80.0)];
        }
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
