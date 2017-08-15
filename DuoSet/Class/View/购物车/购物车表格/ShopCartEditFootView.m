//
//  ShopCartEditFootView.m
//  DuoSet
//
//  Created by fanfans on 2017/6/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ShopCartEditFootView.h"

@interface ShopCartEditFootView()

@property(nonatomic,strong) UILabel *selectCountLbale;
@property(nonatomic,strong) UIButton *addcollectBtn;
@property(nonatomic,strong) UIButton *deleteBtn;

@end

@implementation ShopCartEditFootView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 0.5)];
        line.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
        [self addSubview:line];
        
        _allSelectedBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(10.0), 0, FitWith(130.0), frame.size.height)];
        _allSelectedBtn.tag = 0;
        _allSelectedBtn.titleLabel.font = CUSFONT(13);
        [_allSelectedBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_allSelectedBtn setImage:[UIImage imageNamed:@"choose_default"] forState:UIControlStateNormal];
        [_allSelectedBtn setImage:[UIImage imageNamed:@"choose_selected"] forState:UIControlStateSelected];
        [_allSelectedBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [_allSelectedBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5)];
        [_allSelectedBtn addTarget:self action:@selector(bottomBtnsAction:) forControlEvents:UIControlEventTouchUpInside];
        [_allSelectedBtn setTitleColor:[UIColor colorFromHex:0x212121] forState:UIControlStateNormal];
        _allSelectedBtn.tag = 0;
        [self addSubview:_allSelectedBtn];
        
        _selectCountLbale = [[UILabel alloc]initWithFrame:CGRectMake(_allSelectedBtn.frame.origin.x + _allSelectedBtn.frame.size.width, 0, mainScreenWidth - FitWith(10) - FitWith(130.0) - FitWith(370.0) , frame.size.height)];
        _selectCountLbale.textColor = [UIColor colorFromHex:0x333333];
        _selectCountLbale.textAlignment = NSTextAlignmentCenter;
        _selectCountLbale.font = CUSNEwFONT(18);
        [self addSubview:_selectCountLbale];
        
        _addcollectBtn = [[UIButton alloc]initWithFrame:CGRectMake(_selectCountLbale.frame.origin.x + _selectCountLbale.frame.size.width, 0, FitWith(185), frame.size.height)];
        _addcollectBtn.backgroundColor = [UIColor orangeColor];
        _addcollectBtn.titleLabel.font = CUSNEwFONT(18);
        [_addcollectBtn setTitle:@"加入收藏" forState:UIControlStateNormal];
        [_addcollectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addcollectBtn addTarget:self action:@selector(addCollectBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_addcollectBtn];
        
        _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(_addcollectBtn.frame.origin.x + _addcollectBtn.frame.size.width,0,FitWith(185.0), frame.size.height)];
        _deleteBtn.backgroundColor = [UIColor mainColor];
        _deleteBtn.titleLabel.font = CUSNEwFONT(18);
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_deleteBtn];
    }
    return self;
}

-(void)setupSeletcedShopCartDataWithCount:(NSInteger)count{
    NSString *countStr = [NSString stringWithFormat:@"%ld",count];
    NSString *text = [NSString stringWithFormat:@"已选(%ld)",count];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeString addAttribute:NSFontAttributeName value:CUSNEwFONT(18) range:NSMakeRange(3,countStr.length)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(3,countStr.length)];
    _selectCountLbale.attributedText = attributeString;
}

-(void)bottomBtnsAction:(UIButton *)btn{
    EditFootViewAllSelecteBtnActionBlock block = _editAllBtnHandle;
    if (block) {
        block(btn);
    }
}

-(void)addCollectBtnAction{
    EditFootViewAddCollectBtnActionBlock block = _collectBtnHandle;
    if (block) {
        block();
    }
}

-(void)deleteBtnAction{
    EditFootViewDeleteBtnActionBlock block = _deleteBtnHandle;
    if (block) {
        block();
    }
}

@end
