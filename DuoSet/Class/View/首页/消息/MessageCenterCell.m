//
//  MessageCenterCell.m
//  DuoSet
//
//  Created by fanfans on 2017/2/27.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "MessageCenterCell.h"

@interface MessageCenterCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIImageView *messageCenterImgV;
@property (nonatomic,strong) UILabel *nameLable;
@property (nonatomic,strong) UILabel *subTitleLable;
@property (nonatomic,strong) UILabel *dateLable;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UILabel *unReadLable;

@end

@implementation MessageCenterCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _messageCenterImgV = [UIImageView newAutoLayoutView];
        [self.contentView addSubview:_messageCenterImgV];
        
        _nameLable = [UILabel newAutoLayoutView];
        _nameLable.textAlignment = NSTextAlignmentLeft;
        _nameLable.font = CUSFONT(12);
        _nameLable.text = @"系统通知";
        _nameLable.textColor = [UIColor colorFromHex:0x222222];
        [self.contentView addSubview:_nameLable];
        
        _subTitleLable = [UILabel newAutoLayoutView];
        _subTitleLable.textAlignment = NSTextAlignmentLeft;
        _subTitleLable.font = CUSFONT(12);
        _subTitleLable.text = @"您有一比未支付的订单即将失效";
        _subTitleLable.textColor = [UIColor colorFromHex:0x666666];
        [self.contentView addSubview:_subTitleLable];
        
        _dateLable = [UILabel newAutoLayoutView];
        _dateLable.textAlignment = NSTextAlignmentRight;
        _dateLable.font = CUSFONT(11);
        _dateLable.text = @"17/02/26";
        _dateLable.textColor = [UIColor colorFromHex:0x666666];
        [self.contentView addSubview:_dateLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe4e4e4];
        [self.contentView addSubview:_line];
        
        _unReadLable = [UILabel newAutoLayoutView];
        _unReadLable.backgroundColor = [UIColor mainColor];
        _unReadLable.textColor = [UIColor whiteColor];
        _unReadLable.textAlignment = NSTextAlignmentCenter;
        _unReadLable.font = CUSFONT(8);
        _unReadLable.text = @"99+";
        _unReadLable.layer.cornerRadius = FitWith(40.0) * 0.5;
        _unReadLable.layer.masksToBounds = true;
        [self.contentView addSubview:_unReadLable];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithMessageCenterData:(MessageCenterData *)item{
    if (item.message.content.length == 0) {
        _subTitleLable.text = @"暂无消息";
    }else{
        _subTitleLable.text = item.message.content;
    }
    _dateLable.text = item.message.createTime;
    _unReadLable.text = item.unReadCount.integerValue > 99 ? @"99+" : item.unReadCount;
    _unReadLable.hidden = item.unReadCount.integerValue == 0;
    [_messageCenterImgV sd_setImageWithURL:[NSURL URLWithString:item.typeIcon] placeholderImage:placeholderImage_226_256 options:0];
    _nameLable.text = item.typeName;
}


- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_messageCenterImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_messageCenterImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitWith(24.0)];
        [_messageCenterImgV autoSetDimension:ALDimensionWidth toSize:FitWith(100.0)];
        [_messageCenterImgV autoSetDimension:ALDimensionHeight toSize:FitWith(100.0)];
        
        [_unReadLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_messageCenterImgV];
        [_unReadLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(90.0)];
        [_unReadLable autoSetDimension:ALDimensionWidth toSize:FitWith(40.0)];
        [_unReadLable autoSetDimension:ALDimensionHeight toSize:FitWith(40.0)];
        
        [_nameLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitWith(30.0)];
        [_nameLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_messageCenterImgV withOffset:FitWith(60.0)];
        
        [_subTitleLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_nameLable];
        [_subTitleLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_nameLable withOffset:FitHeight(20.0)];
        [_subTitleLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        
        [_dateLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_nameLable];
        [_dateLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
