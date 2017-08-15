//
//  SubjectDetailCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SubjectDetailCell.h"

@interface SubjectDetailCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIImageView *imgV;
@property (nonatomic,strong) UILabel *contentLable;

@end

@implementation SubjectDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imgV = [UIImageView newAutoLayoutView];
        _imgV.layer.masksToBounds = true;
        [self.contentView addSubview:_imgV];
        
        _contentLable = [UILabel newAutoLayoutView];
        _contentLable.textColor = [UIColor colorFromHex:0x222222];
        _contentLable.font = CUSFONT(14);
        _contentLable.numberOfLines = 0;
        [self.contentView addSubview:_contentLable];
        
        [self.contentView setNeedsUpdateConstraints];
        
    }
    return self;
}

-(void)setupInfoWithSubjectData:(SubjectData *)item{
    [_imgV sd_setImageWithURL:[NSURL URLWithString:item.picture] placeholderImage:placeholderImageSize(750, 350) options:0];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:CUSFONT(14),
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:item.descr attributes:attributes];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,item.descr.length)];
    _contentLable.attributedText = attributedString;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_imgV autoSetDimension:ALDimensionHeight toSize:FitHeight(350.0)];
        
        [_contentLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_contentLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_contentLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_imgV withOffset:FitHeight(30.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}


@end
