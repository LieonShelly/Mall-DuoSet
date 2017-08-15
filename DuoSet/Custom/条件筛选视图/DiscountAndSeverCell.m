//
//  DiscountAndSeverCell.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/15.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "DiscountAndSeverCell.h"

@implementation DiscountAndSeverCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initViews];
    }
    return self;
}

- (void) initViews{
    CGFloat viewW = 288*AdapterWidth();
    CGFloat viewH = self.contentView.frame.size.height;
    NSLog(@"%f", viewW);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10*AdapterWidth(), 20, viewW-30, 20*AdapterWidth())];
    label.font = [UIFont systemFontOfSize:15*AdapterWidth()];
    label.textColor = [UIColor colorWithHexString:@"222222"];
    [self.contentView addSubview:label];
    label.text = @"折扣和服务";
    
    CGFloat centerMargin = 5*AdapterWidth();
    CGFloat leftMargin = 10*AdapterWidth();
    CGFloat btnW = 130*AdapterWidth();
    NSLog(@"%f", btnW);
    CGFloat btnH = 34*AdapterWidth();
    int index = 101;
    for (int i=0; i<2; i++) {
        for (int j=0; j<2; j++) {
            
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftMargin+(btnW+centerMargin)*i, 2*leftMargin+(leftMargin+btnH)*j+label.frame.origin.y+label.frame.size.height, btnW, btnH)];
            [btn setTitle: @"7天无理由" forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            btn.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
            NSDictionary * dict = @{NSFontAttributeName:[UIFont systemFontOfSize:12*AdapterWidth()],
                                    NSForegroundColorAttributeName:[UIColor colorWithHexString:@"222222"]};
            NSAttributedString * str = [[NSAttributedString alloc]initWithString:@"7天无理由" attributes:dict];
            [btn setAttributedTitle:str forState:UIControlStateNormal];
            btn.tag = index;
            btn.layer.cornerRadius = 4*AdapterWidth();
            index++;
            [self.contentView addSubview:btn];
        }
    }    
}


@end
