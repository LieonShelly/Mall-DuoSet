//
//  CommonSievingSectionView.h
//  DuoSet
//
//  Created by mac on 2017/1/18.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ScreenSectionViewBlock)(NSInteger,UIButton*);

@interface CommonSievingSectionView : UICollectionReusableView

@property(nonatomic,copy) ScreenSectionViewBlock seletcedHandle;

@end
