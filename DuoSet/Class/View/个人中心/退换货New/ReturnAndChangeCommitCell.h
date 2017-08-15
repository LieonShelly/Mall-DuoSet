//
//  ReturnAndChangeCommitCell.h
//  DuoSet
//
//  Created by fanfans on 2017/5/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CommitBlock)();

@interface ReturnAndChangeCommitCell : UITableViewCell

@property(nonatomic,copy) CommitBlock commitHandle;

@end
