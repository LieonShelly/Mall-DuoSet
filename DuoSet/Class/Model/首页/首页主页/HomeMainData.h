//
//  HomeMainData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeTopBanner.h"
#import "CurrentFashionData.h"
#import "HomeMatchData.h"
#import "NavIconData.h"
#import "AppSpecialIconData.h"

@interface HomeMainData : NSObject

@property(nonatomic,strong) NSMutableArray *homePageTopBanner;
@property(nonatomic,strong) NSMutableArray *appNavIcons;
@property(nonatomic,strong) NSMutableArray *homePageCurrentFashion;
@property(nonatomic,strong) NSMutableArray *matchList;
@property(nonatomic,strong) NSMutableArray *appSpecialIcons;
@property(nonatomic,copy) NSString *homePageMustShopProductCover;
@property(nonatomic,copy) NSString *homePageMustShopProductTitleIcon;
@property(nonatomic,copy) NSString *homePageGoodsProductCover;
@property(nonatomic,copy) NSString *homePageGoodsProductTitleIcon;
@property(nonatomic,copy) NSString *homePageCurrentFashionTitleIcon;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;


@end
