//
//  MessageCenterCell.h
//  DuoSet
//
//  Created by fanfans on 2017/2/27.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageCenterData.h"

@interface MessageCenterCell : UITableViewCell

-(void)setupInfoWithMessageCenterData:(MessageCenterData *)item;

@end
