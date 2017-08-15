//
//  GlobalBuyFiveImgCell.h
//  DuoSet
//
//  Created by mac on 2017/1/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GlobalBuyImgVBlock)(NSInteger);

@interface GlobalBuyFiveImgCell : UITableViewCell

@property(nonatomic,copy) GlobalBuyImgVBlock imgTapHandle;

-(void)setupInfoWithGlobalAreaDataArr:(NSArray *)itemArr;

@end
