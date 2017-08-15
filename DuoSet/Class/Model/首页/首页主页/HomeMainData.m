//
//  HomeMainData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "HomeMainData.h"

@implementation HomeMainData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"homePageCurrentFashionTitleIcon"]) {
            _homePageCurrentFashionTitleIcon = [dic objectForKey:@"homePageCurrentFashionTitleIcon"] != nil ? [NSString stringWithFormat:@"%@%@",BaseImgUrl,[dic objectForKey:@"homePageCurrentFashionTitleIcon"]] : @"";
        }
        if ([dic objectForKey:@"homePageTopBanner"]) {
            _homePageTopBanner = [NSMutableArray array];
            if ([[dic objectForKey:@"homePageTopBanner"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [dic objectForKey:@"homePageTopBanner"];
                for (NSDictionary *d in arr) {
                    HomeTopBanner *item = [HomeTopBanner dataForDictionary:d];
                    [_homePageTopBanner addObject:item];
                }
            }
        }//HomeMatchData
        if ([dic objectForKey:@"homePageCurrentFashion"]) {
            _homePageCurrentFashion = [NSMutableArray array];
            if ([[dic objectForKey:@"homePageCurrentFashion"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [dic objectForKey:@"homePageCurrentFashion"];
                for (NSDictionary *d in arr) {
                    CurrentFashionData *item = [CurrentFashionData dataForDictionary:d];
                    [_homePageCurrentFashion addObject:item];
                }
            }
        }
        if ([dic objectForKey:@"appNavIcons"]) {
            _appNavIcons = [NSMutableArray array];
            if ([[dic objectForKey:@"appNavIcons"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [dic objectForKey:@"appNavIcons"];
                for (NSDictionary *d in arr) {
                    NavIconData *item = [NavIconData dataForDictionary:d];
                    [_appNavIcons addObject:item];
                }
            }
        }
        if ([dic objectForKey:@"appSpecialIcons"]) {
            _appSpecialIcons = [NSMutableArray array];
            if ([[dic objectForKey:@"appSpecialIcons"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [dic objectForKey:@"appSpecialIcons"];
                for (NSDictionary *d in arr) {
                    AppSpecialIconData *item = [AppSpecialIconData dataForDictionary:d];
                    [_appSpecialIcons addObject:item];
                }
            }
        }
        if ([dic objectForKey:@"matchList"]) {
            _matchList = [NSMutableArray array];
            if ([[dic objectForKey:@"matchList"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [dic objectForKey:@"matchList"];
                for (NSDictionary *d in arr) {
                    HomeMatchData *item = [HomeMatchData dataForDictionary:d];
                    [_matchList addObject:item];
                }
            }
        }
        if ([dic objectForKey:@"homePageGoodsProduct"]) {
            _homePageGoodsProductCover = @"";
            if ([[dic objectForKey:@"homePageGoodsProduct"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *homePageGoodsProductDic = [dic objectForKey:@"homePageGoodsProduct"];
                if ([homePageGoodsProductDic objectForKey:@"picture"]) {
                    NSString *str = [NSString stringWithFormat:@"%@",[homePageGoodsProductDic objectForKey:@"picture"]];
                    _homePageGoodsProductCover = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
                }
                if ([homePageGoodsProductDic objectForKey:@"titleIcon"]) {
                    NSString *str = [NSString stringWithFormat:@"%@",[homePageGoodsProductDic objectForKey:@"titleIcon"]];
                    _homePageGoodsProductTitleIcon = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
                }
            }
        }
        if ([dic objectForKey:@"homePageMustShopProduct"]) {
            _homePageMustShopProductCover = @"";
            if ([[dic objectForKey:@"homePageMustShopProduct"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *homePageMustShopProductDic = [dic objectForKey:@"homePageMustShopProduct"];
                if ([homePageMustShopProductDic objectForKey:@"picture"]) {
                    NSString *str = [NSString stringWithFormat:@"%@",[homePageMustShopProductDic objectForKey:@"picture"]];
                    _homePageMustShopProductCover = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
                }
                if ([homePageMustShopProductDic objectForKey:@"titleIcon"]) {
                    NSString *str = [NSString stringWithFormat:@"%@",[homePageMustShopProductDic objectForKey:@"titleIcon"]];
                    _homePageMustShopProductTitleIcon = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
                }
            }
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
