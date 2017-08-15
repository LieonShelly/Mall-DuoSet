//
//  DesigningHeaderView.m
//  DuoSet
//
//  Created by fanfans on 2017/3/20.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DesigningHeaderView.h"
#import "DesignerView.h"
#import "DesignerData.h"

@interface DesigningHeaderView()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *topBgView;
@property(nonatomic,strong) UIButton *leftBtn;
@property(nonatomic,strong) UIButton *rightBtn;
@property(nonatomic,strong) UIView *HorizontalLine;
@property(nonatomic,strong) UIView *topBgLine;
@property(nonatomic,strong) UIImageView *avatarImgV;

@property(nonatomic,strong) UILabel *titleLable;

@property(nonatomic,strong) UIScrollView *bgScrollView;
@property(nonatomic,strong) NSMutableArray *DeserViewArr;

@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) NSMutableArray *choiceBtnArr;
@property(nonatomic,strong) NSMutableArray *choiceMarkBtnArr;

@property(nonatomic,assign) DesignerStatus designerType;


@end

@implementation DesigningHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
        
        _topBgView = [UIView newAutoLayoutView];
        _topBgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_topBgView];
        
        _leftBtn = [UIButton newAutoLayoutView];
        _leftBtn.titleLabel.font = CUSFONT(14);
        [_leftBtn setImage:[UIImage imageNamed:@"Design_auto_img"] forState:UIControlStateNormal];
        [_leftBtn setTitle:@"设计师认证" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
        _leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        _leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
        _leftBtn.tag = 0;
        [_leftBtn addTarget:self action:@selector(topBtnAciton:) forControlEvents:UIControlEventTouchUpInside];
        [_topBgView addSubview:_leftBtn];
        
        _avatarImgV = [UIImageView newAutoLayoutView];
        _avatarImgV.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImgV.layer.masksToBounds = true;
        _avatarImgV.layer.cornerRadius = FitHeight(80.0) * 0.5;
        [_leftBtn addSubview:_avatarImgV];
        
        _rightBtn = [UIButton newAutoLayoutView];
        _rightBtn.titleLabel.font = CUSFONT(14);
        [_rightBtn setImage:[UIImage imageNamed:@"Design_send_obj"] forState:UIControlStateNormal];
        [_rightBtn setTitle:@"设计师投稿" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
        _rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        _rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
        _rightBtn.tag = 1;
        [_rightBtn addTarget:self action:@selector(topBtnAciton:) forControlEvents:UIControlEventTouchUpInside];
        [_topBgView addSubview:_rightBtn];
        
        _HorizontalLine = [UIView newAutoLayoutView];
        _HorizontalLine.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [_topBgView addSubview:_HorizontalLine];
        
        _topBgLine = [UIView newAutoLayoutView];
        _topBgLine.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [_topBgView addSubview:_topBgLine];
        
        _titleLable = [UILabel newAutoLayoutView];
        _titleLable.textColor = [UIColor colorFromHex:0x222222];
        _titleLable.text = @"排行榜";
        _titleLable.font = CUSFONT(15);
        _titleLable.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLable];
        
        _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,FitHeight(190.0), mainScreenWidth, FitHeight(330.0))];
        _bgScrollView.showsHorizontalScrollIndicator = false;
        _bgScrollView.contentSize = CGSizeMake(FitWith(320.0) * 10, 0);
        [self addSubview:_bgScrollView];
        
        _DeserViewArr = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            DesignerView *view = [DesignerView newAutoLayoutView];
            view.backgroundColor = [UIColor mainColor];
            view.userInteractionEnabled = true;
            view.tag = i;
            UITapGestureRecognizer*singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
            singleRecognizer.numberOfTapsRequired = 1;
            [view addGestureRecognizer:singleRecognizer];
            view.markBtn.tag = i;
            [view.markBtn addTarget:self action:@selector(attentionBtnAciton:) forControlEvents:UIControlEventTouchUpInside];
            [_bgScrollView addSubview:view];
            [_DeserViewArr addObject:view];
        }
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self addSubview:_line];
        
        _choiceBtnArr = [NSMutableArray array];
        NSArray *nameArr = @[@"哆集设计师",@"特色设计师",@"品牌设计师"];
        for (int i = 0; i < 3; i++) {
            UIButton *btn = [UIButton newAutoLayoutView];
            btn.titleLabel.font = CUSFONT(13);
            btn.layer.cornerRadius = FitHeight(70.0) * 0.5;
            btn.layer.borderColor = [UIColor mainColor].CGColor;
            btn.layer.borderWidth  = 1;
            btn.tag = i;
            [btn setTitle:nameArr[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(designerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_choiceBtnArr addObject:btn];
            [self addSubview:btn];
        }
        
        [self updateConstraints];
    }
    return self;
}

-(void)attentionBtnAciton:(UIButton *)btn{
    AttentionBtnActionBlock block = _attentionBtnActionHandle;
    if (block) {
        block(btn);
    }
}

-(void)setupInfoWithDesignerStatus:(DesignerStatus)designerType andDesignerData:(DesignerData *)item{
    if (designerType == DesignerStatusCheckSucceed) {
        [_leftBtn setTitle:item.name forState:UIControlStateNormal];
        [_leftBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_avatarImgV sd_setImageWithURL:[NSURL URLWithString:item.avastar] placeholderImage:placeholderImage_avatar options:0];
    }
}


-(void)setupInfoWithDesignerDataArr:(NSMutableArray *)items{
    _bgScrollView.contentSize = CGSizeMake(FitWith(320.0) * items.count, 0);
    for (int i = 0; i < 10; i++) {
        DesignerView *view = _DeserViewArr[i];
        if (i < 3) {
            view.tagImgV.hidden = false;
            if (i == 0) {
                view.tagImgV.image = [UIImage imageNamed:@"Design_first_tag"];
            }
            if (i == 1) {
                view.tagImgV.image = [UIImage imageNamed:@"Design_second_tag"];
            }
            if (i == 2) {
                view.tagImgV.image = [UIImage imageNamed:@"Design_three_tag"];
            }
        }else{
            view.tagImgV.hidden = true;
        }
        if (i >= items.count) {
            view.hidden = true;
        }else{
            view.hidden = false;
            DesignerData *item = items[i];
            [view setupInfoWithDesignerData:item];
        }
    }
}


-(void)designerBtnAction:(UIButton *)btn{
    DesignerBtnActionBlock block = _designerHandle;
    if (block) {
        block(btn.tag);
    }
}

-(void)topBtnAciton:(UIButton *)btn{
    DesignerTopBtnBlock block =  _topHandle;
    if (block) {
        block(btn.tag);
    }
}

-(void)SingleTap:(UITapGestureRecognizer *)tap{
    DesignerChoiceBlock block = _designerChoiceHandle;
    if (block) {
        block(tap.view.tag);
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_topBgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_topBgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_topBgView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_topBgView autoSetDimension:ALDimensionHeight toSize:FitHeight(100.0)];
        
        [_leftBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_leftBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_leftBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_topBgView];
        [_leftBtn autoSetDimension:ALDimensionWidth toSize:mainScreenWidth * 0.5];
        
        [_avatarImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10.0)];
        [_avatarImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(80.0)];
        [_avatarImgV autoSetDimension:ALDimensionWidth toSize:FitHeight(80.0)];
        [_avatarImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(60.0)];
        
        [_rightBtn autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_rightBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_rightBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_topBgView];
        [_rightBtn autoSetDimension:ALDimensionWidth toSize:mainScreenWidth * 0.5];
        
        [_HorizontalLine autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_HorizontalLine autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_HorizontalLine autoSetDimension:ALDimensionWidth toSize:1];
        [_HorizontalLine autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [_topBgLine autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_topBgLine autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_topBgLine autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_topBgLine autoSetDimension:ALDimensionHeight toSize:1];
        
        [_titleLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_titleLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_topBgView];
        [_titleLable autoSetDimension:ALDimensionHeight toSize:FitHeight(90.0)];
        
        for (int i = 0; i < 10; i++) {
            DesignerView *view = _DeserViewArr[i];
            [view autoPinEdgeToSuperviewEdge:ALEdgeTop];
            [view autoSetDimension:ALDimensionWidth toSize:FitWith(300.0)];
            [view autoSetDimension:ALDimensionHeight toSize:FitHeight(330.0)];
            [view autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0) +( FitWith(300.0) + FitWith(16.0) ) * i];
        }
        
        [_line autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_bgScrollView withOffset:FitHeight(30.0)];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoSetDimension:ALDimensionHeight toSize:1];
        
        for (int i = 0; i < 3; i++) {
            UIButton *btn = _choiceBtnArr[i];
            [btn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_line withOffset:FitHeight(26.0)];
            [btn autoSetDimension:ALDimensionWidth toSize:FitWith(210.0)];
            [btn autoSetDimension:ALDimensionHeight toSize:FitHeight(70.0)];
            [btn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0) +( FitWith(210.0) + FitWith(36.0) ) * i];
        }
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}


@end
