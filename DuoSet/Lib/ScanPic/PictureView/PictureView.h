//
//  PictureView.h
//  BossApp
//
//  Created by mac on 16/7/29.
//  Copyright © 2016年 ZDJY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureModel.h"

@protocol extendPictureDelegate <NSObject>

@optional

- (void)extendPictureWithTag:(NSInteger)tag;

@end

typedef void(^addMorePictureBlock)();
typedef void(^deletePictureBlock)(NSInteger);

@interface PictureView : UIView<pictureModelDelegate>

@property (nonatomic, weak) id<extendPictureDelegate>delegate;

@property (nonatomic, strong) NSArray *pictureArray;

@property (nonatomic, copy) addMorePictureBlock handleBlock;

@property (nonatomic, copy) deletePictureBlock deleteBlock;

- (void)diplayPicture:(NSArray *)pictureArr;

@end
