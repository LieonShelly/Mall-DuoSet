//
//  PiazzaDetailsCommentCell.h
//  DuoSet
//
//  Created by fanfans on 2017/5/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PiazzaItemCommentData.h"

typedef void(^CellReplyBtnActionBlock)();
typedef void(^CellLikeBtnActionBlock)(UIButton *btn);

@interface PiazzaDetailsCommentCell : UITableViewCell

-(void)setUpInfoWithPiazzaItemCommentData:(PiazzaItemCommentData *)item;

@property(nonatomic,copy) CellReplyBtnActionBlock replyBtnHandle;
@property(nonatomic,copy) CellLikeBtnActionBlock likeBtnHandle;

@end
