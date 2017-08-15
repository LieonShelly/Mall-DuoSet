//
//  ProductDetailsBaseInfoCell.h
//  DuoSet
//
//  Created by fanfans on 2017/5/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TexButtonActionBlock)();

@interface ProductDetailsBaseInfoCell : UITableViewCell

-(void)setupInfoWithProductDetailsData:(ProductDetailsData *)item;

-(void)setupInfoWithFirstLangchProductTitle:(NSString *)productTitle productPrice:(NSString *)productPrice;

@property(nonatomic,copy) TexButtonActionBlock texBtnHandle;

@end
