//
//  ProductDetailsData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/1.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ProductDetailsData.h"

@implementation ProductDetailsData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _baseInfoCellHight = FitHeight(170.0);
        _seckillCellHight = FitHeight(220.0);
        _seckillWillBeginCellHight = FitHeight(230.0);
        if ([dic objectForKey:@"buyedCount"]) {
            _buyedCount = [dic objectForKey:@"buyedCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"buyedCount"]] : @"0";
        }
        if ([dic objectForKey:@"carryPrice"]) {
            _carryPrice = [dic objectForKey:@"carryPrice"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"carryPrice"]] : @"0";
        }
        if ([dic objectForKey:@"cover"]) {
            NSString *coverStr = [dic objectForKey:@"cover"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"cover"]] : @"";
            _cover = [NSString stringWithFormat:@"%@%@",BaseImgUrl,coverStr];
        }
        if ([dic objectForKey:@"detail"]) {
            _detail = [dic objectForKey:@"detail"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"detail"]] : @"";
        }
        if ([dic objectForKey:@"id"]) {
            _product_id = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"robResponse"]) {
            if ([[dic objectForKey:@"robResponse"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *robDic = [dic objectForKey:@"robResponse"];
                _robResponse = [ProductDetailsSeckillData dataForDictionary:robDic];
            }
        }
        if ([dic objectForKey:@"productName"]) {
            _productName = [dic objectForKey:@"productName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productName"]] : @"";
        }
        if ([dic objectForKey:@"productNumber"]) {
            _productNumber = [dic objectForKey:@"productNumber"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productNumber"]] : @"";
        }
        if ([dic objectForKey:@"orderCount"]) {
            _orderCount = [dic objectForKey:@"orderCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"orderCount"]] : @"";
        }
        if ([dic objectForKey:@"price"]) {
            NSString *priceStr = [dic objectForKey:@"price"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]] : @"";
            _price = [NSString stringWithFormat:@"%.2lf",priceStr.floatValue];
        }
        if ([dic objectForKey:@"repertory"]) {
            _repertory = [dic objectForKey:@"repertory"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"repertory"]] : @"";
        }
        if ([dic objectForKey:@"showPics"]) {
            if ([[dic objectForKey:@"showPics"] isKindOfClass:[NSArray class]]) {
                NSArray *imgArr = [dic objectForKey:@"showPics"];
                _showPics = [NSMutableArray array];
                for (NSDictionary *d in imgArr) {
                    if ([d objectForKey:@"picture"]) {
                        NSString *img = [NSString stringWithFormat:@"%@%@!750x550",BaseImgUrl,[d objectForKey:@"picture"]];
                        [_showPics addObject:img];
                    }
                }
            }
        }
        if ([dic objectForKey:@"productSubName"]) {
            _productSubName = [dic objectForKey:@"productSubName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productSubName"]] : @"";
            CGFloat hight = [NSString countTextHightLabelWidth:mainScreenWidth - FitWith(60.0) textString:_productSubName textFont:15];
            _baseInfoCellHight += hight;
            _seckillCellHight += hight;
            _seckillWillBeginCellHight += hight;
        }
        if ([dic objectForKey:@"commentCount"]) {
            _commentCount = [dic objectForKey:@"commentCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"commentCount"]] : @"0";
        }
        if ([dic objectForKey:@"commentGood"]) {
            _commentGood = [dic objectForKey:@"commentGood"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"commentGood"]] : @"0";
        }
        if ([dic objectForKey:@"isCollect"]) {
            NSString *str = [dic objectForKey:@"isCollect"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"isCollect"]] : @"0";
            _isCollect = str.integerValue == 1;
        }
        if ([dic objectForKey:@"isGlobal"]) {
            NSString *str = [dic objectForKey:@"isGlobal"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"isGlobal"]] : @"0";
            _isGlobal = str.integerValue == 1;
        }
        if ([dic objectForKey:@"tax"]) {
            _tax = [dic objectForKey:@"tax"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"tax"]] : @"";
        }
        if ([dic objectForKey:@"status"]) {//0表示正常上架状态；1表示下架状态
            NSString *str = [dic objectForKey:@"status"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]] : @"0";
            switch (str.integerValue) {
                case 0:
                    _status = ProductDetailsWithDefault;
                    break;
                case 1:
                    _status = ProductDetailsWithSoldOut;
                    break;
                    
                default:
                    _status = ProductDetailsWithDefault;
                    break;
            }
        }
        if ([dic objectForKey:@"propertyProductEntities"]) {
            if ([[dic objectForKey:@"propertyProductEntities"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [dic objectForKey:@"propertyProductEntities"];
                _propertyProductEntities = [NSMutableArray array];
                for (NSDictionary *d in arr) {
                    ProductPropertyData *item = [ProductPropertyData dataForDictionary:d];
                    [_propertyProductEntities addObject:item];
                }
            }
        }
        if ([dic objectForKey:@"articles"]) {
            if ([[dic objectForKey:@"articles"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [dic objectForKey:@"articles"];
                _articles = [NSMutableArray array];
                for (NSDictionary *d in arr) {
                    ProductDetailsArticle *item = [ProductDetailsArticle dataForDictionary:d];
                    [_articles addObject:item];
                }
            }
        }
        if ([dic objectForKey:@"articlesGlobal"]) {
            if ([[dic objectForKey:@"articlesGlobal"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [dic objectForKey:@"articlesGlobal"];
                _articlesGlobal = [NSMutableArray array];
                for (NSDictionary *d in arr) {
                    ProductDetailsArticle *item = [ProductDetailsArticle dataForDictionary:d];
                    [_articlesGlobal addObject:item];
                }
            }
        }
        if ([dic objectForKey:@"robSessionResponse"]) {
            if ([[dic objectForKey:@"robSessionResponse"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *robSessionResponseDic = [dic objectForKey:@"robSessionResponse"];
                _robSessionResponse = [RobSessionData dataForDictionary:robSessionResponseDic];
            }
        }
        if ([dic objectForKey:@"newRobResponse"]) {
            if ([[dic objectForKey:@"newRobResponse"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *newRobResponseDic = [dic objectForKey:@"newRobResponse"];
                _productNewRobResponse = [RobProductData dataForDictionary:newRobResponseDic];
            }
        }
        if ([dic objectForKey:@"repertorySelect"]) {
            if ([[dic objectForKey:@"repertorySelect"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *repertorySelectDic = [dic objectForKey:@"repertorySelect"];
                _repertorySelect = [RepertorySelectedData dataForDictionary:repertorySelectDic];
            }
        }
    }
    if (_robSessionResponse == nil) {
        _seckillStatus = ProductDetailsDefault;
    }else{
        if (_robSessionResponse.isInRob) {
            _seckillStatus = ProductDetailsSeckilling;//正在秒杀中
        }else{
            _seckillStatus = ProductDetailsSeckillWillBegin;//秒杀即将开始
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
