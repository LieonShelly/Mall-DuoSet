//
//  ReturnAndChangeChoicePicCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ReturnAndChangeChoicePicCell.h"

@interface ReturnAndChangeChoicePicCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;

@property (nonatomic,strong) UILabel *subLable;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,strong) UIView *line;

@end

@implementation ReturnAndChangeChoicePicCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _subLable = [UILabel newAutoLayoutView];
        _subLable.textColor = [UIColor colorFromHex:0x808080];
        _subLable.text = @"为帮助我们更好解决问题，上传照片最多9张，每张不超过5M。支持jpg/png";
        _subLable.font = CUSNEwFONT(14);
        _subLable.numberOfLines = 2;
        [self.contentView addSubview:_subLable];
        
        _width = (mainScreenWidth - FitWith(60) - FitWith(30))/3;
        _picView = [[PictureView alloc]initWithFrame:CGRectMake(0, FitHeight(80.0), mainScreenWidth + FitHeight(20), _width)];
        [self.contentView addSubview:_picView];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateFrameAndPicWithThumbnailsArray:(NSMutableArray *)thumbnailsArray{
    CGFloat height;
    _width = (mainScreenWidth - FitWith(60) - FitWith(30))/3;
    if (thumbnailsArray.count >= 3 && thumbnailsArray.count < 6) {
        height = _width*2 + FitWith(10);
    }else if (thumbnailsArray.count >= 6){
        height = _width*3 + FitWith(20);
    }else{
        height = _width;
    }
    _picView.frame = CGRectMake(0, FitHeight(80.0) + FitHeight(20), mainScreenWidth, height);
    [_picView diplayPicture:thumbnailsArray];
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_subLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(26.0)];
        [_subLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(26.0)];
        [_subLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
