//
//  ProductCommentStarView.h
//  DuoSet
//
//  Created by fanfans on 2017/3/8.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^StarSelectedBlock)(NSInteger);

@interface ProductCommentStarView : UIView

@property(nonatomic,copy) StarSelectedBlock starSelectedHandle;
@property(nonatomic,strong) UILabel *titleNameLable;

-(void)setupInfoScoreView:(NSInteger)index;

@end
