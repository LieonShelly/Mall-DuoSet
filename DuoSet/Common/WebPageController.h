//
//  WebPageController.h
//  BossApp
//
//  Created by fanfans on 5/9/16.
//  Copyright © 2016 ZDJY. All rights reserved.
//

#import "BaseViewController.h"
#import "MustBuyRecommendData.h"
#import "DesignerProductData.h"

typedef void(^ShareSuccessBlock)();
@interface WebPageController : BaseViewController

@property(nonatomic,assign) BOOL isFromMustBuy;
@property(nonatomic,strong) MustBuyRecommendData *mustBuyData;

@property(nonatomic,assign) BOOL isFromDesignerDetails;
@property(nonatomic,strong) DesignerProductData *designerProductData;
@property(nonatomic,copy) ShareSuccessBlock shareSuccessHandle;

@property(nonatomic,assign) BOOL isFromRefund;
@property(nonatomic,assign) BOOL isFromReturnAndChange;

-(instancetype)initWithUrlStr:(NSString *)url NavTitle:(NSString *)navTilte ShowRightBtn:(BOOL)showRight;
-(instancetype)initWithUrlStr:(NSString *)url NavTitle:(NSString *)navTilte;

@end
