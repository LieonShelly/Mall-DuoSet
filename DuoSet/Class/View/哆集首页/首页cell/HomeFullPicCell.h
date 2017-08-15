//
//  HomeFullPicCell.h
//  DuoSet
//
//  Created by fanfans on 2017/5/5.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppSpecialIconData.h"

@interface HomeFullPicCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isFull:(BOOL)isFull;

-(void)setupInfoWithTitleImageUrlStr:(NSString *)titleimgStr andCoverUrlStr:(NSString *)coverStr;

-(void)setupInfoWithAppSpecialIconData:(AppSpecialIconData *)item;

@end
