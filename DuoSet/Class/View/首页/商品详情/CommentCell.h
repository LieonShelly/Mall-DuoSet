//
//  CommentCell.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/12.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell
@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UIImageView *coverImgView;
@property (nonatomic, strong) UILabel *gradeLabel1;//商品包装
@property (nonatomic, strong) UILabel *gradeLabel2;//发货速度
@property (nonatomic, strong) UILabel *timeLabel;



@end
