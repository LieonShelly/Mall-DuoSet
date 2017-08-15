//
//  SingleProductNewController.h
//  DuoSet
//
//  Created by fanfans on 2017/4/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYPagerController.h"

@interface SingleProductNewController : UIViewController

-(instancetype)initWithProductId:(NSString *)productNum;

-(instancetype)initWithProductId:(NSString *)productNum andPropertyCollection:(NSString *)propertyCollection;

-(instancetype)initWithProductId:(NSString *)productNum andCover:(NSString *)cover productTitle:(NSString *)productTitle productPrice:(NSString *)productPrice;

-(instancetype)initWithProductId:(NSString *)productNum andCover:(NSString *)cover productTitle:(NSString *)productTitle productPrice:(NSString *)productPrice andPropertyCollection:(NSString *)propertyCollection;

@property(nonatomic,assign) BOOL autoAddtoShopCart;

@end
