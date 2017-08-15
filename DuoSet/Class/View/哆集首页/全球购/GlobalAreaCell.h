//
//  GlobalAreaCell.h
//  DuoSet
//
//  Created by mac on 2017/1/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GlobalProductBlock)(NSInteger);

@interface GlobalAreaCell : UITableViewCell

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,copy) GlobalProductBlock productTapHandle;

@end
