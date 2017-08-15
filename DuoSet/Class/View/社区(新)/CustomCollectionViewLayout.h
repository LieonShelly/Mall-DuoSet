//
//  CustomCollectionViewLayout.h
//  DuoSet
//
//  Created by fanfans on 2017/5/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomCollectionViewLayout;

@protocol FFCollectionLayoutDelegate <NSObject>
@optional

-(CGFloat)flowLayout:(CustomCollectionViewLayout *)flowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

-(void)reSteCollectionViewContentSize:(CGSize)size;

@end

@interface CustomCollectionViewLayout : UICollectionViewLayout

/** 列间距 */
@property(nonatomic,assign)CGFloat columnMargin;
/** 行间距 */
@property(nonatomic,assign)CGFloat rowMargin;
/** 列数 */
@property(nonatomic,assign)int columnsCount;
/** 外边距 */
@property (nonatomic, assign) UIEdgeInsets sectionInset;
@property (nonatomic, weak) id<FFCollectionLayoutDelegate> delegate;



@end
