//
//  AddressCell.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/8.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

@interface AddressCell : UITableViewCell

-(void)setupInfoWithAddressModel:(AddressModel *)item;

@end
