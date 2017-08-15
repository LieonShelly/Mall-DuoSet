//
//  CommonSievingSectionView.m
//  DuoSet
//
//  Created by mac on 2017/1/18.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CommonSievingSectionView.h"

@interface CommonSievingSectionView()

@property(nonatomic,strong) UIButton *synthesizeBtn;
@property(nonatomic,strong) UIButton *saleBtn;
@property(nonatomic,strong) UIButton *priceBtn;
@property(nonatomic,strong) UIButton *humanBtn;
@property(nonatomic,strong) NSMutableArray *btnArr;

@end

@implementation CommonSievingSectionView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _btnArr = [NSMutableArray array];
        
        _synthesizeBtn = [[UIButton alloc]init];
        [_btnArr addObject:_synthesizeBtn];
        
        _saleBtn = [[UIButton alloc]init];
        [_btnArr addObject:_saleBtn];
        
        _priceBtn = [[UIButton alloc]init];
        [_btnArr addObject:_priceBtn];
        
        _humanBtn = [[UIButton alloc]init];
        [_btnArr addObject:_humanBtn];
        
        NSArray *btnNameArr = @[@"综合",@"销量",@"价格",@"人气"];
        NSArray *btnNomImgArr = @[@"more_1-no_click.png",@"",@"more_2-no_click.png",@""];
        NSArray *btnseletcedImgArr = @[@"more_1",@"more_2.png",@"list_product_up_red",@"screening.png"];
        
        for (int i = 0; i < 4; i++) {
            UIButton *btn = _btnArr[i];
            btn.frame = CGRectMake((mainScreenWidth / 4) * i, 0, mainScreenWidth / 4, FitHeight(100.0));
            btn.tag = i;
            btn.titleLabel.font = CUSFONT(12);
            if (i == 0 || i == 2) {
                [btn setImage:[UIImage imageNamed:btnNomImgArr[i]] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:btnseletcedImgArr[i]] forState:UIControlStateSelected];
            }
            [btn setTitle:btnNameArr[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor mainColor] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnActionHandle:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0 || i == 2) {
                [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -55)];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
            }
            [self addSubview:btn];
        }
        UIView *downline = [[UIView alloc]initWithFrame:CGRectMake(0, FitHeight(100.0) - 0.5, mainScreenWidth, 0.5)];
        downline.backgroundColor = [UIColor colorFromHex:0xe8e8e8];
        [self addSubview:downline];
        
        UIView *upline = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 0.5)];
        upline.backgroundColor = [UIColor colorFromHex:0xe8e8e8];
        [self addSubview:upline];
    }
    return self;
}

-(void)btnActionHandle:(UIButton *)btn{
    if (btn == _priceBtn) {
        for (UIButton *b in _btnArr) {
            if (b != btn) {
                b.selected = false;
            }
        }
        [btn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        [_priceBtn setImage:[UIImage imageNamed:@"list_product_up_red"] forState:UIControlStateNormal];
        [_priceBtn setImage:[UIImage imageNamed:@"list_product_down_red"] forState:UIControlStateSelected];
        _priceBtn.selected = !_priceBtn.selected;
        NSLog(@"_priceBtn.selected 选中状态  %d",_priceBtn.selected);
    }else{
        for (UIButton *b in _btnArr) {
            b.selected = b.tag == btn.tag;
        }
        NSLog(@"_priceBtn.selected 选中状态  %d",_priceBtn.selected);
        [_priceBtn setImage:[UIImage imageNamed:@"more_2-no_click.png"] forState:UIControlStateNormal];
        [_priceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_priceBtn setTitleColor:[UIColor mainColor] forState:UIControlStateSelected];
    }
    ScreenSectionViewBlock block = _seletcedHandle;
    if (block) {
        block(btn.tag,btn);
    }
}

-(void)dealloc{
    NSLog(@"dealloc");
}

@end
