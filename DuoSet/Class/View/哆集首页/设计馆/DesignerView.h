//
//  DesignerView.h
//  DuoSet
//
//  Created by fanfans on 2017/3/20.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DesignerData.h"

@interface DesignerView : UIView

@property(nonatomic,strong) UIButton *attentionBtn;
@property(nonatomic,strong) UIButton *markBtn;

-(void)setupInfoWithDesignerData:(DesignerData *)item;

@property(nonatomic,strong) UIImageView *tagImgV;

@end
