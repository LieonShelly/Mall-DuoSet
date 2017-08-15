//
//  MatchDetailsPicsCell.h
//  DuoSet
//
//  Created by fanfans on 2017/3/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatchDetailsData.h"

typedef void(^DressUpSingleItemBlock)(NSInteger);

@interface MatchDetailsPicsCell : UITableViewCell

-(void)setupIndoWithMatchDetailsData:(MatchDetailsData *)item;

@property(nonatomic,copy) DressUpSingleItemBlock dressupHandle;

@end
