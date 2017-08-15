//
//  DesignerProductCell.h
//  DuoSet
//
//  Created by fanfans on 2017/3/21.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DesignerDetailsBlock)(NSInteger);

@interface DesignerProductListCell : UITableViewCell

-(void)setupInfoWithDesignerProductDataArr:(NSMutableArray *)items;

@property(nonatomic,copy) DesignerDetailsBlock detailsHandle;

@end
