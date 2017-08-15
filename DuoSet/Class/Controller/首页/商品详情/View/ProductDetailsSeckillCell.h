//
//  ProductDetailsSeckillCell.h
//  DuoSet
//
//  Created by fanfans on 2017/5/4.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TexButtonActionBlock)();

@interface ProductDetailsSeckillCell : UITableViewCell

-(void)setupInfoWithProductDetailsData:(ProductDetailsData *)item;

@property(nonatomic,copy) TexButtonActionBlock texBtnHandle;

@end
