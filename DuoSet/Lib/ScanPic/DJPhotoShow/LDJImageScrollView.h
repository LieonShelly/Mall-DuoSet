//
//  LDJImageScrollView.h
//  exercise-lidengjie1
//
//  Created by BraveSoft on 12/10/15.
//  Copyright © 2015 lidengjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDJImageScrollView : UIScrollView <UIScrollViewDelegate> {
    BOOL isBig;
}

@property (strong, nonatomic) UIImageView *imageView;

- (void)changeSmall;

@end
