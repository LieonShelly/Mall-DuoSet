//
//  AllOrderCell.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/12.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllOrderCell : UITableViewCell
//@property (nonatomic, copy) NSArray *btnImgArray;
//@property (nonatomic, copy) NSArray *btnTitleArray;
@property (nonatomic, strong) UIButton *headerLabel;
@property (nonatomic, copy) void(^allOrderBtn)();
@end
