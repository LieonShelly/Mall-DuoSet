//
//  ProductStandardChoiceView.h
//  DuoSet
//
//  Created by fanfans on 2017/3/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProductDetailsData.h"

typedef void(^StandardIndexAllChoice)(NSArray *arr);
typedef void(^CommitProductBuyInfoBlock)(NSArray *arr,NSInteger amount);
typedef void(^CloseBlock)();
typedef void(^ProductImageBlock)(UIImage * image);

@interface ProductStandardChoiceView : UIView

-(void)setupInfoWithProductDetailsData:(ProductDetailsData *)info;

-(void)setItemRepertoryNum:(NSString *)repertoryNum andNewPrice:(NSString *)newStr coverPic:(NSString *)cover;

-(void)setItemRepertoryNum:(NSString *)repertoryNum originalCount:(NSString *)originalCount andNewPrice:(NSString *)newStr coverPic:(NSString *)cover;

@property(nonatomic,copy) StandardIndexAllChoice indexChoiceHandle;
@property(nonatomic,copy) CommitProductBuyInfoBlock commitHandle;
@property(nonatomic,copy) CloseBlock closeHandle;
@property(nonatomic,strong) UILabel *priceLable;
// productImgTapAction
@property(nonatomic,copy) ProductImageBlock productImgTapAction;
@end
