//
//  MessageCell.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/7.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _iconImgView.image = [UIImage imageNamed:@"notifi_img"];
    _iconImgView.layer.contentsScale = 3;
    _iconImgView.layer.masksToBounds = true;
    
    _noticeNameLabel.font = CUSFONT(12);
    _noticeNameLabel.textColor = [UIColor colorFromHex:0x333333];
    
    _detailLabel.font = CUSFONT(11);
    _detailLabel.textColor = [UIColor colorFromHex:0x666666];
    
    _timeLabel.font = CUSFONT(9);
    _timeLabel.textColor = [UIColor colorFromHex:0x999999];
}

-(void)setuoInfoWithSystemMessageModel:(SystemMessageModel *)item{
    _noticeNameLabel.text = item.title;
    _detailLabel.text = item.content;
    _timeLabel.text = item.createTime;
}

@end
