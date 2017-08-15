//
//  GlobalBuyHomeProductCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/15.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "GlobalBuyHomeProductCell.h"
#import "GlobalProductView.h"

@interface GlobalBuyHomeProductCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *coverImgV;
@property(nonatomic,strong) UIScrollView *bgScrollView;
@property(nonatomic,strong) NSMutableArray *productArr;
@property(nonatomic,strong) UIView *line;

@end

@implementation GlobalBuyHomeProductCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,FitHeight(20.0), mainScreenWidth, FitHeight(440))];
        _bgScrollView.showsHorizontalScrollIndicator = false;
        _bgScrollView.contentSize = CGSizeMake(FitWith(320.0) * 10, 0);
        [self.contentView addSubview:_bgScrollView];
        
        _productArr = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            GlobalProductView *view = [GlobalProductView newAutoLayoutView];
            view.userInteractionEnabled = true;
            view.tag = i;
            UITapGestureRecognizer*singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
            singleRecognizer.numberOfTapsRequired = 1;
            [view addGestureRecognizer:singleRecognizer];
            [_bgScrollView addSubview:view];
            [_productArr addObject:view];
        }
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithProductForListDataArr:(NSArray *)items{
    _bgScrollView.contentSize = CGSizeMake(FitWith(20.0) + (FitWith(320.0) + FitWith(10.0)) * items.count, 0);
    for (int i = 0; i < 10; i++) {
        GlobalProductView *view = _productArr[i];
        if (items.count == 0) {
            view.hidden = false;
            continue;
        }
        if (i <= items.count - 1) {
            ProductForListData *item = items[i];
            [view setupInfoWithProductForListData:item];
            view.hidden = false;
        }else{
            view.hidden = true;
        }
    }
}


-(void)SingleTap:(UITapGestureRecognizer *)tap{
    ProductTapBlock block = _productTapHandle;
    if (block) {
        block(tap.view.tag);
    }
}


- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        CGFloat productW = FitWith(320.0);
        for (int i = 0; i < 10; i++) {
            GlobalProductView *view = _productArr[i];
            [view autoPinEdgeToSuperviewEdge:ALEdgeTop];
            [view autoSetDimension:ALDimensionWidth toSize:productW];
            [view autoSetDimension:ALDimensionHeight toSize:FitHeight(420.0)];
            [view autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(20.0) + (productW + FitWith(10.0)) * i];
        }
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
