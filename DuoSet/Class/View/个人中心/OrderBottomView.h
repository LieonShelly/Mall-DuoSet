//
//  OrderBottomView.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/6.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol OrderBottomViewDelegate <NSObject>

-(void) pushVC: (UIButton *) btn;

@end

@interface OrderBottomView : UIView
@property (nonatomic, weak) id<OrderBottomViewDelegate> delegate;

@end
