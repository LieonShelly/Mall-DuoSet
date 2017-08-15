//
//  DuojiProductCell.m
//  DuoSet
//
//  Created by fanfans on 2017/4/7.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DuojiProductCell.h"
#import "MEIQIA_TTTAttributedLabel.h"
#import "DuojiProductModel.h"
#import "MQImageUtil.h"

@interface DuojiProductCell()

@end

@implementation DuojiProductCell{
    
    UIImageView *avatarImageView;
    TTTAttributedLabel *textLabel;
    UIImageView *bubbleImageView;
    UIActivityIndicatorView *sendingIndicator;
    UIImageView *failureImageView;
    
    UIImageView *cover;
    UILabel *productNameLable;
    UILabel *subLable;
    UILabel *priceLable;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //初始化头像
        avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(mainScreenWidth - 16 - 36, 16, 36, 36)];
        avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:avatarImageView];
        //初始化气泡
        bubbleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 10, mainScreenWidth - 16 - 16 - 36 - 5, 100)];
        bubbleImageView.userInteractionEnabled = true;
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressBubbleView:)];
        [bubbleImageView addGestureRecognizer:tapGesture];
        [self.contentView addSubview:bubbleImageView];
        UIImage *bubbleImage = [MQChatViewConfig sharedConfig].incomingBubbleImage;
        //发送出去的消息
        bubbleImage = [MQChatViewConfig sharedConfig].outgoingBubbleImage;
        if ([MQChatViewConfig sharedConfig].outgoingBubbleColor) {
            bubbleImage = [MQImageUtil convertImageColorWithImage:bubbleImage toColor:[MQChatViewConfig sharedConfig].outgoingBubbleColor];
        }
        bubbleImageView.image = [bubbleImage resizableImageWithCapInsets:[MQChatViewConfig sharedConfig].bubbleImageStretchInsets];
        
        cover = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 80, 80)];
        cover.backgroundColor = [UIColor mainColor];
        cover.contentMode = UIViewContentModeScaleAspectFill;
        cover.layer.masksToBounds = true;
        [bubbleImageView addSubview:cover];
        
        productNameLable = [[UILabel alloc]initWithFrame:CGRectMake(cover.frame.origin.x + cover.frame.size.width + 5, 0, bubbleImageView.frame.size.width - 100, 50)];
        productNameLable.numberOfLines = 2;
        productNameLable.textColor = [UIColor colorFromHex:0x222222];
        productNameLable.font = CUSFONT(14);
        productNameLable.textAlignment = NSTextAlignmentLeft;
        [bubbleImageView addSubview:productNameLable];
        
        subLable = [[UILabel alloc]initWithFrame:CGRectMake(productNameLable.frame.origin.x, productNameLable.frame.origin.y + productNameLable.frame.size.height - 10, productNameLable.frame.size.width, 30)];
        subLable.numberOfLines = 1;
        subLable.textColor = [UIColor colorFromHex:0x808080];
        subLable.font = CUSFONT(10);
        subLable.textAlignment = NSTextAlignmentLeft;
        [bubbleImageView addSubview:subLable];
        
        priceLable = [[UILabel alloc]initWithFrame:CGRectMake(productNameLable.frame.origin.x, subLable.frame.origin.y + subLable.frame.size.height - 10, productNameLable.frame.size.width, 30)];
        priceLable.numberOfLines = 1;
        priceLable.textColor = [UIColor mainColor];
        priceLable.font = CUSFONT(12);
        priceLable.textAlignment = NSTextAlignmentLeft;
        [bubbleImageView addSubview:priceLable];
        
        //初始化indicator
        sendingIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        sendingIndicator.hidden = YES;
        [self.contentView addSubview:sendingIndicator];
        //初始化出错image
        failureImageView = [[UIImageView alloc] initWithImage:[MQChatViewConfig sharedConfig].messageSendFailureImage];
        UITapGestureRecognizer *tapFailureImageGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFailImage:)];
        failureImageView.userInteractionEnabled = true;
        [failureImageView addGestureRecognizer:tapFailureImageGesture];
        [self.contentView addSubview:failureImageView];
        
    }
    return self;
}

#pragma 长按事件
- (void)tapPressBubbleView:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MeiQiaProdcutCellChatNotify" object:nil];
}
#pragma 点击发送失败消息，重新发送事件
- (void)tapFailImage:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"重新发送吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

#pragma UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self.chatCellDelegate resendMessageInCell:self resendData:@{@"text" : textLabel.text}];
    }
}

#pragma MQChatCellProtocol
- (void)updateCellWithCellModel:(id<MQCellModelProtocol>)model {
    if (![model isKindOfClass:[DuojiProductModel class]]) {
        NSAssert(NO, @"传给 MQBotAnswerCellModel.h 的Model类型不正确");
        return ;
    }
    DuojiProductModel *cellModel = (DuojiProductModel *)model;
    //刷新头像
    if (cellModel.avatarImage) {
        avatarImageView.image = cellModel.avatarImage;
    }
//    avatarImageView.frame = cellModel.avatarFrame;
    if ([MQChatViewConfig sharedConfig].enableRoundAvatar) {
        avatarImageView.layer.masksToBounds = YES;
        avatarImageView.layer.cornerRadius = cellModel.avatarFrame.size.width/2;
    }
    
    //刷新气泡
//    bubbleImageView.image = cellModel.bubbleImage;
    
    //刷新indicator
    sendingIndicator.hidden = true;
    [sendingIndicator stopAnimating];
    if (cellModel.sendStatus == MQChatMessageSendStatusSending && cellModel.cellFromType == MQChatCellOutgoing) {
        sendingIndicator.hidden = false;
        sendingIndicator.frame = cellModel.sendingIndicatorFrame;
        [sendingIndicator startAnimating];
    }
    //刷新出错图片
    failureImageView.hidden = true;
    if (cellModel.sendStatus == MQChatMessageSendStatusFailure) {
        failureImageView.hidden = false;
        failureImageView.frame = cellModel.sendFailureFrame;
    }
    [cover sd_setImageWithURL:[NSURL URLWithString:cellModel.message.cover] placeholderImage:placeholderImage_372_440 options:0];
    productNameLable.text = cellModel.message.productName;
    subLable.text = cellModel.message.productSubName;
    priceLable.text = cellModel.message.price;
}


@end
