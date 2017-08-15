//
//  OrderDetailLogisticCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/7.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OrderDetailLogisticCell.h"

@interface OrderDetailLogisticCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UILabel *nameLable;
@property (nonatomic,strong) UILabel *phoneLable;
@property (nonatomic,strong) UILabel *addressLable;
@property (nonatomic,strong) UIView *line;

@end

@implementation OrderDetailLogisticCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _nameLable = [UILabel newAutoLayoutView];
        _nameLable.textColor = [UIColor colorFromHex:0x212121];
        _nameLable.textAlignment = NSTextAlignmentLeft;
        _nameLable.font = CUSNEwFONT(16);
        [self.contentView addSubview:_nameLable];
        
        _phoneLable = [UILabel newAutoLayoutView];
        _phoneLable.textColor = [UIColor colorFromHex:0x212121];
        _phoneLable.textAlignment = NSTextAlignmentLeft;
        _phoneLable.font = CUSNEwFONT(16);
        [self.contentView addSubview:_phoneLable];
        
        _addressLable = [UILabel newAutoLayoutView];
        _addressLable.textColor = [UIColor colorFromHex:0x212121];
        _addressLable.textAlignment = NSTextAlignmentLeft;
        _addressLable.font = CUSNEwFONT(16);
        _addressLable.numberOfLines = 0;
        [self.contentView addSubview:_addressLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithDuojiOrderData:(DuojiOrderData *)item{
    _nameLable.text = item.contact;
    if (item.phone.length >= 11) {
        NSString *numberString = [item.phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        _phoneLable.text = numberString;
    }
    NSString *address = item.address;
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
        
        [_nameLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_nameLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
        
        [_phoneLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_phoneLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_nameLable];
        
        [_addressLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_nameLable];
        [_addressLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_addressLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_phoneLable withOffset:FitHeight(15.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
