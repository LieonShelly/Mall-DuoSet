//
//  PictureModel.m
//  BossApp
//
//  Created by mac on 16/7/29.
//  Copyright © 2016年 ZDJY. All rights reserved.
//

#import "PictureModel.h"

@implementation PictureModel

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width - FitWith(60), - FitHeight(40), FitWith(100), FitWith(100))];
        [self addSubview:_deleteBtn];
        [_deleteBtn setImage:[UIImage imageNamed:@"pulic_pic_deleted"] forState:UIControlStateNormal];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}


- (void)tapAction:(UITapGestureRecognizer *)tapGesture{
    NSLog(@"%ld", tapGesture.view.tag);
    if (_pictureDelegate && [_pictureDelegate respondsToSelector:@selector(clickPictureWithTag:)]) {
        [_pictureDelegate clickPictureWithTag:tapGesture.view.tag];
    }
}


@end
