//
//  ViewControllerRecommendToYouCollectionViewCell.h
//  DuoSet
//
//  Created by Seven-Augus on 2016/11/23.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProductListData.h"
#import "RecommendListData.h"
#import "HomeMatchProductData.h"
#import "ProductForListData.h"

@interface ViewControllerRecommendToYouCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *productsRecommendImageView; // 产品图
@property (nonatomic, strong) UILabel *productsRecommendDetailLabel; // 产品描述
@property (nonatomic, strong) UILabel *productsRecommendPriceLabel; // 产品价格
@property (nonatomic, strong) UILabel *productsRecommendPerSonNumLabel; // 付款人数

-(void)setupInfoWithProductListData:(ProductListData *)item;

-(void)setUPInfoWithRecommendListData:(RecommendListData *)item;

-(void)setUPInfoWithHomeMatchProductData:(HomeMatchProductData *)item;

-(void)setUPInfoWithProductForListData:(ProductForListData *)item;

@end
