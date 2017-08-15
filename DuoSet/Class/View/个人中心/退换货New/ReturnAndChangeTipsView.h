//
//  ReturnAndChangeTipsView.h
//  DuoSet
//
//  Created by fanfans on 2017/5/15.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CloseBlock)();
typedef void(^AgreeBlock)();

@interface ReturnAndChangeTipsView : UIView

-(void)setupInfoWithArticles:(NSMutableArray *)items AndArticlesCellHight:(NSMutableArray *)cellHightArr;

@property(nonatomic,copy) CloseBlock closeHandle;
@property(nonatomic,copy) AgreeBlock agreeHandle;


@end
