//
//  ProductTexDesCell.m
//  DuoSet
//
//  Created by fanfans on 2017/6/5.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ProductTexDesCell.h"

@interface ProductTexDesCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) UILabel *desLale;

@end

@implementation ProductTexDesCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        _desLale = [UILabel newAutoLayoutView];
        _desLale.textColor = [UIColor colorFromHex:0x222222];
        _desLale.font = CUSNEwFONT(15);
        _desLale.numberOfLines = 0;
        _desLale.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_desLale];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithProductDetailsArticle:(ProductDetailsArticle *)item{
    _desLale.text = item.remark;
}


- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        [_desLale autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(54.0)];
        [_desLale autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(54.0)];
        [_desLale autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
