//
//  ShangPinCell.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/8.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "ShangPinCell.h"
#import "Product.h"

@implementation ShangPinCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupInfoWithItemDic:(NSMutableDictionary *)dic{
    Product *product = dic[@"Product"];
//    NSNumber *standard1 = dic[@"standard1"];
    NSString *standard2 = [NSString stringWithFormat:@"%@",dic[@"standard2"]];
    NSNumber *amount = dic[@"amount"];
    [_iconImgView sd_setImageWithURL:[NSURL URLWithString:product.productDetail.smallImg] placeholderImage:[UIImage imageNamed:@"数据加载失败"] options:0];
    _nameLabel.text = product.productDetail.name;
    _countLabel.text = [NSString stringWithFormat:@"数量: X%@",amount];
    ProductStandards *standard = product.productDetail.standardsArr[1];
    Standard *s = standard.items[standard2.integerValue];
    _colorLabel.text = s.name;
}

@end
