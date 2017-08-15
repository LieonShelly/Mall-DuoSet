//
//  LDJScrollView.m
//  exercise-lidengjie1
//
//  Created by BraveSoft on 12/10/15.
//  Copyright © 2015 lidengjie. All rights reserved.
//

#import "LDJScrollView.h"
#import "LDJImageScrollView.h"
//#import <SDWebImage/SDImageCache.h>
//#import <SDWebImage/UIImageView+WebCache.h>

#define VIEW_WIDTH [UIScreen mainScreen].bounds.size.width
#define VIEW_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface LDJScrollView()

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation LDJScrollView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_timer invalidate];
}

- (void)initializeUserInterface {
    _timer = [NSTimer scheduledTimerWithTimeInterval:2    target:self
                                            selector:@selector(changeOffset)
                                            userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    _timer.fireDate = [NSDate distantFuture];
    
    self.contentView                    = [NSMutableArray array];
    self.backgroundColor                = [UIColor clearColor];
    self.contentSize                    = CGSizeMake(CGRectGetWidth(self.bounds) * 3,
                                                     CGRectGetHeight(self.bounds));
    self.contentOffset                  = CGPointMake(CGRectGetWidth(self.bounds), 0);
    self.showsVerticalScrollIndicator   = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.delegate                       = self;
    self.pagingEnabled                  = YES;
    
    for (NSInteger i = 0; i < 3; i++) {
        LDJImageScrollView *imageScrollView = [[LDJImageScrollView alloc] initWithFrame:
                                               CGRectMake(CGRectGetWidth(self.bounds) * i, 0,
                                                          CGRectGetWidth(self.bounds),
                                                          CGRectGetHeight(self.bounds))];
        if (_imageArray.count > 0) {
            NSInteger index  = [self indexWithCurrentIndex:_currentIndex + i - 1
                                                totalCount:_imageArray.count];
            imageScrollView.imageView.image = _imageArray[index];
        }else{
            NSInteger index = [self indexWithCurrentIndex:_currentIndex + i - 1
                                               totalCount:_imageUrlArray.count];
            [imageScrollView.imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrlArray[index]] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRefreshCached];
        }
        
        [self addSubview:imageScrollView];
        
        imageScrollView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addObject:imageScrollView];
    }
}

#pragma mark -- start/stop animation
- (void)startAnimation {
    
    _timer.fireDate = [NSDate distantPast];
//    [_imageScrollView changeSmall];
}

- (void)stopAnimation:(void (^)(NSInteger))index {
    
    _timer.fireDate = [NSDate distantFuture];
    index(_currentIndex);
}

#pragma mark -- next/privious
- (void)nextPicture:(void(^)(NSInteger))index {
//    [_imageScrollView changeSmall];
    
    if (isAnimating) {
        return;
    }
    isAnimating = YES;
    [self changeOffset];
    [self performSelector:@selector(isAnimatingChange)
               withObject:nil afterDelay:0.3];
    index(_currentIndex + 1);
}

- (void)priviousPicture:(void(^)(NSInteger))index {
//    [_imageScrollView changeSmall];
    
    if (isAnimating) {
        return;
    }
    isAnimating = YES;
    [self setContentOffset:CGPointMake(self.bounds.size.width - self.contentOffset.x, 0)
                  animated:YES];
    [self updateScrollView:self];
    [self performSelector:@selector(isAnimatingChange)
               withObject:nil afterDelay:0.3];
    index(_currentIndex - 1);
}

/**
 *  更新当前显示图片
 *
 *  @param scrollView self
 */
- (void)updateScrollView:(UIScrollView *)scrollView {
    BOOL shouldUpdate = NO;
    if (scrollView.contentOffset.x <= 0) {
        if (_imageArray.count > 0) {
            _currentIndex = [self indexWithCurrentIndex:_currentIndex - 1
                                             totalCount:_imageArray.count];
        }else{
            _currentIndex = [self indexWithCurrentIndex:_currentIndex - 1
                                             totalCount:_imageUrlArray.count];
        }
        
        shouldUpdate = YES;
    }
    if (scrollView.contentOffset.x >= CGRectGetWidth(self.bounds) * 2) {
        if (_imageArray.count > 0) {
            _currentIndex = [self indexWithCurrentIndex:_currentIndex + 1
                                             totalCount:_imageArray.count];
        }else{
            _currentIndex = [self indexWithCurrentIndex:_currentIndex + 1
                                             totalCount:_imageUrlArray.count];
        }
        
        
        
        shouldUpdate = YES;
    }
    if (!shouldUpdate) {
        return;
    }
    
    for (NSInteger i = 0; i < 3; i++) {
        LDJImageScrollView *imageView = (LDJImageScrollView *)_contentView[i];
        if (_imageArray.count > 0) {
            NSInteger index = [self indexWithCurrentIndex:_currentIndex + i - 1
                                               totalCount:_imageArray.count];
            imageView.imageView.image = _imageArray[index];
        }else{
            NSInteger index = [self indexWithCurrentIndex:_currentIndex + i - 1
                                               totalCount:_imageUrlArray.count];
            [imageView.imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrlArray[index]] placeholderImage:[UIImage imageNamed:@"placeholderImage.jpg"] options:SDWebImageRefreshCached];
        }

    }
    //复位
    [self resumeScrollView:scrollView animated:YES];
}

/**
 *  复位
 *
 *  @param scrollView 滚动视图
 *  @param animated   是否动画
 */
- (void)resumeScrollView:(UIScrollView *)scrollView animated:(BOOL)animated{
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.bounds), 0)
                        animated:NO];
    [self updateScrollView:self];
}


/**
 *  求当前下标
 *
 *  @param currentIndex 当前下标
 *  @param totalCount   总共的图片数量
 *
 *  @return 当前图片在数组中的下标
 */
- (NSInteger)indexWithCurrentIndex:(NSInteger)currentIndex
                        totalCount:(NSInteger)totalCount {
    if (currentIndex < 0) {
        currentIndex = totalCount - 1;
    }
    if (currentIndex > totalCount - 1) {
        currentIndex = 0;
    }
    return currentIndex;
}

/**
 *  下一张图片
 */
- (void)changeOffset {
    [self setContentOffset:CGPointMake(self.bounds.size.width + self.contentOffset.x, 0)
                  animated:YES];
    [self updateScrollView:self];
}

/**
 *  改变是否在动画状态
 */
- (void)isAnimatingChange {
    isAnimating = NO;
}

#pragma mark -- <UIScrollViewDelegate>

/**
 *  当滑动scrollview完调用
 *
 *  @param scrollView self
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    [_imageScrollView changeSmall];
    [self updateScrollView:self];
    //滑动通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"INDEX_CHANGED" object:nil userInfo:@{@"index":@(_currentIndex)}];
}

@end
