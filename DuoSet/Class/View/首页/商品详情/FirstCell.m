//
//  OneCell.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/12.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "FirstCell.h"

@implementation FirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //[self initViews];
   
}
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        [self initViews];
//    }
//    return self;
//
//}
////-(instancetype)initWithFrame:(CGRect)frame{
////    self = [super initWithFrame:frame];
////    if (self){
////        [self initViews];
////        
////    }
////}
//
//- (void) initViews{
////    self.backgroundColor = [UIColor redColor];
//    _headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, 120)];
//    [self.contentView addSubview:_headerImgView];
//    
//    
//    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, _headerImgView.frame.size.height+5, mainScreenWidth-30, 50)];
//    [self.contentView addSubview:_nameLabel];
//    _nameLabel.numberOfLines = 0;
//    CGFloat labelW = (mainScreenWidth - 30)/5;
//    
//    _carriageLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, _nameLabel.frame.size.height+_nameLabel.frame.origin.y, labelW, 20)];
//    _carriageLabel.font = [UIFont systemFontOfSize:13];
//    [self.contentView addSubview:_carriageLabel];
//    
//    _fromCityLabel = [[UILabel alloc] initWithFrame:CGRectMake(_carriageLabel.frame.origin.x+_carriageLabel.frame.size.width+labelW , _nameLabel.frame.size.height+_nameLabel.frame.origin.y, labelW, 20)];
//    _fromCityLabel.font = [UIFont systemFontOfSize:13];
//    [self.contentView addSubview:_fromCityLabel];
//    
//    _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(mainScreenWidth-15-labelW, _nameLabel.frame.size.height+_nameLabel.frame.origin.y, labelW, 20)];
//    [self.contentView addSubview:_countLabel];
//    _countLabel.font = [UIFont systemFontOfSize:13];
//    
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
