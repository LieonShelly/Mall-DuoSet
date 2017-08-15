//
//  YouhuiJUanCell.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/7.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "PersonYouhuiJuanCell.h"

@implementation PersonYouhuiJuanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _xuanzhongBtn.layer.cornerRadius = 5;
    _xuanzhongBtn.layer.borderColor = [[UIColor grayColor] CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)useBtn:(id)sender {
    _xuanzhongBtn.backgroundColor = [UIColor redColor];
    
    
}



@end
