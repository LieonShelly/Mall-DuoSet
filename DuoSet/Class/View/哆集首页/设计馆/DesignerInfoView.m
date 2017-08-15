//
//  DesignerInfoView.m
//  DuoSet
//
//  Created by mac on 2017/1/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DesignerInfoView.h"

@interface DesignerInfoView()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UILabel *infoLable;

@end

@implementation DesignerInfoView

-(instancetype)init{
    self = [super init];
    if (self) {
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor colorFromHex:0xf2f2f2];
        [self addSubview:_bgView];
        
        _infoLable = [UILabel newAutoLayoutView];
        _infoLable.numberOfLines = 0;
        _infoLable.font = CUSFONT(11);
        _infoLable.textColor = [UIColor colorFromHex:0x666666];
        _infoLable.text = @"本人性格开朗、稳重、有活力，待人热情、真诚;工作认真负责，积极主动，能吃苦耐劳，用于承受压力，勇于创新;有很强的组织能力和团队协作精神，具有较强的适应能力;纪律性强，工作积极配合;意志坚强，具有较强的无私奉献精神";
        [_bgView addSubview:_infoLable];
        
        
        [self updateConstraints];
    }
    return self;
}

//-(void)setupInfoWithOrderProduct:(OrderProduct *)item{
//    [_productImgV sd_setImageWithURL:[NSURL URLWithString:item.productSmallImg] placeholderImage:[UIImage imageNamed:@""] options:0];
//    _productName.text = item.productName;
//    _productSubLable.text = item.standard;
//}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgesToSuperviewEdges];
        
        [_infoLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_infoLable autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_infoLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_infoLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
