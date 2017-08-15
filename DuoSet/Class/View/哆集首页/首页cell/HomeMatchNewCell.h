//
//  HomeMatchNewCell.h
//  DuoSet
//
//  Created by fanfans on 2017/5/5.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeMatchData.h"

typedef void(^HomeMatchNewCellImgVTapBlock)(NSInteger index);

@interface HomeMatchNewCell : UITableViewCell

@property (nonatomic,copy) HomeMatchNewCellImgVTapBlock imgVTapHandle;

-(void)SetupInfoWithHomeMatchData:(HomeMatchData *)item;



@end
