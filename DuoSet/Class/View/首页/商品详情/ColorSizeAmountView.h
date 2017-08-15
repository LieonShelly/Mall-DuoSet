//
//  ColorSizeAmountView.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/22.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddItemBlock)(NSInteger a, NSInteger b, NSInteger amount);

@interface ColorSizeAmountView : UIView
@property (weak, nonatomic) IBOutlet UILabel *colorTextLable;
@property (weak, nonatomic) IBOutlet UILabel *sizeTextLable;

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UIButton *colorBtn1;
@property (weak, nonatomic) IBOutlet UIButton *colorBtn2;
@property (weak, nonatomic) IBOutlet UIButton *colorBtn3;
@property (weak, nonatomic) IBOutlet UIButton *colorBtn4;
@property (weak, nonatomic) IBOutlet UIButton *colorBtn5;
@property (weak, nonatomic) IBOutlet UIButton *colorBtn6;
@property (weak, nonatomic) IBOutlet UIButton *colorBtn7;
@property (weak, nonatomic) IBOutlet UIButton *colorBtn8;
@property (weak, nonatomic) IBOutlet UIButton *sizeBtn1;
@property (weak, nonatomic) IBOutlet UIButton *sizeBtn2;
@property (weak, nonatomic) IBOutlet UIButton *sizeBtn3;

@property (weak, nonatomic) IBOutlet UIButton *sizeBtn4;

@property (weak, nonatomic) IBOutlet UIButton *sizeBtn5;
@property (weak, nonatomic) IBOutlet UIButton *sizeBtn6;

@property (weak, nonatomic) IBOutlet UIButton *sizeBtn7;

@property (weak, nonatomic) IBOutlet UIButton *sizeBtn8;

@property (weak, nonatomic) IBOutlet UIButton *addAmountBtn;
@property (weak, nonatomic) IBOutlet UIButton *jianAmountBtn;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (nonatomic,copy) AddItemBlock addHandle;

-(void)retDataWithStandardArr:(NSMutableArray *)arr;

@end
