//
//  CommonRecommendForYouCell.h
//  DuoSet
//
//  Created by mac on 2017/1/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RecommendForYouBlock)(NSInteger);

@interface CommonRecommendForYouCell : UITableViewCell

@property(nonatomic,copy) RecommendForYouBlock recommendHandle;

-(void)setupInfoWithProductListDataArr:(NSArray *)items;

-(void)setupInfoWithRecommendListDataArr:(NSArray *)recommendItems;

-(void)setupInfoWithHomeMatchProductDataArr:(NSArray *)matchProductItems;

-(void)setupInfoWithProductForListDataArr:(NSArray *)productForListDatas;

@end
