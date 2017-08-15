//
//  ManagerAddressCell.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/8.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "ManagerAddressCell.h"

@implementation ManagerAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)updateAddresssAction:(id)sender {
    if (self.updateAddress) {
        self.updateAddress();
    }
}
- (IBAction)deleAddreeeAction:(id)sender {
    if (self.deleAddress){
        self.deleAddress();
    }
    
}
- (IBAction)setAddressState:(id)sender {
}


@end
