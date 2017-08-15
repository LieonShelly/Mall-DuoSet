//
//  productCommentCountCell.m
//  DuoSet
//
//  Created by mac on 2017/1/19.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "productCommentCountCell.h"

@interface productCommentCountCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UILabel *commentCountLable;
@property(nonatomic,strong) UILabel *percentLable;
@property(nonatomic,strong) UILabel *tipsLable;
@property(nonatomic,strong) UIView *line;

@end

@implementation productCommentCountCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _commentCountLable = [UILabel newAutoLayoutView];
        _commentCountLable.textColor = [UIColor colorFromHex:0x666666];
        _commentCountLable.textAlignment = NSTextAlignmentLeft;
        _commentCountLable.font = CUSNEwFONT(15);
        [self.contentView addSubview:_commentCountLable];
        
        _tipsLable = [UILabel newAutoLayoutView];
        _tipsLable.textColor = [UIColor colorFromHex:0x666666];
        _tipsLable.text = @"好评";
        _tipsLable.textAlignment = NSTextAlignmentRight;
        _tipsLable.font = CUSNEwFONT(15);
        [self.contentView addSubview:_tipsLable];
        
        _percentLable = [UILabel newAutoLayoutView];
        _percentLable.textColor = [UIColor mainColor];
        _percentLable.textAlignment = NSTextAlignmentRight;
        _percentLable.font = CUSNEwFONT(15);
        [self.contentView addSubview:_percentLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe8e8e8];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
    
}

-(void)setupInfoWithProductDetailsData:(ProductDetailsData *)item{
    _commentCountLable.text = [NSString stringWithFormat:@"评价（%@）",item.commentCount];
    if (item.commentCount.integerValue == 0) {
        _tipsLable.text = @"评价";
        _percentLable.textColor = [UIColor colorFromHex:0x666666];
        _percentLable.text = @"暂无";
    }else{
        _percentLable.text = [NSString stringWithFormat:@"%@%%",item.commentGood];
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_commentCountLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_commentCountLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_commentCountLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(20.0)];
        
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(20.0)];
        
        [_percentLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_percentLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_percentLable autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_tipsLable withOffset:0];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
