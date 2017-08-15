//
//  PiazzaUserDetailsHeaderView.m
//  DuoSet
//
//  Created by fanfans on 2017/5/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaUserDetailsHeaderView.h"

@interface PiazzaUserDetailsHeaderView()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *bgImgView;
@property(nonatomic,strong) UIImageView *avatar;
@property(nonatomic,strong) UILabel *userName;
@property(nonatomic,strong) UIImageView *footImgV;
@property(nonatomic,strong) NSMutableArray *lineArr;
@property(nonatomic,strong) NSMutableArray *countLableArr;
@property(nonatomic,strong) NSMutableArray *desLableArr;
@property(nonatomic,strong) NSMutableArray *btnArr;

@end

@implementation PiazzaUserDetailsHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, frame.size.height)];
        _bgImgView.image = [UIImage imageNamed:@"piazza_header_bgView"];
        _bgImgView.userInteractionEnabled = true;
        _bgImgView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_bgImgView];
        
        _avatar = [UIImageView newAutoLayoutView];
        _avatar.layer.cornerRadius = FitHeight(140.0) * 0.5;
        _avatar.layer.masksToBounds = true;
        _avatar.layer.borderWidth = 2;
        _avatar.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;
        [_bgImgView addSubview:_avatar];
        
        _userName = [UILabel newAutoLayoutView];
        _userName.textColor = [UIColor whiteColor];
        _userName.textAlignment = NSTextAlignmentLeft;
        _userName.font = CUSNEwFONT(16);
        [_bgImgView addSubview:_userName];
        
        _footImgV = [UIImageView newAutoLayoutView];
        _footImgV.image = [UIImage imageNamed:@"piazza_headerView_footBgView"];
        _footImgV.userInteractionEnabled = true;
        [_bgImgView addSubview:_footImgV];
        
        _lineArr = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            UIView *line = [UIView newAutoLayoutView];
            line.backgroundColor = [UIColor whiteColor];
            [_footImgV addSubview:line];
            [_lineArr addObject:line];
        }
        
        _countLableArr = [NSMutableArray array];
        _desLableArr = [NSMutableArray array];
        _btnArr = [NSMutableArray array];
        for (int i = 0; i < 4; i++) {
            UILabel *countLable = [UILabel newAutoLayoutView];
            countLable.textColor = [UIColor whiteColor];
            countLable.font = CUSNEwFONT(14);
            countLable.textAlignment = NSTextAlignmentCenter;
            [_footImgV addSubview:countLable];
            [_countLableArr addObject:countLable];
            
            UILabel *desLable = [UILabel newAutoLayoutView];
            desLable.textColor = [UIColor whiteColor];
            desLable.font = CUSNEwFONT(14);
            desLable.textAlignment = NSTextAlignmentCenter;
            [_footImgV addSubview:desLable];
            [_desLableArr addObject:desLable];
            
            UIButton *btn = [UIButton newAutoLayoutView];
            btn.tag = i;
            [btn addTarget:self action:@selector(btnActionHandle:) forControlEvents:UIControlEventTouchUpInside];
            [_footImgV addSubview:btn];
            [_btnArr addObject:btn];
        }
        
        [self updateConstraints];
    }
    return self;
}

-(void)btnActionHandle:(UIButton *)btn{
    UserPiazzaDetailsHeaderViewBtnActionBlock block = _headerBtnActionHandle;
    if (block) {
        block(btn.tag);
    }
}

-(void)setupInfoWithUserPiazzaInfoData:(UserPiazzaInfoData *)item{
    UserInfo *info = [Utils getUserInfo];
    [_avatar sd_setImageWithURL:[NSURL URLWithString:item.avastar] placeholderImage:placeholderImage_avatar options:0];
    _userName.text = item.nickName;
    if ([info.userId isEqualToString:item.userId]) {//自己
        NSArray *desNameArr = @[@"关注",@"粉丝",@"收藏",@"赞"];
        NSArray *countStrArr = @[item.concernsCount,item.beConcernsCount,item.collectCount,item.likeCount];
        for (int i = 0; i < 4; i++) {
            UILabel *countLable = _countLableArr[i];
            countLable.text = countStrArr[i];
            UILabel *desLable = _desLableArr[i];
            desLable.text = desNameArr[i];
        }
    }else{//别人
        NSArray *desNameArr = @[@"关注",@"粉丝",@"被收藏",@"被赞"];
        NSArray *countStrArr = @[item.concernsCount,item.beConcernsCount,item.beCollectCount,item.beLikeCount];
        for (int i = 0; i < 4; i++) {
            UILabel *countLable = _countLableArr[i];
            countLable.text = countStrArr[i];
            UILabel *desLable = _desLableArr[i];
            desLable.text = desNameArr[i];
        }
    }
}


- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(224.0)];
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(142.0)];
        [_avatar autoSetDimension:ALDimensionWidth toSize:FitHeight(140.0)];
        [_avatar autoSetDimension:ALDimensionHeight toSize:FitHeight(140.0)];
        
        [_userName autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_avatar];
        [_userName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avatar withOffset:FitWith(40.0)];
        [_userName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        
        [_footImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_footImgV autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_footImgV autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_footImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(132.0)];
        
        CGFloat lableWidth = mainScreenWidth/4;
        
        for (int i = 0; i < 3; i++) {
            UIView *line = _lineArr[i];
            [line autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(42.0)];
            [line autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(42.0)];
            [line autoSetDimension:ALDimensionWidth toSize:1];
            [line autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset: lableWidth * (i + 1)];
        }
        
        for (int i = 0; i < 4; i++) {
            UIView *countLble = _countLableArr[i];
            [countLble autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
            [countLble autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset: lableWidth * i];
            [countLble autoSetDimension:ALDimensionWidth toSize:lableWidth];
            
            UIView *desLable = _desLableArr[i];
            [desLable autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(30.0)];
            [desLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset: lableWidth * i];
            [desLable autoSetDimension:ALDimensionWidth toSize:lableWidth];
            
            UIButton *btn = _btnArr[i];
            [btn autoPinEdgeToSuperviewEdge:ALEdgeTop];
            [btn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
            [btn autoSetDimension:ALDimensionWidth toSize:lableWidth];
            [btn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:lableWidth * i];
        }
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
