//
//  CollectionDesigerCell.h
//  DuoSet
//
//  Created by fanfans on 2017/3/29.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DesignerData.h"

@interface CollectionDesigerCell : UITableViewCell

-(void)setupInfoWithDesignerData:(DesignerData *)item;

@end
