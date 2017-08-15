//
//  OrderBtnCell.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/12.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderBtnCell : UITableViewCell
@property (nonatomic, copy) NSArray *btnImgArray;
@property (nonatomic, copy) NSArray *btnTitleArray;
@property (nonatomic, copy) void(^weifukuan)();
@property (nonatomic, copy) void(^weifahuo)();
@property (nonatomic, copy) void(^weishouhuo)();
@property (nonatomic, copy) void(^weipingjia)();
@property (nonatomic, copy) void(^tuihuanhuo)();

@end
