//
//  SigninTextCell.h
//  DuoSet
//
//  Created by fanfans on 2017/2/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
//签到
#import "UserSignData.h"
#import "SevenDaySignData.h"

@interface SigninTextCell : UITableViewCell

-(void)setupInfoWithSevenDaySignDatas:(NSMutableArray *)datas andUserSignData:(UserSignData *)item;

@end
