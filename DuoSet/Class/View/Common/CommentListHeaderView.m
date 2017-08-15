//
//  CommentListHeaderView.m
//  DuoSet
//
//  Created by fanfans on 2017/3/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CommentListHeaderView.h"

@interface CommentListHeaderView()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) NSMutableArray *btnArr;
@property(nonatomic,strong) NSMutableArray *countLableArr;
@property(nonatomic,strong) UIView *line;

@end

@implementation CommentListHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _btnArr = [NSMutableArray array];
        NSArray *nameArr = @[@"全部",@"好评",@"中评",@"差评",@"有图"];
        _countLableArr = [NSMutableArray array];
        
        for (int i = 0; i < 5; i++) {
            UIButton *btn = [UIButton newAutoLayoutView];
            btn.titleLabel.font = CUSFONT(12);
            [btn setTitleColor:[UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor mainColor] forState:UIControlStateSelected];
            [btn setTitle:nameArr[i] forState:UIControlStateNormal];
            btn.tag = i;
            [btn addTarget:self action:@selector(btnAcion:) forControlEvents:UIControlEventTouchUpInside];
            [_btnArr addObject:btn];
            [self addSubview:btn];
            
            UILabel *countLable = [UILabel newAutoLayoutView];
            countLable.font = CUSFONT(10);
            countLable.textAlignment = NSTextAlignmentCenter;
            countLable.textColor = [UIColor colorFromHex:0x222222];
            countLable.tag = i;
            [_countLableArr addObject:countLable];
            [self addSubview:countLable];
            
            if (i == 0) {
                btn.selected = true;
                countLable.textColor = [UIColor mainColor];
            }
        }
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self addSubview:_line];
        
        [self updateConstraints];
    }
    return self;
}

-(void)setCountLableContentWithCountArr:(NSArray *)countArr{
    for (int i = 0; i < 5; i++) {
        UILabel *lable = _countLableArr[i];
        lable.text = countArr[i];
    }
}

-(void)btnAcion:(UIButton *)button{
    for (int i = 0; i < 5; i++) {
        UIButton *btn = _btnArr[i];
        UILabel *lable = _countLableArr[i];
        btn.selected = btn.tag == button.tag;
        lable.textColor = lable.tag == button.tag ? [UIColor mainColor] : [UIColor colorFromHex:0x222222];
    }
    CommentHeaderViewBtnActionBlock block = _btnActionHandle;
    if (block) {
        block(button.tag);
    }
}

//Layout
- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        for (int i = 0; i < 5; i++) {
            UIButton *btn = _btnArr[i];
            
            [btn autoPinEdgeToSuperviewEdge:ALEdgeTop];
            [btn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:(mainScreenWidth / 5) * i];
            [btn autoSetDimension:ALDimensionHeight toSize:FitHeight(50.0)];
            [btn autoSetDimension:ALDimensionWidth toSize:mainScreenWidth / 5];
            
            UILabel *lable = _countLableArr[i];
            [lable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:btn];
            [lable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:(mainScreenWidth / 5) * i];
            [lable autoSetDimension:ALDimensionWidth toSize:mainScreenWidth / 5];
        }
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}


@end
