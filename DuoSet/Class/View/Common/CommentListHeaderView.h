//
//  CommentListHeaderView.h
//  DuoSet
//
//  Created by fanfans on 2017/3/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CommentHeaderViewBtnActionBlock)(NSInteger);

@interface CommentListHeaderView : UIView

@property(nonatomic,copy)CommentHeaderViewBtnActionBlock btnActionHandle;

-(void)setCountLableContentWithCountArr:(NSArray *)countArr;

@end
