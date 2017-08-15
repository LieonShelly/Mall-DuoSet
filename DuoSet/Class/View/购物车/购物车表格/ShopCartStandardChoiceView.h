//
//  ShopCartStandardChoiceView.h
//  DuoSet
//
//  Created by fanfans on 2017/6/1.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCartStandardRepertoryData.h"

typedef void(^StandardIndexAllChoice)(NSArray *arr);
typedef void(^CommitProductBuyInfoBlock)(NSArray *arr,NSInteger amount);
typedef void(^CloseBlock)();
typedef void(^ProductImageBlock)(UIImage * image);

@interface ShopCartStandardChoiceView : UIView

-(void)setupInfoWithPropertyProductEntities:(NSMutableArray *)propertyProductEntities andShopCartStandardRepertoryData:(ShopCartStandardRepertoryData *)item;

@property(nonatomic,copy) StandardIndexAllChoice indexChoiceHandle;
@property(nonatomic,copy) CommitProductBuyInfoBlock commitHandle;
@property(nonatomic,copy) CloseBlock closeHandle;

@property(nonatomic,copy) CloseBlock productImgTapAction;
@end
