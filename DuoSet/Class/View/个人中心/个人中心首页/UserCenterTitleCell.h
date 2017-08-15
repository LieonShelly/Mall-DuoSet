//
//  UserCenterTitleCell.h
//  DuoSet
//
//  Created by lieon on 2017/6/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ImgItemActionBlock)(NSInteger);

@interface UserCenterTitleCell : UITableViewCell

@property(nonatomic,copy) ImgItemActionBlock itemTapHandle;

- (void)configTitle: (NSString *)title;

@end
