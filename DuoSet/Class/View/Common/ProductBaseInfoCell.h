//
//  ProductBaseInfoCell.h
//  DuoSet
//
//  Created by mac on 2017/1/19.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailsData.h"

@interface ProductBaseInfoCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withProductDetailStyle:(ProductDetailStyle)status;

-(void)setupInfoWithProductDetailsData:(ProductDetailsData *)item;

@end
