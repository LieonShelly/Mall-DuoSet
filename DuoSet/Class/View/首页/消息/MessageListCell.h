//
//  MessageListCell.h
//  DuoSet
//
//  Created by fanfans on 2017/3/29.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemMessageModel.h"

@interface MessageListCell : UITableViewCell

-(void)setupInfoWithSystemMessageModel:(SystemMessageModel *)item;

@end
