//
//  ShoppingCartCell.h
//  DuoSet
//
//  Created by mac on 2017/1/5.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCarModel.h"
#import "ItemCountModifyView.h"

typedef void(^ChangeProductAmountBlock)(NSInteger);
typedef void(^SingleProductSeletedBlock)();
typedef void(^SingleProductChoiceOtherStandardBlock)();
typedef void(^ChangeProductAountMinBlock)(NSInteger);
typedef void(^ChangeProductAountMaxBlock)(NSInteger);

@interface ShoppingCartCell : UITableViewCell

@property(nonatomic,strong) UIButton *selectedBtn;
@property(nonatomic,strong) UIButton *standardModifyBtn;
@property(nonatomic,strong) UIImageView *standardShowImgV;
@property(nonatomic,copy) ChangeProductAmountBlock amountChangeHandle;
@property(nonatomic,copy) SingleProductSeletedBlock productSelectedHandle;
@property(nonatomic,copy) SingleProductChoiceOtherStandardBlock productChoiceOtherStandardHandle;
@property(nonatomic,copy) ChangeProductAountMinBlock minHandle;
@property(nonatomic,copy) ChangeProductAountMaxBlock plusHandle;
@property(nonatomic,strong) ItemCountModifyView *itemModifyView;

-(void)setupInfoWithShopCarModel:(ShopCarModel *)item andIsEdit:(BOOL)isEdit;

@end
