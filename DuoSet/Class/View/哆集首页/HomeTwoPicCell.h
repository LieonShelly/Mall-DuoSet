//
//  HomeTwoPicCell.h
//  DuoSet
//
//  Created by fanfans on 2017/3/10.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeMainData.h"

typedef void(^TwoPicTapBlock)(NSInteger);

@interface HomeTwoPicCell : UITableViewCell

@property(nonatomic,copy) TwoPicTapBlock clickHandle;

-(void)setupInfoWithHomeMainData:(HomeMainData *)item;

@end
