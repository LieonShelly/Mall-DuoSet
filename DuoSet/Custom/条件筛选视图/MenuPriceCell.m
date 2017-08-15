//
//  MenuPriceCell.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/15.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "MenuPriceCell.h"
@interface MenuPriceCell()

@end
@implementation MenuPriceCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initViews];
    }
    return self;
}

-(void) initViews {
    CGFloat viewW = 288*AdapterWidth();
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10*AdapterWidth(), 13*AdapterWidth(), viewW-30, 16*AdapterWidth())];
    label.font = [UIFont systemFontOfSize:15*AdapterWidth()];
    label.textColor = [UIColor colorWithHexString:@"222222"];
    [self.contentView addSubview:label];
    label.text = @"价格区间";
    CGFloat margin = 10*AdapterWidth();
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(margin, label.frame.origin.y+label.frame.size.height+14.5*AdapterWidth(), viewW-2*margin, 33*AdapterWidth())];
    [self.contentView addSubview:bgView];
    bgView.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    CGFloat bgViewW = bgView.frame.size.width;
    CGFloat textFieldW = (bgViewW - 14*5*AdapterWidth())/2;
    int index=101;
    NSArray *placeWord = @[@"最低价", @"最高价"];
    for (int i=0; i<2; i++) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(5+(textFieldW+12*5)*i, 4*AdapterWidth(), textFieldW, 25*AdapterWidth())];
        textField.tag = index+i;
        textField.backgroundColor = [UIColor whiteColor];
        textField.layer.cornerRadius = 2;
        bgView.layer.cornerRadius = 2;
        textField.font = [UIFont systemFontOfSize:12*AdapterWidth()];
        textField.textColor = [UIColor colorWithHexString:@"222222"];
        textField.placeholder = placeWord[i];
        textField.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:textField];
    }
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(5+textFieldW+5*4, (bgView.frame.size.height-2)/2, 5*4, 2)];
    [bgView addSubview:centerView];
    centerView.backgroundColor = [UIColor colorWithHexString:@"acaaad"];
    CGFloat btnW = (viewW-4*margin)/3;
    int labelIndex = 201;
    int btnIndex = 301;
    for (int i=0; i<3; i++) {
        UIView *bgView2 = [[UIView alloc] initWithFrame:CGRectMake(margin+(margin+btnW)*i, margin+bgView.frame.origin.y+bgView.frame.size.height, btnW, 40*AdapterWidth())];
        [self.contentView addSubview:bgView2];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, btnW, 20)];
        label.font = [UIFont systemFontOfSize:14*AdapterWidth()];
        label.textColor = [UIColor colorWithHexString:@"222222"];
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = labelIndex+i;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, btnW, 15)];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.backgroundColor = [UIColor colorWithHexString:@"f2f0f3"];
        btn.tag = btnIndex+i;
        [bgView2 addSubview:label];
        [bgView2 addSubview:btn];
        bgView2.backgroundColor = [UIColor colorWithHexString:@"f2f0f3"];
        bgView2.layer.cornerRadius = 4*AdapterWidth();
    }
}
@end
