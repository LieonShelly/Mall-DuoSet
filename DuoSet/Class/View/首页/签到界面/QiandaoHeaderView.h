//
//  QiandaoHeaderView.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/2.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QiandaoHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIButton *iconView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *qiandaoAction;

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (nonatomic, copy) void(^qiandaoActiom)();

//+(instancetype) headerView;
//@property (nonatomic, strong) UIImageView *coverImg;
//@property (nonatomic, strong) UIImageView *iconImg;
//@property (nonatomic, strong) UILabel *nameLabel;
//@property (nonatomic, strong) UILabel *titleLabel;
//@property (nonatomic, strong) UIButton *qiandaoBtn;

@end
