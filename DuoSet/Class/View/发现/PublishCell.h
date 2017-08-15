//
//  PublishCell.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/20.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublishCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *isBadBtn;
@property (weak, nonatomic) IBOutlet UIButton *isGoodBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
