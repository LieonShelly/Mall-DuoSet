//
//  WalletViewController.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/7.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "WalletViewController.h"

@interface WalletViewController ()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIImageView *imgV;
@property (nonatomic,strong) UILabel *tipLable;
@property (nonatomic,strong) UILabel *amoutLable;
@property (nonatomic,copy) NSString *amout;
@property(nonatomic,strong) CommonDefeatedView *defeatedView;

@end

@implementation WalletViewController

-(instancetype)initWithAmout:(NSString *)amout{
    self = [super init];
    if (self) {
        _amout = amout;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    self.title = @"我的钱包";
    [self creatUI];
}

- (void)creatUI{
    _imgV = [UIImageView newAutoLayoutView];
    _imgV.image = [UIImage imageNamed:@"user_wallet_img"];
    [self.view addSubview:_imgV];
    
    _tipLable = [UILabel newAutoLayoutView];
    _tipLable.textAlignment = NSTextAlignmentCenter;
    _tipLable.textColor = [UIColor colorFromHex:0x222222];
    _tipLable.text = @"我的余额";
    _tipLable.font = CUSFONT(14);
    [self.view addSubview:_tipLable];
    
    _amoutLable = [UILabel newAutoLayoutView];
    _amoutLable.textAlignment = NSTextAlignmentCenter;
    _amoutLable.textColor = [UIColor colorFromHex:0x222222];
    _amoutLable.font = CUSFONT(50);
    NSString *newStr = [NSString stringWithFormat:@"%.2lf",_amout.floatValue];
    NSString *text = [NSString stringWithFormat:@"￥%@",newStr];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    if (text.length > 2) {
        [attributeString addAttribute:NSFontAttributeName value:CUSFONT(30) range:NSMakeRange(text.length - 2, 2)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHex:0x222222] range:NSMakeRange(text.length - 2, 2)];
    }
    _amoutLable.attributedText = attributeString;
    [self.view addSubview:_amoutLable];
    
    [self updateViewConstraints];
}

-(void)updateViewConstraints{
    if (!_didUpdateConstraints) {
        
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(70.0) + 64];
        [_imgV autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_imgV autoSetDimension:ALDimensionWidth toSize:FitHeight(205.0)];
        [_imgV autoSetDimension:ALDimensionHeight toSize:FitHeight(205.0)];
        
        [_tipLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_tipLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_imgV withOffset:FitHeight(30.0)];
        
        [_amoutLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_amoutLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_tipLable withOffset:FitHeight(40.0)];
        
        _didUpdateConstraints = true;
    }
    [super updateViewConstraints];
}

@end
