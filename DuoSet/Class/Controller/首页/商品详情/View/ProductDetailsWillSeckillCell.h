//
//  ProductDetailsWillSeckillCell.h
//  DuoSet
//
//  Created by fanfans on 2017/5/18.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailsData.h"

typedef void(^TexButtonActionBlock)();

@interface ProductDetailsWillSeckillCell : UITableViewCell

-(void)setupInfoWithProductDetailsData:(ProductDetailsData *)item;

@property(nonatomic,copy) TexButtonActionBlock texBtnHandle;

@end
