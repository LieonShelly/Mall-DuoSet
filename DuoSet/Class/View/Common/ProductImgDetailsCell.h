//
//  ProductImgDetailsCell.h
//  DuoSet
//
//  Created by mac on 2017/1/19.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailsData.h"

@interface ProductImgDetailsCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withProductDetailsData:(ProductDetailsData *)item;

@end
