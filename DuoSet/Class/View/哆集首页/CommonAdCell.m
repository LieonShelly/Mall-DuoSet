//
//  CommonAdCell.m
//  DuoSet
//
//  Created by mac on 2017/1/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CommonAdCell.h"

@interface CommonAdCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *adView;
@property(nonatomic,assign) BOOL isFill;

@end

@implementation CommonAdCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        
        _adView = [UIImageView newAutoLayoutView];
        _adView.image = [UIImage imageNamed:@"替代1"];
        _adView.contentMode = UIViewContentModeScaleAspectFill;
        _adView.layer.masksToBounds = true;
        [self.contentView addSubview:_adView];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
    
}

-(void)setImgFill:(BOOL)Fill{
    _didUpdateConstraints = false;
    _isFill = Fill;
    [self.contentView setNeedsUpdateConstraints];
}

-(void)setupInfoWithCurrentFashionData:(CurrentFashionData *)item{
    [_adView sd_setImageWithURL:[NSURL URLWithString:item.picture] placeholderImage:placeholderImage_702_420 options:0];
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        if (_isFill) {
            [_adView autoPinEdgesToSuperviewEdges];
        }else{
            [_adView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(20.0)];
            [_adView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(20.0)];
            [_adView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10.0)];
            [_adView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        }
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
