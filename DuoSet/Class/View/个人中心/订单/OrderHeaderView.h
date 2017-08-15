//
//  OrderHeaderView.h
//  DuoSet
//
//  Created by fanfans on 1/4/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderHeaderView : UIView

@property (nonatomic, copy) void (^OrderHeaderViewBtnActionBlock)(NSInteger);

-(instancetype)initWithFrame:(CGRect)frame backBlock:(void(^)(NSInteger)) moreclick;

-(void)setBtnChangeWithIndex:(NSInteger)index;

@end
