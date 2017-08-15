//
//  PiazzaMessageDetailsCell.h
//  DuoSet
//
//  Created by fanfans on 2017/3/10.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PiazzaData.h"

typedef void(^ImgViewTapActionBlock)(NSInteger);

@interface PiazzaMessageDetailsCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithPiazzaData:(PiazzaData *)item;
-(void)setupInfoWithPiazzaData:(PiazzaData *)item;

@property(nonatomic,copy) ImgViewTapActionBlock imgHandle;


@end
