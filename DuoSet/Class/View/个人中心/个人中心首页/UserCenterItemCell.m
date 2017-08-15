//
//  UserCenterItemCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/6.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "UserCenterItemCell.h"

@interface UserCenterItemCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) NSMutableArray *btnArr;
@property (nonatomic,strong) NSMutableArray *countLableArr;
@property (nonatomic,strong) NSMutableArray *countNameArr;
@property (nonatomic,strong) NSMutableArray *classNameLableArr;
@property (nonatomic,strong) NSArray *classNameArr;
@property (nonatomic,strong) UIView *line;

@end

@implementation UserCenterItemCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _btnArr = [NSMutableArray array];
        _countNameArr = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0", nil];
        _classNameArr = @[@"我的哆豆", @"优惠券", @"收藏关注", @"我的钱包"];
        _countLableArr = [NSMutableArray array];
        _classNameLableArr = [NSMutableArray array];
        
        for (int i = 0; i < 4; i++) {
            UILabel *countLable = [ UILabel newAutoLayoutView];
            countLable.textColor = [UIColor mainColor];
            countLable.textAlignment = NSTextAlignmentCenter;
            countLable.font = CUSFONT(16);
            countLable.text = _countNameArr[i];
            [_countLableArr addObject:countLable];
            [self.contentView addSubview:countLable];
            
            UILabel *classLable = [UILabel newAutoLayoutView];
            classLable.textColor = [UIColor colorFromHex:0x222222];
            classLable.textAlignment = NSTextAlignmentCenter;
            classLable.font = CUSFONT(11);
            classLable.text = _classNameArr[i];
            [_classNameLableArr addObject:classLable];
            [self.contentView addSubview:classLable];
            
            UIButton *btn = [UIButton newAutoLayoutView];
            btn.tag = i;
            [_btnArr addObject:btn];
            [btn addTarget:self action:@selector(orderChoice:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:btn];
        }
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithUserCenterMainData:(UserCenterMainData *)item{
    NSString *balanceStr = @"";
    if (item.balance.floatValue == 0.0) {
        balanceStr = @"0";
    }else{
        balanceStr = [NSString stringWithFormat:@"%.2lf",item.balance.floatValue];
    }
    _countNameArr = [NSMutableArray arrayWithObjects:item.pointCount,item.couponCodeCount,item.collectCount,balanceStr, nil];
    for (int i = 0; i < 4; i++) {
        UILabel *countLable = _countLableArr[i];
        countLable.text = _countNameArr[i];
    }
}

-(void)clearUserCountData{
    _countNameArr = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0", nil];
    for (int i = 0; i < 4; i++) {
        UILabel *countLable = _countLableArr[i];
        countLable.text = _countNameArr[i];
    }
}

-(void)orderChoice:(UIButton *)btn{
    ItemActionBlock block = _itemTapHandle;
    if (block) {
        block(btn.tag);
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        for (int i = 0 ; i < 4; i++) {
            
            UILabel *countLable = _countLableArr[i];
            [countLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:(mainScreenWidth/4) * i];
            [countLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
            [countLable autoSetDimension:ALDimensionWidth toSize:mainScreenWidth/4];
            
            UILabel *classLable = _classNameLableArr[i];
            [classLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:(mainScreenWidth/4) * i];
            [classLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(80.0)];
            [classLable autoSetDimension:ALDimensionWidth toSize:mainScreenWidth/4];
            
            UIButton *btn = _btnArr[i];
            [btn autoSetDimension:ALDimensionWidth toSize:mainScreenWidth/4];
            [btn autoPinEdgeToSuperviewEdge:ALEdgeTop];
            [btn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
            [btn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:(mainScreenWidth/4) * i];
        }
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
