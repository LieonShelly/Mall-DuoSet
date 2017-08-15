//
//  ProductTexDesView.h
//  DuoSet
//
//  Created by fanfans on 2017/6/5.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailsArticle.h"

typedef void(^ProductTexDesViewCloseBlock)();

@interface ProductTexDesView : UIView

@property(nonatomic,copy) ProductTexDesViewCloseBlock closeHandle;

-(void)setupInfoWithProductDetailsArticleArr:(NSMutableArray *)items;

@end
