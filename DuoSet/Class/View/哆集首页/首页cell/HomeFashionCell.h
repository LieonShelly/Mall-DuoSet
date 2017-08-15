//
//  HomeFashionCell.h
//  DuoSet
//
//  Created by fanfans on 2017/5/5.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeMainData.h"

typedef void(^HomeFashionCellImgVTapBlock)(NSInteger index);

@interface HomeFashionCell : UITableViewCell

@property(nonatomic,copy) HomeFashionCellImgVTapBlock imgVTapHandle;

-(void)setupInfoWithHomeMainData:(HomeMainData *)item;

@end
