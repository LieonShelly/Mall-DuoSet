//
//  PiazzaHomeCell.h
//  DuoSet
//
//  Created by fanfans on 2017/3/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PiazzaData.h"

typedef void(^likeBtnActionBlock)(UIButton *);
typedef void(^ImgVTapActionBlock)(NSInteger);
typedef void(^AvatarsActionBlock)();

@interface PiazzaHomeCell : UITableViewCell

@property(nonatomic,copy) likeBtnActionBlock likeHandle;
@property(nonatomic,copy) ImgVTapActionBlock imgVTapHandle;
@property(nonatomic,copy) AvatarsActionBlock avatarHandle;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isChoiceness:(BOOL)isChoiceness;

-(void)setupInfoWithPiazzaData:(PiazzaData *)item;

-(void)resetAvatarListAndLikeBtnWithPiazzaData:(PiazzaData *)item;

@end
