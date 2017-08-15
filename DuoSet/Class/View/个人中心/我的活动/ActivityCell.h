//
//  ActivityCell.h
//  DuoSet
//
//  Created by fanfans on 1/3/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityData.h"

@interface ActivityCell : UITableViewCell

-(void)setupDataInfoWithActivityData:(ActivityData *)item;

@end
