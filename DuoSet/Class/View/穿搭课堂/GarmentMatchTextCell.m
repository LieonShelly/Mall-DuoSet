//
//  GarmentMatchTextCell.m
//  DuoSet
//
//  Created by mac on 2017/1/19.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "GarmentMatchTextCell.h"

@interface GarmentMatchTextCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UILabel *textLable;

@end

@implementation GarmentMatchTextCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _textLable = [UILabel newAutoLayoutView];
        _textLable.textColor = [UIColor colorFromHex:0x666666];
        _textLable.textAlignment = NSTextAlignmentCenter;
        _textLable.text = @"今年上市的连衣裙很好看的哦。今年上市的连衣裙很好看的哦。今年上市的连衣裙很好看的哦。今年上市的连衣裙很好看的哦。今年上市的连衣裙很好看的哦。今年上市的连衣裙很好看的哦。今年上市的连衣裙很好看的哦。今年上市的连衣裙很好看的哦。今年上市的连衣裙很好看的哦。今年上市的连衣裙很好看的哦。今年上市的连衣裙很好看的哦。今年上市的连衣裙很好看的哦。今年上市的连衣裙很好看的哦。今年上市的连衣裙很好看的哦。今年上市的连衣裙很好看的哦。今年上市的连衣裙很好看的哦。今年上市的连衣裙很好看的哦。今年上市的连衣裙很好看的哦。今年上市的连衣裙很好看的哦。今年上市的连衣裙很好看的哦。今年上市的连衣裙很好看的哦。今年上市的连衣裙很好看的哦。";
        _textLable.font = CUSFONT(11);
        _textLable.numberOfLines = 0;
        [self.contentView addSubview:_textLable];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_textLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
        [_textLable autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(20.0)];
        [_textLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_textLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
