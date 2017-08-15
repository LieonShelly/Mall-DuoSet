//
//  AftermarketContentCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "AftermarketContentCell.h"
#import "AftermarketTagView.h"
#import "ProductDetailsArticle.h"

@interface AftermarketContentCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) AftermarketTagView *aftermarketServe1;
@property(nonatomic,strong) AftermarketTagView *aftermarketServe2;
@property(nonatomic,strong) AftermarketTagView *aftermarketServe3;
//@property(nonatomic,strong) UIView *line;

@end

@implementation AftermarketContentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
        
        _aftermarketServe1 = [AftermarketTagView newAutoLayoutView];
        [self.contentView addSubview:_aftermarketServe1];
        
        _aftermarketServe2 = [AftermarketTagView newAutoLayoutView];
        [self.contentView addSubview:_aftermarketServe2];
        
        _aftermarketServe3 = [AftermarketTagView newAutoLayoutView];
        [self.contentView addSubview:_aftermarketServe3];
                
//        _line = [UIView newAutoLayoutView];
//        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
//        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithProductDetailsData:(ProductDetailsData *)item{
    if (item.articles.count > 0) {
        _aftermarketServe1.hidden = false;
        ProductDetailsArticle *itm = item.articles[0];
        [_aftermarketServe1 setupInfoWithProductDetailsArticle:itm];
    }
    if (item.articles.count > 1) {
        _aftermarketServe2.hidden = false;
        ProductDetailsArticle *itm = item.articles[1];
        [_aftermarketServe2 setupInfoWithProductDetailsArticle:itm];
    }
    if (item.articles.count > 2) {
        _aftermarketServe3.hidden = false;
        ProductDetailsArticle *itm = item.articles[2];
        [_aftermarketServe3 setupInfoWithProductDetailsArticle:itm];
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_aftermarketServe1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_aftermarketServe1 autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_aftermarketServe1 autoSetDimension:ALDimensionHeight toSize:FitHeight(90.0)];
//        [_aftermarketServe1 autoSetDimension:ALDimensionWidth toSize:FitWith(235.0)];
        
        [_aftermarketServe2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_aftermarketServe1 withOffset:FitWith(24.0)];
        [_aftermarketServe2 autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_aftermarketServe2 autoSetDimension:ALDimensionHeight toSize:FitHeight(90.0)];
        
        [_aftermarketServe3 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_aftermarketServe2 withOffset:FitWith(24.0)];
        [_aftermarketServe3 autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_aftermarketServe3 autoSetDimension:ALDimensionHeight toSize:FitHeight(90.0)];
        
//        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
//        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
//        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
//        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
