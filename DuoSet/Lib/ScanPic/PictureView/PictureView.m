//
//  PictureView.m
//  BossApp
//
//  Created by mac on 16/7/29.
//  Copyright © 2016年 ZDJY. All rights reserved.
//

#import "PictureView.h"


@implementation PictureView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)diplayPicture:(NSArray *)pictureArr{
    CGFloat width = (mainScreenWidth - FitWith(60) - FitWith(30))/3;
    NSArray *subView = self.subviews;
    for (UIView *view in subView) {
        [view removeFromSuperview];
    }
    if (pictureArr.count == 9) {//9个
        for (int i = 0; i < 3; i ++) {
            PictureModel *model = [[PictureModel alloc]initWithFrame:CGRectMake(FitWith(30) + i*(width + FitWith(15)), 0, width, width)];
            [self addSubview:model];
            id object =  pictureArr[i];
            if ([object isKindOfClass:[UIImage class]]) {
                model.image = object;
            }else{
                [model sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgUrl,object]] placeholderImage:[UIImage imageNamed:@""] options:0];
            }
            model.deleteBtn.tag = i;
            model.tag = model.deleteBtn.tag;
            model.pictureDelegate = self;
            [model.deleteBtn addTarget:self action:@selector(deletePicture:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        for (int i = 0; i < 3; i ++) {
            PictureModel *model = [[PictureModel alloc]initWithFrame:CGRectMake(FitWith(30) + i*(width + FitWith(15)), width + FitWith(10), width, width)];
            [self addSubview:model];
            id object =  pictureArr[i + 3];
            if ([object isKindOfClass:[UIImage class]]) {
                model.image = object;
            }else{
                [model sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgUrl,object]] placeholderImage:[UIImage imageNamed:@""] options:0];
            }
            model.deleteBtn.tag = i + 3;
            model.tag = model.deleteBtn.tag;
            model.pictureDelegate = self;
            [model.deleteBtn addTarget:self action:@selector(deletePicture:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        for (int i = 0; i < 3; i ++) {
            PictureModel *model = [[PictureModel alloc]initWithFrame:CGRectMake(FitWith(30) + i*(width + FitWith(15)), (width + FitWith(10)) * 2, width, width)];
            [self addSubview:model];
            id object =  pictureArr[i + 6];
            if ([object isKindOfClass:[UIImage class]]) {
                model.image = object;
            }else{
                [model sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgUrl,object]] placeholderImage:[UIImage imageNamed:@""] options:0];
            }
            model.deleteBtn.tag = i + 6;
            model.tag = model.deleteBtn.tag;
            model.pictureDelegate = self;
            [model.deleteBtn addTarget:self action:@selector(deletePicture:) forControlEvents:UIControlEventTouchUpInside];
        }
    }else if (pictureArr.count < 9 && pictureArr.count > 6){
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:addBtn];
        [addBtn setImage:[UIImage imageNamed:@"publicImgBtn"] forState:UIControlStateNormal];
        [addBtn setBackgroundImage:[Utils imageWithSize:CGSizeMake(width, width) borderColor:[UIColor colorFromHex:0xe4e4e4] borderWidth:1] forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addMorePicture) forControlEvents:UIControlEventTouchUpInside];
        addBtn.frame = CGRectMake(FitWith(30) + (pictureArr.count - 6)*(width + FitWith(15)),  (width + FitWith(10)) * 2, width, width);
        for (int i = 0; i < 3; i ++) {
            PictureModel *model = [[PictureModel alloc]initWithFrame:CGRectMake(FitWith(30) + i*(width + FitWith(15)), 0, width, width)];
            [self addSubview:model];
            id object =  pictureArr[i];
            if ([object isKindOfClass:[UIImage class]]) {
                model.image = object;
            }else{
                [model sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgUrl,object]] placeholderImage:[UIImage imageNamed:@""] options:0];
            }
            model.deleteBtn.tag = i;
            model.tag = model.deleteBtn.tag;
            model.pictureDelegate = self;
            [model.deleteBtn addTarget:self action:@selector(deletePicture:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        for (int i = 0; i < 3; i ++) {
            PictureModel *model = [[PictureModel alloc]initWithFrame:CGRectMake(FitWith(30) + i*(width + FitWith(15)), width + FitWith(10), width, width)];
            [self addSubview:model];
            id object =  pictureArr[i + 3];
            if ([object isKindOfClass:[UIImage class]]) {
                model.image = object;
            }else{
                [model sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgUrl,object]] placeholderImage:[UIImage imageNamed:@""] options:0];
            }
            model.deleteBtn.tag = i + 3;
            model.tag = model.deleteBtn.tag;
            model.pictureDelegate = self;
            [model.deleteBtn addTarget:self action:@selector(deletePicture:) forControlEvents:UIControlEventTouchUpInside];
        }
        for (int i = 0; i < pictureArr.count - 6; i ++) {
            PictureModel *model = [[PictureModel alloc]initWithFrame:CGRectMake(FitWith(30) + i*(width + FitWith(15)), (width + FitWith(15)) * 2, width, width)];
            [self addSubview:model];
            id object =  pictureArr[i + 6];
            if ([object isKindOfClass:[UIImage class]]) {
                model.image = object;
            }else{
                [model sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgUrl,object]] placeholderImage:[UIImage imageNamed:@""] options:0];
            }
            model.deleteBtn.tag = i + 6;
            model.tag = model.deleteBtn.tag;
            model.pictureDelegate = self;
            [model.deleteBtn addTarget:self action:@selector(deletePicture:) forControlEvents:UIControlEventTouchUpInside];
        }
    }else if (pictureArr.count == 6) {
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:addBtn];
        [addBtn setImage:[UIImage imageNamed:@"publicImgBtn"] forState:UIControlStateNormal];
        [addBtn setBackgroundImage:[Utils imageWithSize:CGSizeMake(width, width) borderColor:[UIColor colorFromHex:0xe4e4e4] borderWidth:1] forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addMorePicture) forControlEvents:UIControlEventTouchUpInside];
        addBtn.frame = CGRectMake(FitWith(30), (width + FitWith(10)) * 2, width, width);
        
        for (int i = 0; i < 3; i ++) {
            PictureModel *model = [[PictureModel alloc]initWithFrame:CGRectMake(FitWith(30) + i*(width + FitWith(15)), 0, width, width)];
            [self addSubview:model];
            id object =  pictureArr[i];
            if ([object isKindOfClass:[UIImage class]]) {
                model.image = object;
            }else{
                [model sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgUrl,object]] placeholderImage:[UIImage imageNamed:@""] options:0];
            }
            model.deleteBtn.tag = i;
            model.tag = model.deleteBtn.tag;
            model.pictureDelegate = self;
            [model.deleteBtn addTarget:self action:@selector(deletePicture:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        for (int i = 0; i < 3; i ++) {
            PictureModel *model = [[PictureModel alloc]initWithFrame:CGRectMake(FitWith(30) + i*(width + FitWith(15)), width + FitWith(10), width, width)];
            [self addSubview:model];
            id object =  pictureArr[i + 3];
            if ([object isKindOfClass:[UIImage class]]) {
                model.image = object;
            }else{
                [model sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgUrl,object]] placeholderImage:[UIImage imageNamed:@""] options:0];
            }
            model.deleteBtn.tag = i + 3;
            model.tag = model.deleteBtn.tag;
            model.pictureDelegate = self;
            [model.deleteBtn addTarget:self action:@selector(deletePicture:) forControlEvents:UIControlEventTouchUpInside];
        }
    }else{
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:addBtn];
        [addBtn setImage:[UIImage imageNamed:@"publicImgBtn"] forState:UIControlStateNormal];
        [addBtn setBackgroundImage:[Utils imageWithSize:CGSizeMake(width, width) borderColor:[UIColor colorFromHex:0xe4e4e4] borderWidth:1] forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addMorePicture) forControlEvents:UIControlEventTouchUpInside];
        
        if (pictureArr.count == 0) {
            addBtn.frame = CGRectMake(FitWith(30), 0, width, width);
        }else if (pictureArr.count > 0 && pictureArr.count < 3){
            
            for (int i = 0; i < pictureArr.count; i ++) {
                PictureModel *model = [[PictureModel alloc]initWithFrame:CGRectMake(FitWith(30) + i*(width + FitWith(15)), 0, width, width)];
                [self addSubview:model];
                id object =  pictureArr[i];
                if ([object isKindOfClass:[UIImage class]]) {
                    model.image = object;
                }else{
                    [model sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgUrl,object]] placeholderImage:[UIImage imageNamed:@""] options:0];
                }
                model.deleteBtn.tag = i;
                model.tag = model.deleteBtn.tag;
                model.pictureDelegate = self;
                [model.deleteBtn addTarget:self action:@selector(deletePicture:) forControlEvents:UIControlEventTouchUpInside];
            }
            addBtn.frame = CGRectMake(FitWith(30) + pictureArr.count*(width + FitWith(15)), 0, width, width);
            
        }else if (pictureArr.count == 3){
            for (int i = 0; i < pictureArr.count; i ++) {
                PictureModel *model = [[PictureModel alloc]initWithFrame:CGRectMake(FitWith(30) + i*(width + FitWith(15)), 0, width, width)];
                [self addSubview:model];
                id object =  pictureArr[i];
                if ([object isKindOfClass:[UIImage class]]) {
                    model.image = object;
                }else{
                    [model sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgUrl,object]] placeholderImage:[UIImage imageNamed:@""] options:0];
                }
                model.deleteBtn.tag = i;
                model.tag = model.deleteBtn.tag;
                model.pictureDelegate = self;
                [model.deleteBtn addTarget:self action:@selector(deletePicture:) forControlEvents:UIControlEventTouchUpInside];
            }
            addBtn.frame = CGRectMake(FitWith(30), width + FitWith(15), width, width);
        }else if (pictureArr.count > 3 && pictureArr.count <6){
        
            for (int i = 0; i < 3; i ++) {
                PictureModel *model = [[PictureModel alloc]initWithFrame:CGRectMake(FitWith(30) + i*(width + FitWith(15)), 0, width, width)];
                [self addSubview:model];
                id object =  pictureArr[i];
                if ([object isKindOfClass:[UIImage class]]) {
                    model.image = object;
                }else{
                    [model sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgUrl,object]] placeholderImage:[UIImage imageNamed:@""] options:0];
                }
                model.deleteBtn.tag = i;
                model.tag = model.deleteBtn.tag;
                model.pictureDelegate = self;
                [model.deleteBtn addTarget:self action:@selector(deletePicture:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            for (int i = 0; i < pictureArr.count - 3; i ++) {
                PictureModel *model = [[PictureModel alloc]initWithFrame:CGRectMake(FitWith(30) + i*(width + FitWith(15)), width + FitWith(15), width, width)];
                [self addSubview:model];
                id object =  pictureArr[i + 3];
                if ([object isKindOfClass:[UIImage class]]) {
                    model.image = object;
                }else{
                    [model sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgUrl,object]] placeholderImage:[UIImage imageNamed:@""] options:0];
                }
                model.deleteBtn.tag = i + 3;
                model.tag = model.deleteBtn.tag;
                model.pictureDelegate = self;
                [model.deleteBtn addTarget:self action:@selector(deletePicture:) forControlEvents:UIControlEventTouchUpInside];
            }
            addBtn.frame = CGRectMake(FitWith(30) + (pictureArr.count - 3)*(width + FitWith(15)), width + FitWith(15), width, width);
        }
    }
}


- (void)addMorePicture{
    addMorePictureBlock block = _handleBlock;
    if (block) {
        block();
    } 
}


- (void)deletePicture:(UIButton *)btn{
    deletePictureBlock block = _deleteBlock;
    if (block) {
        block(btn.tag);
    }
}

- (void)clickPictureWithTag:(NSInteger)tag{
    if (_delegate && [_delegate respondsToSelector:@selector(extendPictureWithTag:)]){
        [_delegate extendPictureWithTag:tag];
    }
}

@end
