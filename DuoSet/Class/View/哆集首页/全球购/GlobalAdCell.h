//
//  GlobalAdCell.h
//  DuoSet
//
//  Created by fanfans on 2017/3/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GlobalAdCellBlock)(NSInteger);

@interface GlobalAdCell : UITableViewCell

@property(nonatomic,copy) GlobalAdCellBlock adTapHandle;

-(void)setupInfoWithImgVArr:(NSArray *)imgvArr;

@end
