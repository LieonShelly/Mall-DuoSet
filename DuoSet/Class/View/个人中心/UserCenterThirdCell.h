//
//  UserCenterThirdCell.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/12.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCenterThirdCell : UITableViewCell
@property (nonatomic, copy) void(^duoDouBtn)();
@property (nonatomic, copy) void(^youhuijuanBtn)();
@property (nonatomic, copy) void(^shangpinAttentionBtn)();
@property (nonatomic, copy) void(^walletBtn)();
@property (nonatomic, copy) void(^VIPBtn)();
@property (nonatomic, copy) void(^historyBtn)();
@property (nonatomic, copy) void(^activityBtn)();
@property (nonatomic, copy) void(^kefuBtn)();
@end
