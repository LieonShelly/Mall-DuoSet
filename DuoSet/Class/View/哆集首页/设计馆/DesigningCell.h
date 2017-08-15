//
//  DesigningCell.h
//  DuoSet
//
//  Created by mac on 2017/1/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DesignerProductData.h"

typedef void(^DesigningCellLikeBtnActionBlock)(UIButton *);

@interface DesigningCell : UITableViewCell

@property(nonatomic,copy) DesigningCellLikeBtnActionBlock likeHandle;

@property(nonatomic,strong) UIButton *likeBtn;

-(void)setupInfoWithDesignerProductData:(DesignerProductData *)item;

@end
