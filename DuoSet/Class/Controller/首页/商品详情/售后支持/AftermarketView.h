//
//  AftermarketView.h
//  DuoSet
//
//  Created by fanfans on 2017/5/3.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AftermarketViewCloseBlock)();

@interface AftermarketView : UIView

@property(nonatomic,copy) AftermarketViewCloseBlock closeHandle;

-(void)setupInfoWithProductDetailsArticleArr:(NSMutableArray *)items;

@end
