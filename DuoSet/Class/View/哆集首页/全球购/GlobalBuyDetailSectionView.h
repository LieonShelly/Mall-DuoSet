//
//  GlobalBuyDetailSectionView.h
//  DuoSet
//
//  Created by fanfans on 2017/3/15.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GloballistData.h"

@interface GlobalBuyDetailSectionView : UICollectionReusableView

-(void)setupInfoWithGloballistData:(GloballistData *)item;

@end
