//
//  TodayRecommendSectionView.h
//  DuoSet
//
//  Created by mac on 2017/1/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SectionViewBtnActionBlock)(NSInteger);

@interface TodayRecommendSectionView : UIView

@property(nonatomic,copy) SectionViewBtnActionBlock btnActionHandle;

-(instancetype)initWithFrame:(CGRect)frame andBtnNameArr:(NSMutableArray *)btnNameArr;

-(void)resetSectionViewTitleNameWithNameArr:(NSMutableArray *)nameArr;

-(void)setBtnChangeWithIndex:(NSInteger)index;

@end
