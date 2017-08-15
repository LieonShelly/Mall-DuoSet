//
//  PiazzaSubCommentCell.h
//  DuoSet
//
//  Created by fanfans on 2017/5/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PiazzaItemChildCommentData.h"

typedef void(^CellLikeBtnActionBlock)(UIButton *btn);
typedef void(^CellReplyBtnActionBlock)();
typedef void(^CellUserNameTapActionBlock)(NSString *userId);

@interface PiazzaSubCommentCell : UITableViewCell

-(void)setupInfoWithPiazzaItemChildCommentData:(PiazzaItemChildCommentData *)item;

@property(nonatomic,copy) CellReplyBtnActionBlock replyHandle;
@property(nonatomic,copy) CellLikeBtnActionBlock likeHandle;
@property(nonatomic,copy) CellUserNameTapActionBlock userNameTapBlock;

@end
