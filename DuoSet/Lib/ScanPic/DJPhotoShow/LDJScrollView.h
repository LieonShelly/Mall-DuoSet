//
//  LDJScrollView.h
//  exercise-lidengjie1
//
//  Created by BraveSoft on 12/10/15.
//  Copyright © 2015 lidengjie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^StopAnimationBlock)(NSInteger);

@interface LDJScrollView : UIScrollView <UIScrollViewDelegate> {
    BOOL isAnimating;//是否正在执行翻页动画
}

/**
 *  当前下标
 */
@property (assign, nonatomic) NSInteger      currentIndex;


/**
 *  当前初始化的数组
 */
@property (strong, nonatomic) NSMutableArray *contentView;

/**
 *  图片数组
 */
@property (strong, nonatomic) NSMutableArray *imageArray;

/**
 *  图片url数组
 */
@property (strong, nonatomic) NSMutableArray *imageUrlArray;

- (void)initializeUserInterface;

/**
 *  开始播放
 */
- (void)startAnimation;

/**
 *  暂停播放
 *
 *  @param index block返回当前index
 */
- (void)stopAnimation:(void(^)(NSInteger))index;

/**
 *  下一张
 *
 *  @param index block返回当前index
 */
- (void)nextPicture:(void(^)(NSInteger))index;

/**
 *  上一张
 *
 *  @param index block返回当前index
 */
- (void)priviousPicture:(void(^)(NSInteger))index;

@end
