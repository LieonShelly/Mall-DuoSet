//
//  UserCenterImgItemCell.h
//  DuoSet
//
//  Created by fanfans on 2017/3/6.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ImgItemActionBlock)(NSInteger);

@interface UserCenterImgItemCell : UITableViewCell

@property(nonatomic,copy) ImgItemActionBlock itemTapHandle;

@end
