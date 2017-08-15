//
//  CommonBannerView.h
//  DuoSet
//
//  Created by fanfans on 2017/3/14.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DetailImgChickBlock)(NSInteger);

@interface CommonBannerView : UIView

@property(nonatomic,copy) DetailImgChickBlock imgTapHandle;

-(void)setupInfoWithImgVArr:(NSArray *)urlImgArr;

@end
