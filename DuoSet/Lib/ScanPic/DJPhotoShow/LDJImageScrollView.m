//
//  LDJImageScrollView.m
//  exercise-lidengjie1
//
//  Created by BraveSoft on 12/10/15.
//  Copyright © 2015 lidengjie. All rights reserved.
//

#import "LDJImageScrollView.h"

#define VIEW_WIDTH [UIScreen mainScreen].bounds.size.width
#define VIEW_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation LDJImageScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.frame = frame;
        [self initializeImageView];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initializeImageView {
    
    //设置前后30的空隙
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0,
                                                               CGRectGetWidth(self.bounds) * 2,
                                                               CGRectGetHeight(self.bounds) * 2)];
    _imageView.userInteractionEnabled = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth&UIViewAutoresizingFlexibleHeight;

    [self addSubview:_imageView];
    
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]
                                                initWithTarget:self
                                                        action:@selector(handleDoubleTap:)];
    [doubleTapGesture setNumberOfTapsRequired:2];
    [_imageView addGestureRecognizer:doubleTapGesture];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                                initWithTarget:self
                                                action:@selector(tapGesture:)];
    [tapGesture setNumberOfTapsRequired:1];
    [_imageView addGestureRecognizer:tapGesture];
    
    [tapGesture requireGestureRecognizerToFail:doubleTapGesture];
    
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc]
                                                    initWithTarget:self
                                                            action:@selector(rotationGesture:)];
    [_imageView addGestureRecognizer:rotationGesture];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    longPress.minimumPressDuration = 0.8; //定义按的时间
    longPress.numberOfTouchesRequired = 1;
    [_imageView addGestureRecognizer:longPress];
    
    
    float minimumScale = self.frame.size.width / _imageView.frame.size.width;
    self.minimumZoomScale = minimumScale;
    self.zoomScale = minimumScale;
}

/**
 *  Double click zoom
 *
 *  @param gesture gesture
 */
- (void)handleDoubleTap:(UIGestureRecognizer *)gesture
{
    if (!isBig) {
        isBig = YES;
        float newScale = self.zoomScale * 2;
        CGRect zoomRect;
        zoomRect.size.height = self.frame.size.height / newScale;
        zoomRect.size.width  = self.frame.size.width  / newScale;
        zoomRect.origin.x = [gesture locationInView:gesture.view].x - (zoomRect.size.width  / 2.0);
        zoomRect.origin.y = [gesture locationInView:gesture.view].y - (zoomRect.size.height / 2.0);
        [self zoomToRect:zoomRect animated:YES];
    }else {
        isBig = NO;
        float newScale = self.zoomScale / 2;
        CGRect zoomRect;
        zoomRect.size.height = self.frame.size.height / newScale;
        zoomRect.size.width  = self.frame.size.width  / newScale;
        zoomRect.origin.x = [gesture locationInView:gesture.view].x - (zoomRect.size.width  / 2.0);
        zoomRect.origin.y = [gesture locationInView:gesture.view].y - (zoomRect.size.height / 2.0);
        [self zoomToRect:zoomRect animated:YES];
    }
}

- (void)tapGesture: (UITapGestureRecognizer *)gesture {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DIS_MISS" object:nil userInfo:nil];
}

/**
 *  Rotate pictures
 *
 *  @param gesture gesture
 */
- (void)rotationGesture:(UIRotationGestureRecognizer *)gesture {
    
    NSLog(@"%f",gesture.rotation);
    static float lastRotationRate;
    if (gesture.state == UIGestureRecognizerStateBegan) {
        lastRotationRate = gesture.rotation;
    }
    if (gesture.state == UIGestureRecognizerStateChanged) {
        gesture.view.transform = CGAffineTransformRotate(gesture.view.transform, gesture.rotation - lastRotationRate);
        lastRotationRate = gesture.rotation;
    }
//    if (gesture.state == UIGestureRecognizerStateEnded) {
//        if (gesture.rotation >= -0.5 && gesture.rotation <= 0.5) {
////            gesture.view.transform = CGAffineTransformRotate(gesture.view.transform, 0);
//        }
//        if (gesture.rotation > 0.5 && gesture.rotation < 1.5) {
//            gesture.view.transform = CGAffineTransformMakeRotation(M_PI_2);
//        }
//        if (gesture.rotation  > -1.5 && gesture.rotation < -0.5) {
//            gesture.view.transform = CGAffineTransformMakeRotation(-M_PI_2);
//        }
//    }
}

-(void)longPressAction:(UILongPressGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Long_Press" object:nil userInfo:@{@"img":_imageView.image}];
    }
}

/**
 *  变为小图
 */
- (void)changeSmall {
    if (isBig) {
        isBig = NO;
        float newScale = self.zoomScale / 2;
        CGRect zoomRect;
        zoomRect.size.height = self.frame.size.height / newScale;
        zoomRect.size.width  = self.frame.size.width  / newScale;
        [self zoomToRect:zoomRect animated:YES];
    }
}

#pragma mark -- UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    [scrollView setZoomScale:scale animated:NO];
}

@end
