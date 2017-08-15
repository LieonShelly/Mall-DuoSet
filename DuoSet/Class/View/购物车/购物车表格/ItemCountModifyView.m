//
//  ItemCountModifyView.m
//  DuoSet
//
//  Created by fanfans on 2017/4/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ItemCountModifyView.h"

typedef void(^ModifyMinusBlock)(NSInteger);
typedef void(^ModifyPlusBlock)(NSInteger);
typedef void(^ModifyCountResultBlock)(NSInteger);

@interface ItemCountModifyView()

@property(nonatomic,copy) ModifyMinusBlock minusHandle;
@property(nonatomic,copy) ModifyPlusBlock plusHandle;
@property(nonatomic,copy) ModifyCountResultBlock resultHandle;
@property(nonatomic,strong) UILabel *minusLable;
@property(nonatomic,strong) UIButton *minusBtn;
@property(nonatomic,strong) UILabel *plusLable;
@property(nonatomic,strong) UIButton *plusBtn;


@property(nonatomic,assign) NSInteger maxCount;

@end

@implementation ItemCountModifyView

-(instancetype)initWithFrame:(CGRect)frame andMinusHandle:(void (^)(NSInteger minus))minusHandle andPlusHandle:(void (^)(NSInteger plus))plusHandle resultHandle:(void (^)(NSInteger result))resultHandle{
    self = [super initWithFrame:frame];
    if (self) {
        
        _minusHandle = minusHandle;
        _plusHandle = plusHandle;
        _resultHandle = resultHandle;
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 5, frame.size.width - 20, frame.size.height - 10)];
        bgView.layer.borderColor = [UIColor colorFromHex:0xcccccc].CGColor;
        bgView.layer.borderWidth = 1;
        bgView.layer.cornerRadius = 3;
        bgView.layer.masksToBounds = true;
        [self addSubview:bgView];
        
        _minusLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 25, bgView.frame.size.height)];
        _minusLable.textColor = [UIColor colorFromHex:0x222222];
        _minusLable.text = @"-";
        _minusLable.font = CUSFONT(16);
        _minusLable.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:_minusLable];
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(_minusLable.frame.size.width, 0, 1, bgView.frame.size.height)];
        line1.backgroundColor = [UIColor colorFromHex:0xcccccc];
        [bgView addSubview:line1];
        
        _countTextField = [[UITextField alloc]initWithFrame:CGRectMake(_minusLable.frame.size.width, 0, 30, bgView.frame.size.height)];
        _countTextField.textColor = [UIColor colorFromHex:0x222222];
        _countTextField.font = CUSFONT(13);
        _countTextField.textAlignment = NSTextAlignmentCenter;
        _countTextField.keyboardType = UIKeyboardTypeNumberPad;
        [bgView addSubview:_countTextField];
        
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(_countTextField.frame.size.width + _countTextField.frame.origin.x, 0, 1, bgView.frame.size.height)];
        line2.backgroundColor = [UIColor colorFromHex:0xcccccc];
        [bgView addSubview:line2];
        
        _plusLable = [[UILabel alloc]initWithFrame:CGRectMake(_countTextField.frame.origin.x + _countTextField.frame.size.width, 0, 25, bgView.frame.size.height)];
        _plusLable.textColor = [UIColor colorFromHex:0x222222];
        _plusLable.text = @"+";
        _plusLable.font = CUSFONT(16);
        _plusLable.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:_plusLable];
        
        _minusBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, FitWith(50) + 10, frame.size.height)];
        [_minusBtn addTarget:self action:@selector(minusBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_minusBtn];
        
        _plusBtn = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width - FitWith(50) - 10, 0, FitWith(50) + 10, frame.size.height)];
        [_plusBtn addTarget:self action:@selector(plusBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_plusBtn];
        
    }
    return self;
}

-(void)setupInfoWithCurrentCount:(NSString *)current andMaxCount:(NSString *)maxCount{
    _countTextField.text = current;
    _maxCount = maxCount.integerValue;
    if (current.integerValue <= 1 ) {
        _minusLable.textColor = [UIColor colorFromHex:0xcccccc];
        _plusLable.textColor = [UIColor colorFromHex:0x222222];
    }else{
        _minusLable.textColor = [UIColor colorFromHex:0x222222];
        if (current.integerValue >= _maxCount) {
            _plusLable.textColor = [UIColor colorFromHex:0xcccccc];
        }else{
            _plusLable.textColor = [UIColor colorFromHex:0x222222];
        }
    }
}

-(void)setupInfoWithCurrentCount:(NSString *)current{
    if (current.integerValue <= 1 ) {
        _minusLable.textColor = [UIColor colorFromHex:0xcccccc];
        _plusLable.textColor = [UIColor colorFromHex:0x222222];
    }else{
        _minusLable.textColor = [UIColor colorFromHex:0x222222];
        if (current.integerValue >= _maxCount) {
            _plusLable.textColor = [UIColor colorFromHex:0xcccccc];
        }else{
            _plusLable.textColor = [UIColor colorFromHex:0x222222];
        }
    }
    _countTextField.text = current;
}


-(void)minusBtnAction{
    if (_countTextField.text.integerValue <= 1) {
        return;
    }
    _minusHandle(_countTextField.text.integerValue);
}

-(void)plusBtnAction{
    if (_countTextField.text.integerValue >= _maxCount) {
        return;
    }
    _plusHandle(_countTextField.text.integerValue);
}

@end
