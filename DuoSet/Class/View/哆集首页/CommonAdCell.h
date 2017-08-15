//
//  CommonAdCell.h
//  DuoSet
//
//  Created by mac on 2017/1/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrentFashionData.h"

@interface CommonAdCell : UITableViewCell

-(void)setImgFill:(BOOL)Fill;

-(void)setupInfoWithCurrentFashionData:(CurrentFashionData *)item;

@end
