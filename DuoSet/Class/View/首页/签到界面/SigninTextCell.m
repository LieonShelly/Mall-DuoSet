//
//  SigninTextCell.m
//  DuoSet
//
//  Created by fanfans on 2017/2/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SigninTextCell.h"

@interface SigninTextCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UILabel *tipsTitle;
@property (nonatomic,strong) UIImageView *siginCountImgV;
@property (nonatomic,strong) UILabel *dayCountLable;
@property (nonatomic,strong) UILabel *dayLable;
@property (nonatomic,strong) UILabel *subTitle;
@property (nonatomic,strong) NSMutableArray *countBtnArr;
@property (nonatomic,strong) NSMutableArray *dayLableArr;

@end

@implementation SigninTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {//singin_count@3x
        
        _tipsTitle = [UILabel newAutoLayoutView];
        _tipsTitle.textColor = [UIColor colorFromHex:0x222222];
        _tipsTitle.text = @"已连续签到";
        _tipsTitle.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
        [self.contentView addSubview:_tipsTitle];
        
        _siginCountImgV = [UIImageView newAutoLayoutView];
        _siginCountImgV.image = [UIImage imageNamed:@"singin_count"];
        [self.contentView addSubview:_siginCountImgV];
        
        _dayCountLable = [UILabel newAutoLayoutView];
        _dayCountLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:35];
        _dayCountLable.textColor = [UIColor colorFromHex:0x333333];
        _dayCountLable.textAlignment = NSTextAlignmentRight;
        _dayCountLable.adjustsFontSizeToFitWidth = true;
        [_siginCountImgV addSubview:_dayCountLable];
        
        _dayLable = [UILabel newAutoLayoutView];
        _dayLable.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _dayLable.text = @"天";
        _dayLable.textAlignment = NSTextAlignmentLeft;
        _dayLable.textColor = [UIColor colorFromHex:0x333333];
        [_siginCountImgV addSubview:_dayLable];
        
        _countBtnArr = [NSMutableArray array];
        for (int i = 0; i < 7; i++) {
            UIButton *btn = [UIButton newAutoLayoutView];
            btn.layer.cornerRadius = FitWith(64.0) * 0.5;
            btn.layer.masksToBounds = true;
            btn.titleLabel.font = CUSFONT(13);
            [btn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageWithColor:[UIColor mainColor]] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            [btn setTitle:[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"+%d",(int)pow(2,i)]] forState:UIControlStateNormal];
            [self.contentView addSubview:btn];
            [_countBtnArr addObject:btn];
        }
        
        _dayLableArr = [NSMutableArray array];
        for (int i = 0; i < 7; i++) {
            UILabel *lable = [UILabel newAutoLayoutView];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.textColor = [UIColor colorFromHex:0x808080];
            lable.font = [UIFont systemFontOfSize:13];
            lable.text = [NSString stringWithFormat:@"第%d天",i+1];
            [self.contentView addSubview:lable];
            [_dayLableArr addObject:lable];
        }
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithSevenDaySignDatas:(NSMutableArray *)datas andUserSignData:(UserSignData *)item{
    _dayCountLable.text = item.signDays;
    for (int i = 0; i < 7; i++) {
        UIButton *btn = _countBtnArr[i];
        SevenDaySignData *data = datas[i];
        [btn setTitle:[NSString stringWithFormat:@"+%@",data.pointCount] forState:UIControlStateNormal];
        btn.selected = data.isSign;
        if (btn.selected) {
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = [UIColor mainColor].CGColor;
        }else{
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
        }
    }
}


- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tipsTitle autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_tipsTitle autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(35.0)];
        
        [_siginCountImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(92.0)];
        [_siginCountImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(294.0)];
        [_siginCountImgV autoSetDimension:ALDimensionWidth toSize:FitWith(164.0)];
        [_siginCountImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(128.0)];
        
//        [_dayCountLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_dayCountLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(46.0)];
        [_dayCountLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(60)];
        [_dayCountLable autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        
        [_dayLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(76.0)];
//        [_dayLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_dayCountLable withOffset:FitWith(10)];
        [_dayLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(10)];
        
        for (int i = 0; i < 7; i++) {
            UIButton *btn = _countBtnArr[i];
            [btn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(280.0)];
            [btn autoSetDimension:ALDimensionWidth toSize:FitWith(64.0)];
            [btn autoSetDimension:ALDimensionHeight toSize:FitWith(64.0)];
            [btn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(32.0) + FitWith(104.0) * i];
        }
        
        for (int i = 0; i < 7; i++) {
            UILabel *lable = _dayLableArr[i];
            [lable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(368.0)];
            [lable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(32.0) + FitWith(104.0) * i];
        }
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
