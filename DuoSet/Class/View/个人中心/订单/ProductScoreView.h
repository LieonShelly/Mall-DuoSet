//
//  ProductScoreView.h
//  DuoSet
//
//  Created by fanfans on 2017/3/8.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ProductScoreBtnSelectedBlock)(NSInteger);

typedef void(^ProductScoreViewStarItemPack)(NSInteger);
typedef void(^ProductScoreViewStarSeepedBlock)(NSInteger);

@interface ProductScoreView : UIView

@property(nonatomic,copy) ProductScoreBtnSelectedBlock btnselectedHandle;
@property(nonatomic,copy) ProductScoreViewStarItemPack packHandle;
@property(nonatomic,copy) ProductScoreViewStarSeepedBlock seepedHandle;

@end
