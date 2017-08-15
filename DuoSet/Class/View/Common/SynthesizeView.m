//
//  SynthesizeView.m
//  DuoSet
//
//  Created by mac on 2017/1/18.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SynthesizeView.h"

@interface SynthesizeView()

@property(nonatomic,strong) NSMutableArray *btnArr;
@property(nonatomic,strong) UIImageView *imgV;

@end

@implementation SynthesizeView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _btnArr = [NSMutableArray array];
        UIButton *choiceBtn1 = [[UIButton alloc]init];
        [_btnArr addObject:choiceBtn1];
        UIButton *choiceBtn2 = [[UIButton alloc]init];
        [_btnArr addObject:choiceBtn2];
        
        UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(48.0), 0, FitWith(400.0),  FitHeight(100.0))];
        lable1.text = @"综合排序";
        lable1.font = CUSFONT(12);
        lable1.textColor = [UIColor colorFromHex:0x333333];
        [self addSubview:lable1];
        
        UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(48.0), FitHeight(100.0), FitWith(400.0),  FitHeight(100.0))];
        lable2.text = @"新品优先";
        lable2.font = CUSFONT(12);
        lable2.textColor = [UIColor colorFromHex:0x333333];
        [self addSubview:lable2];
        
        _imgV = [[UIImageView alloc]initWithFrame:CGRectMake(mainScreenWidth - FitWith(150.0), 0, FitHeight(100.0), FitHeight(100.0))];
        _imgV.image = [UIImage imageNamed:@"cell_selected"];
        _imgV.contentMode = UIViewContentModeCenter;
        [self addSubview:_imgV];
        
        for (int i = 0; i < _btnArr.count; i++) {
            UIButton *btn = _btnArr[i];
            btn.tag = i;
            btn.frame = CGRectMake(0, FitHeight(80.0) * i, mainScreenWidth, FitHeight(80.0));
//            btn.titleLabel.font = CUSFONT(12);
//            [btn setTitleColor:[UIColor colorFromHex:0x333333] forState:UIControlStateNormal];
//            [btn setTitleColor:[UIColor mainColor] forState:UIControlStateSelected];
//            [btn setTitle:nameArr[i] forState:UIControlStateNormal];
//            [btn setImage:[UIImage imageNamed:@"cell_selected"] forState:UIControlStateSelected];
//            [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(choiceBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -FitWith(580.0), 0, 0)];
//            [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -FitWith(650.0))];
            if (i == 0) {
                btn.selected = true;
            }
            [self addSubview:btn];
        }
    }
    return self;
}

-(void)choiceBtnAction:(UIButton *)btn{
    for (UIButton *b in _btnArr) {
        b.selected = b.tag == btn.tag;
        if (b.selected) {
            CGRect frame = _imgV.frame;
            frame.origin.y = b.tag * FitHeight(100.0) ;
            _imgV.frame = frame;
        }
    }
    SynthesizeViewBlock block = _seletedHandle;
    if (block) {
        block(btn.tag);
    }
}


@end
