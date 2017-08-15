//
//  ColorSizeAmountView.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/22.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "ColorSizeAmountView.h"
#import "ProductStandards.h"

@interface ColorSizeAmountView()

@property (nonatomic, assign) NSUInteger amount;
@property (nonatomic, strong) NSArray *sizeBtnArr;
@property (nonatomic, strong) NSArray *colorBtnArr;

@end

@implementation ColorSizeAmountView

-(void)awakeFromNib{
    [super awakeFromNib];
    _amount = 1;
    _colorBtnArr = @[_colorBtn1,_colorBtn2,_colorBtn3,_colorBtn4,_colorBtn5,_colorBtn6,_colorBtn7,_colorBtn8];
    _sizeBtnArr = @[_sizeBtn1,_sizeBtn2,_sizeBtn3,_sizeBtn4,_sizeBtn5,_sizeBtn6,_sizeBtn7,_sizeBtn8];
    for (int i = 0; i < _colorBtnArr.count; i++) {
        UIButton *btn = _colorBtnArr[i];
        btn.hidden = true;
        btn.tag = i;
        [btn addTarget:self action:@selector(colorBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    for (int i = 0; i < _sizeBtnArr.count; i++) {
        UIButton *btn = _sizeBtnArr[i];
        btn.hidden = true;
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(sizeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)sizeBtnAction:(UIButton *)btn{
    for (UIButton *b in _sizeBtnArr) {
        b.selected = b.tag == btn.tag;
    }
}

-(void)colorBtnAction:(UIButton *)btn{
    for (UIButton *b in _colorBtnArr) {
        b.selected = b.tag == btn.tag;
    }
}

- (IBAction)sureBuyAction:(id)sender {
    NSInteger i = -1;
    for (UIButton *btn in _sizeBtnArr) {
        if (btn.selected) {
            i = btn.tag >= 100 ? btn.tag - 100 : btn.tag;
        }
    }
    NSInteger j = -1;
    for (UIButton *btn in _colorBtnArr) {
        if (btn.selected) {
            j = btn.tag >= 100 ? btn.tag - 100 : btn.tag;
        }
    }
    if (i >= 0 && j >= 0) {
        AddItemBlock block = _addHandle;
        if (block) {
            block(i,j,_amount);
        }
    }
}

- (IBAction)addAmountAction:(id)sender {
    _amount = [_amountLabel.text intValue];
    _amount++;
    _amountLabel.text = [NSString stringWithFormat:@"%ld", _amount];
}
- (IBAction)jianAmountAction:(id)sender {
    _amount = [_amountLabel.text intValue];
    if (_amount == 1) {
        return;
    }
    _amount--;
    _amountLabel.text = [NSString stringWithFormat:@"%ld", _amount];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.frame = CGRectMake(0, mainScreenHeight, mainScreenWidth, mainScreenHeight);
    } completion:nil];
}

-(void)retDataWithStandardArr:(NSMutableArray *)arr{
    
    if (arr.count > 0) {
        ProductStandards *standarsd = arr[0];
        _colorTextLable.text = standarsd.name;
        for (int i = 0; i < standarsd.items.count; i++) {
            UIButton *btn = _colorBtnArr[i];
            btn.hidden = false;
            Standard *s = standarsd.items[i];
            [btn setTitle:s.name forState:UIControlStateNormal];
        }
    }
    if (arr.count > 1) {
        ProductStandards *standarsd = arr[1];
        _sizeTextLable.text = standarsd.name;
        for (int i = 0; i < standarsd.items.count; i++) {
            UIButton *btn = _sizeBtnArr[i];
            btn.hidden = false;
            Standard *s = standarsd.items[i];
            [btn setTitle:s.name forState:UIControlStateNormal];
        }
    }
}

@end
