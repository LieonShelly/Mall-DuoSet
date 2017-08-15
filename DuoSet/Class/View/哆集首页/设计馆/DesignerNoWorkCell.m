//
//  DesignerNoWorkCell.m
//  DuoSet
//
//  Created by fanfans on 2017/4/1.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DesignerNoWorkCell.h"

@interface DesignerNoWorkCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *imgV;
@property(nonatomic,strong) UILabel *noWorkLable;

@end

@implementation DesignerNoWorkCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
        
        _imgV = [UIImageView newAutoLayoutView];
        _imgV.contentMode = UIViewContentModeScaleAspectFill;
        _imgV.image = [UIImage imageNamed:@"defeated_no_order"];
        [self.contentView addSubview:_imgV];
        
        _noWorkLable = [UILabel newAutoLayoutView];
        _noWorkLable.textColor = [UIColor colorFromHex:0x808080];
        _noWorkLable.text = @"喔哦，你查看的内容不存在~";
        _noWorkLable.textAlignment = NSTextAlignmentCenter;
        _noWorkLable.font = CUSFONT(12);
        [self.contentView addSubview:_noWorkLable];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}
- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        UIImage *img = [UIImage imageNamed:@"defeated_no_details"];
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20)];
        [_imgV autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_imgV autoSetDimension:ALDimensionWidth toSize:img.size.width];
        [_imgV autoSetDimension:ALDimensionHeight toSize:img.size.height];
        
        [_noWorkLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_imgV withOffset:FitHeight(70)];
        [_noWorkLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
