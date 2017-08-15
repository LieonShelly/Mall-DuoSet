//
//  PiazzaCommentOriginalCell.h
//  DuoSet
//
//  Created by fanfans on 2017/5/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PiazzaItemCommentData.h"


typedef void(^CellLikeBtnActionBlock)(UIButton *btn);
typedef void(^CellReplyBtnActionBlock)();

@interface PiazzaCommentOriginalCell : UITableViewCell

-(void)setupInfoWithPiazzaItemCommentData:(PiazzaItemCommentData *)item;

@property(nonatomic,copy) CellReplyBtnActionBlock replyHandle;
@property(nonatomic,copy) CellLikeBtnActionBlock likeHandle;


@end
