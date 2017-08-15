//
//  HomeFourPicCell.h
//  DuoSet
//
//  Created by mac on 2017/1/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeMainData.h"
#import "CurrentFashionData.h"

typedef void(^FouPicTapBlock)(NSInteger);

@interface HomeFourPicCell : UITableViewCell

@property(nonatomic,copy) FouPicTapBlock clickHandle;

-(void)setupInfoWithHomeMainData:(HomeMainData *)item;

@end
