//
//  ReturnAndChangeAddressCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ReturnAndChangeAddressCell.h"

@interface ReturnAndChangeAddressCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *tipLable;
@property (nonatomic,strong) UILabel *deslable;

@property (nonatomic,strong) UILabel *nameLable;
@property (nonatomic,strong) UILabel *phoneLable;
@property (nonatomic,strong) UILabel *addressLable;
@property (nonatomic,strong) UIImageView *rightArrow;

@end

@implementation ReturnAndChangeAddressCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        
        _tipLable = [UILabel newAutoLayoutView];
        _tipLable.textColor = [UIColor colorFromHex:0x212121];
        _tipLable.textAlignment = NSTextAlignmentLeft;
        _tipLable.text = @"收货地址";
        _tipLable.font = CUSNEwFONT(16);
        [_bgView addSubview:_tipLable];
        
        _deslable = [UILabel newAutoLayoutView];
        _deslable.textColor = [UIColor colorFromHex:0x808080];
        _deslable.textAlignment = NSTextAlignmentLeft;
        _deslable.text = @"（该地址是哆集回寄给您的地址）";
        _deslable.font = CUSNEwFONT(14);
        [_bgView addSubview:_deslable];
        
        _nameLable = [UILabel newAutoLayoutView];
        _nameLable.textColor = [UIColor colorFromHex:0x212121];
        _nameLable.textAlignment = NSTextAlignmentLeft;
        _nameLable.font = CUSNEwFONT(16);
        [_bgView addSubview:_nameLable];
        
        _phoneLable = [UILabel newAutoLayoutView];
        _phoneLable.textColor = [UIColor colorFromHex:0x212121];
        _phoneLable.textAlignment = NSTextAlignmentLeft;
        _phoneLable.font = CUSNEwFONT(16);
        [_bgView addSubview:_phoneLable];
        
        _addressLable = [UILabel newAutoLayoutView];
        _addressLable.textColor = [UIColor colorFromHex:0x212121];
        _addressLable.textAlignment = NSTextAlignmentLeft;
        _addressLable.font = CUSNEwFONT(16);
        _addressLable.numberOfLines = 0;
        [_bgView addSubview:_addressLable];
        
        _rightArrow = [UIImageView newAutoLayoutView];
        _rightArrow.contentMode = UIViewContentModeRight;
        _rightArrow.image = [UIImage imageNamed:@"right_arrow"];
        [_bgView addSubview:_rightArrow];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithAddressModel:(AddressModel *)item{
    _nameLable.text = item.name;
    if (item.phone.length == 11) {
        NSString *numberString = [item.phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        _phoneLable.text = numberString;
    }
    NSString *address = [NSString stringWithFormat:@"%@%@%@%@",item.province,item.city,item.area,item.addr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:CUSNEwFONT(16),
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:address attributes:attributes];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,address.length)];
    _addressLable.attributedText = attributedString;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(16.0)];
        
        [_tipLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(26.0)];
        [_tipLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        
        [_deslable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_tipLable withOffset:FitWith(10.0)];
        [_deslable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_tipLable];
        
        [_nameLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_nameLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(80.0)];
        [_nameLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_tipLable withOffset:FitHeight(20.0)];
        
        [_phoneLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(80.0)];
        [_phoneLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_nameLable];
        
        [_addressLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_nameLable];
        [_addressLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(80.0)];
        [_addressLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_phoneLable withOffset:FitHeight(15.0)];
        
        [_rightArrow autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_rightArrow autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_rightArrow autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_rightArrow autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
