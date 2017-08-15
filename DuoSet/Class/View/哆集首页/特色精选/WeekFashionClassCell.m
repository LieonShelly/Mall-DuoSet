//
//  WeekFashionClassCell.m
//  DuoSet
//
//  Created by mac on 2017/1/18.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "WeekFashionClassCell.h"

@interface WeekFashionClassCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIImageView *coverImgV;
@property (nonatomic,strong) UIImageView *topImgV;
@property (nonatomic,strong) UILabel *topLable;
@property (nonatomic,strong) UILabel *topNumLable;
@property (nonatomic,strong) UILabel *namelable;
@property (nonatomic,strong) UILabel *desLable;
@property (nonatomic,strong) UILabel *tagLable;
@property (nonatomic,strong) UILabel *tipsLable;
@property (nonatomic,strong) NSMutableArray *heartImgVArr;

@end

@implementation WeekFashionClassCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {//san
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _coverImgV = [UIImageView newAutoLayoutView];
        _coverImgV.image = [UIImage imageNamed:@"testAvatar.jpg"];
        [self.contentView addSubview:_coverImgV];
        
        _topImgV = [UIImageView newAutoLayoutView];
        _topImgV.image = [UIImage imageNamed:@"san"];
        [_coverImgV addSubview:_topImgV];
        
        _topLable = [UILabel newAutoLayoutView];
        _topLable.text = @"TOP";
        _topLable.textColor = [UIColor whiteColor];
        _topLable.textAlignment = NSTextAlignmentCenter;
        _topLable.font = CUSFONT(9);
        [_topImgV addSubview:_topLable];
        
        _topNumLable = [UILabel newAutoLayoutView];
        _topNumLable.text = @"1";
        _topNumLable.textColor = [UIColor whiteColor];
        _topNumLable.textAlignment = NSTextAlignmentCenter;
        _topNumLable.font = CUSFONT(9);
        [_topImgV addSubview:_topNumLable];
        
        _namelable = [UILabel newAutoLayoutView];
        _namelable.textColor = [UIColor colorFromHex:0x333333];
        _namelable.text = @"秋冬连衣裙";
        _namelable.textAlignment = NSTextAlignmentLeft;
        _namelable.font = CUSFONT(13);
        [self.contentView addSubview:_namelable];
        
        _desLable = [UILabel newAutoLayoutView];
        _desLable.textColor = [UIColor colorFromHex:0x666666];
        _desLable.text = @"今年火到不行的连衣裙，别致的V领时尚设计，温暖羊绒，给你超级舒适的体验。温暖羊绒，给你超级舒适的体验。";
        _desLable.numberOfLines = 4;
        _desLable.textAlignment = NSTextAlignmentLeft;
        _desLable.font = CUSFONT(11);
        [self.contentView addSubview:_desLable];
        
        _tagLable = [UILabel newAutoLayoutView];
        _tagLable.textColor = [UIColor colorFromHex:0x666666];
        _tagLable.text = @" 秋冬连衣裙 ";
        _tagLable.textAlignment = NSTextAlignmentLeft;
        _tagLable.font = CUSFONT(12);
        _tagLable.layer.borderWidth = 1;
        _tagLable.layer.borderColor = [UIColor colorFromHex:0x666666].CGColor;
        [self.contentView addSubview:_tagLable];
        
        _tipsLable = [UILabel newAutoLayoutView];
        _tipsLable.text = @"流行指数";
        _tipsLable.textColor = [UIColor colorFromHex:0x666666];
        _tipsLable.textAlignment = NSTextAlignmentLeft;
        _tipsLable.font = CUSFONT(11);
        [self.contentView addSubview:_tipsLable];
        
        _heartImgVArr = [NSMutableArray array];
        for (int i = 0; i < 5; i++) {
            UIImageView *heartImgV = [UIImageView newAutoLayoutView];
            heartImgV.image = [UIImage imageNamed:@"love"];
            [self.contentView addSubview:heartImgV];
            [_heartImgVArr addObject:heartImgV];
        }
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_coverImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_coverImgV autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(30.0)];
        [_coverImgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_coverImgV autoSetDimension:ALDimensionWidth toSize:FitWith(260.0)];
        
        [_topImgV autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_coverImgV];
        [_topImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(10.0)];
        [_topImgV autoSetDimension:ALDimensionWidth toSize:FitWith(90.0)];
        [_topImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(70.0)];
        
        [_topLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_topLable autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_topLable autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        [_topNumLable autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_topNumLable autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_topNumLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_topLable];
        
        [_namelable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_coverImgV];
        [_namelable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_namelable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_coverImgV withOffset:FitWith(20.0)];
        
        [_desLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_namelable];
        [_desLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_namelable withOffset:FitHeight(10.0)];
        [_desLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        
        [_tagLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_namelable];
        [_tagLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(180.0)];
        [_tagLable autoSetDimension:ALDimensionHeight toSize:FitHeight(40.0)];
        
        [_tipsLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_coverImgV];
        [_tipsLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_namelable];
        
        for (int i = 0; i < 5; i++) {
            UIImageView *heartImgV = _heartImgVArr[i];
            [heartImgV autoSetDimension:ALDimensionWidth toSize:FitWith(20.0)];
            [heartImgV autoSetDimension:ALDimensionHeight toSize:FitWith(20.0)];
            [heartImgV autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_tipsLable];
            [heartImgV autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_tipsLable withOffset:FitWith(10.0) + (FitWith(20.0) + FitWith(5)) * i];
        }
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
