//
//  MenuAddressCell.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/15.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "MenuAddressCell.h"

@implementation MenuAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self){
        [self initViews];
    }
    return self;
}

- (void) initViews{
    CGFloat viewW = 288*AdapterWidth();
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10*AdapterWidth(), 13*AdapterWidth(), viewW-30, 16*AdapterWidth())];
    [self.contentView addSubview:label];
    label.font = [UIFont systemFontOfSize:15*AdapterWidth()];
    label.textColor = [UIColor colorWithHexString:@"222222"];
    label.text = @"发货地";
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10*AdapterWidth(), label.frame.size.height+label.frame.origin.y+20, 62*AdapterWidth(), 30*AdapterWidth())];
    btn.layer.cornerRadius = 2;
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 40);
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    NSDictionary * dict = @{NSFontAttributeName:[UIFont systemFontOfSize:12*AdapterWidth()],
                            NSForegroundColorAttributeName:[UIColor colorWithHexString:@"222222"]};
    NSAttributedString * str = [[NSAttributedString alloc]initWithString:@"成都" attributes:dict];
    [btn setAttributedTitle:str forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithHexString:@"f0f2f3"];
    [btn setImage:IMAGE_NAME(@"surrounding") forState:UIControlStateNormal];
    [self.contentView addSubview:btn];
}
@end
