//
//  PictureModel.h
//  BossApp
//
//  Created by mac on 16/7/29.
//  Copyright © 2016年 ZDJY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol pictureModelDelegate <NSObject>

@optional

- (void)clickPictureWithTag:(NSInteger)tag;

@end

@interface PictureModel : UIImageView

@property (nonatomic, weak) id<pictureModelDelegate>pictureDelegate;
@property (nonatomic, strong) UIButton *deleteBtn;


@end
