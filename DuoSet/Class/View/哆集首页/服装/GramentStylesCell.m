//
//  GramentStylesCell.m
//  DuoSet
//
//  Created by mac on 2017/1/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "GramentStylesCell.h"

@interface GramentStylesCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) NSMutableArray *imgVArr;

@end

@implementation GramentStylesCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        _imgVArr = [NSMutableArray array];
        for (int i = 0; i < 6; i++) {
            UIImageView *imgV = [UIImageView newAutoLayoutView];
            imgV.image = [UIImage imageNamed:@"替代6"];
            imgV.contentMode = UIViewContentModeScaleAspectFill;
            imgV.layer.masksToBounds = true;
            imgV.tag = i;
            UITapGestureRecognizer*singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
            singleRecognizer.numberOfTapsRequired = 1;
            [imgV addGestureRecognizer:singleRecognizer];
            [self.contentView addSubview:imgV];
            imgV.userInteractionEnabled = true;
            [_imgVArr addObject:imgV];
        }
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)SingleTap:(UITapGestureRecognizer *)tap{
    GramentStyleChoiceBlock block = _selectedHandle;
    if (block) {
        block(tap.view.tag);
    }
}


- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        CGFloat imgW = FitWith(217.0);
        CGFloat imgH = FitHeight(118.0);
        for (int i = 0; i < 6; i++) {
            UIImageView *imgV = _imgVArr[i];
            if (i < 3) {
                [imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0) + (imgW + FitWith(20.0)) * i];
                [imgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
            }
            if (i >= 3) {
                [imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0) + (imgW + FitWith(20.0)) * (i - 3)];
                [imgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20) + FitWith(20.0) + imgH];
            }
            [imgV autoSetDimension:ALDimensionWidth toSize:imgW];
            [imgV autoSetDimension:ALDimensionHeight toSize:imgH];
        }
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
