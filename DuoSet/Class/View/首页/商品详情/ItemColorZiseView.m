//
//  ItemColorZiseView.m
//  DuoSet
//
//  Created by fanfans on 12/27/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import "ItemColorZiseView.h"

@interface ItemColorZiseView()

@property (nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIImageView *itemImgV;
@property(nonatomic,strong) UILabel *priceLable;
@property(nonatomic,strong) UILabel *sizeTextLable;
@property(nonatomic,strong) UILabel *colorTextLable;
@property(nonatomic,strong) UILabel *amountTextLable;
@property(nonatomic,strong) UILabel *seletedAmountTextLable;
@property(nonatomic,strong) UIButton *plusBtn;
@property(nonatomic,strong) UIButton *subtractBtn;

@property(nonatomic,strong) UIButton *sizeBtn1;
@property(nonatomic,strong) UIButton *sizeBtn2;
@property(nonatomic,strong) UIButton *sizeBtn3;
@property(nonatomic,strong) UIButton *sizeBtn4;
@property(nonatomic,strong) UIButton *sizeBtn5;
@property(nonatomic,strong) UIButton *sizeBtn6;
@property(nonatomic,strong) UIButton *sizeBtn7;
@property(nonatomic,strong) UIButton *sizeBtn8;

@property(nonatomic,strong) UIButton *colorBtn1;
@property(nonatomic,strong) UIButton *colorBtn2;
@property(nonatomic,strong) UIButton *colorBtn3;
@property(nonatomic,strong) UIButton *colorBtn4;
@property(nonatomic,strong) UIButton *colorBtn5;
@property(nonatomic,strong) UIButton *colorBtn6;
@property(nonatomic,strong) UIButton *colorBtn7;
@property(nonatomic,strong) UIButton *colorBtn8;

@end


@implementation ItemColorZiseView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _itemImgV = [UIImageView newAutoLayoutView];
        [self addSubview:_itemImgV];
        
        
        
    }
    return self;
}

@end
