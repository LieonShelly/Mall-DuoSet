//
//  DuojiOrderModel.m
//  DuoSet
//
//  Created by fanfans on 2017/4/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DuojiOrderModel.h"
#import "MQImageUtil.h"
#import "DuojiOrderCell.h"

@implementation DuojiOrderModel

- (DuojiOrderModel *)initCellModelWithMessage:(DuojiProductMessage *)message
                                      cellWidth:(CGFloat)cellWidth
                                       delegate:(id<MQCellModelDelegate>)delegator{
    self = [super init];
    if (self) {
        _message = message;
        UserInfo *info = [Utils getUserInfo];
        _message.userAvatarPath = [NSString stringWithFormat:@"%@%@",BaseImgUrl,info.avatar];
        _message.userName = info.name;
        if (message.userAvatarImage) {
            _avatarImage = message.userAvatarImage;
        } else if (message.userAvatarPath.length > 0) {
            _avatarPath = message.userAvatarPath;
            [MQServiceToViewInterface downloadMediaWithUrlString:message.userAvatarPath progress:^(float progress) {
            } completion:^(NSData *mediaData, NSError *error) {
                if (mediaData && !error) {
                    _avatarImage = [UIImage imageWithData:mediaData];
                } else {
                    _avatarImage = message.fromType == MQChatMessageIncoming ? [MQChatViewConfig sharedConfig].incomingDefaultAvatarImage : [MQChatViewConfig sharedConfig].outgoingDefaultAvatarImage;
                }
                if (self.delegate) {
                    if ([self.delegate respondsToSelector:@selector(didUpdateCellDataWithMessageId:)]) {
                        //通知ViewController去刷新tableView
                        [self.delegate didUpdateCellDataWithMessageId:self.messageId];
                    }
                }
            }];
        } else {
            _avatarImage = [MQChatViewConfig sharedConfig].outgoingDefaultAvatarImage;
        }
        
        //发送出去的消息
        _cellFromType = MQChatCellOutgoing;
        _bubbleImage = [MQChatViewConfig sharedConfig].outgoingBubbleImage;
        _bubbleImage = [MQImageUtil convertImageColorWithImage:_bubbleImage toColor:[MQChatViewConfig sharedConfig].outgoingBubbleColor];
        
        //头像的frame
        _avatarFrame = CGRectMake(cellWidth-kMQCellAvatarToHorizontalEdgeSpacing-kMQCellAvatarDiameter, kMQCellAvatarToVerticalEdgeSpacing, kMQCellAvatarDiameter, kMQCellAvatarDiameter);
        //气泡的frame
        //气泡高度
        CGFloat bubbleHeight = FitHeight(200.0) + kMQCellBubbleToTextVerticalSpacing * 2;
        //气泡宽度
        CGFloat bubbleWidth = mainScreenWidth - FitWith(630.0) + kMQCellBubbleToTextHorizontalLargerSpacing + kMQCellBubbleToTextHorizontalSmallerSpacing;
        _bubbleImageFrame = CGRectMake(cellWidth-self.avatarFrame.size.width-kMQCellAvatarToHorizontalEdgeSpacing-kMQCellAvatarToBubbleSpacing-bubbleWidth, kMQCellAvatarToVerticalEdgeSpacing, bubbleWidth, bubbleHeight);
        
    }
    return self;
}

/**
 *  通过重用的名字初始化cell
 *  @return 初始化了一个cell
 */
- (MQChatBaseCell *)getCellWithReuseIdentifier:(NSString *)cellReuseIdentifer {
    return [[DuojiOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifer];
}

-(CGFloat)getCellHeight{
    return 130;
}

- (NSDate *)getCellDate {
    return self.date;
}

- (BOOL)isServiceRelatedCell {
    return true;
}

- (NSString *)getCellMessageId {
    return self.messageId;
}

- (void)updateCellSendStatus:(MQChatMessageSendStatus)sendStatus {
    self.sendStatus = sendStatus;
}

- (void)updateCellMessageId:(NSString *)messageId {
    _messageId = messageId;
}

- (void)updateCellMessageDate:(NSDate *)messageDate {
    _date = messageDate;
}

- (void)updateCellFrameWithCellWidth:(CGFloat)cellWidth {
    _cellWidth = cellWidth;
    //    if (self.cellFromType == MQChatCellOutgoing) {
    //        //头像的frame
    //        if ([MQChatViewConfig sharedConfig].enableOutgoingAvatar) {
    //            self.avatarFrame = CGRectMake(cellWidth-kMQCellAvatarToHorizontalEdgeSpacing-kMQCellAvatarDiameter, kMQCellAvatarToVerticalEdgeSpacing, kMQCellAvatarDiameter, kMQCellAvatarDiameter);
    //        } else {
    //            self.avatarFrame = CGRectMake(0, 0, 0, 0);
    //        }
    //        //气泡的frame
    //        self.bubbleImageFrame = CGRectMake(cellWidth-self.avatarFrame.size.width-kMQCellAvatarToHorizontalEdgeSpacing-kMQCellAvatarToBubbleSpacing-self.bubbleImageFrame.size.width, kMQCellAvatarToVerticalEdgeSpacing, self.bubbleImageFrame.size.width, self.bubbleImageFrame.size.height);
    //        //发送指示器的frame
    //        self.sendingIndicatorFrame = CGRectMake(self.bubbleImageFrame.origin.x-kMQCellBubbleToIndicatorSpacing-self.sendingIndicatorFrame.size.width, self.sendingIndicatorFrame.origin.y, self.sendingIndicatorFrame.size.width, self.sendingIndicatorFrame.size.height);
    //        //发送出错图片的frame
    //        self.sendFailureFrame = CGRectMake(self.bubbleImageFrame.origin.x-kMQCellBubbleToIndicatorSpacing-self.sendFailureFrame.size.width, self.sendFailureFrame.origin.y, self.sendFailureFrame.size.width, self.sendFailureFrame.size.height);
    //    }
    //文字最大宽度
    CGFloat maxLabelWidth = cellWidth - kMQCellAvatarToHorizontalEdgeSpacing - kMQCellAvatarDiameter - kMQCellAvatarToBubbleSpacing - kMQCellBubbleToTextHorizontalLargerSpacing - kMQCellBubbleToTextHorizontalSmallerSpacing - kMQCellBubbleMaxWidthToEdgeSpacing;
    
    //气泡高度
    CGFloat bubbleHeight = FitHeight(180.0) + kMQCellBubbleToTextVerticalSpacing * 2;
    //气泡宽度
    CGFloat bubbleWidth = FitWith(600.0) + kMQCellBubbleToTextHorizontalLargerSpacing + kMQCellBubbleToTextHorizontalSmallerSpacing;
    
    //根据消息的来源，进行处理
    UIImage *bubbleImage = [MQChatViewConfig sharedConfig].incomingBubbleImage;
    if ([MQChatViewConfig sharedConfig].incomingBubbleColor) {
        bubbleImage = [MQImageUtil convertImageColorWithImage:bubbleImage toColor:[MQChatViewConfig sharedConfig].incomingBubbleColor];
    }
    //发送出去的消息
    bubbleImage = [MQChatViewConfig sharedConfig].outgoingBubbleImage;
    if ([MQChatViewConfig sharedConfig].outgoingBubbleColor) {
        bubbleImage = [MQImageUtil convertImageColorWithImage:self.bubbleImage toColor:[MQChatViewConfig sharedConfig].outgoingBubbleColor];
    }
    //头像的frame
    if ([MQChatViewConfig sharedConfig].enableIncomingAvatar) {
        _avatarFrame = CGRectMake(kMQCellAvatarToHorizontalEdgeSpacing, kMQCellAvatarToVerticalEdgeSpacing, kMQCellAvatarDiameter, kMQCellAvatarDiameter);
    } else {
        _avatarFrame = CGRectMake(kMQCellAvatarToHorizontalEdgeSpacing, kMQCellAvatarToVerticalEdgeSpacing, 0, 0);
    }
    //气泡的frame
    _bubbleImageFrame = CGRectMake(self.avatarFrame.origin.x+self.avatarFrame.size.width+kMQCellAvatarToBubbleSpacing, self.avatarFrame.origin.y, bubbleWidth, bubbleHeight);
    //气泡图片
    _bubbleImage = [bubbleImage resizableImageWithCapInsets:[MQChatViewConfig sharedConfig].bubbleImageStretchInsets];
}
@end
