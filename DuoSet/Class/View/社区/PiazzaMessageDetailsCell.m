//
//  PiazzaMessageDetailsCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/10.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaMessageDetailsCell.h"

@interface PiazzaMessageDetailsCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UILabel *contentLable;
@property(nonatomic,strong) NSMutableArray *imgArr;
@property(nonatomic,strong) PiazzaData *item;
@property(nonatomic,strong) UIImageView *lastImgV;

@end

@implementation PiazzaMessageDetailsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithPiazzaData:(PiazzaData *)item{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _item = item;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _contentLable = [UILabel newAutoLayoutView];
        _contentLable.numberOfLines = 0;
        _contentLable.textColor = [UIColor colorFromHex:0x222222];
        _contentLable.font = CUSFONT(13);
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 5;
        NSDictionary *attributes = @{
                                     NSFontAttributeName:CUSFONT(13),
                                     NSParagraphStyleAttributeName:paragraphStyle
                                     };
        
        NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:item.content attributes:attributes];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,item.content.length)];
        _contentLable.attributedText = attributedString;
        [self.contentView addSubview:_contentLable];
        
        _imgArr = [NSMutableArray array];
        for (int i = 0; i < item.pics.count; i++) {
            UIImageView *imgV = [UIImageView newAutoLayoutView];
            imgV.contentMode = UIViewContentModeScaleAspectFill;
            imgV.layer.masksToBounds = true;
            [imgV sd_setImageWithURL:[NSURL URLWithString:item.pics[i]] placeholderImage:placeholderImage_702_420 options:0];
            [self.contentView addSubview:imgV];
            [_imgArr addObject:imgV];
            imgV.userInteractionEnabled = true;
            imgV.tag = i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgVTapHandle:)];
            [imgV addGestureRecognizer:tap];
        }
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)imgVTapHandle:(UITapGestureRecognizer *)tap{
    ImgViewTapActionBlock block = _imgHandle;
    if (block) {
        block(tap.view.tag);
    }
}


-(void)setupInfoWithPiazzaData:(PiazzaData *)item{
    //初始化就传进来了
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_contentLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(28.0)];
        [_contentLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(28.0)];
        [_contentLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(28.0)];
        
        for (int i = 0; i < _item.pics.count; i++) {
            UIImageView *imgV = _imgArr[i];
            NSNumber *num = _item.picHights[i];
            CGFloat imgH = num.floatValue;
            
            if (i == 0) {
                [imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
                [imgV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
                [imgV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentLable withOffset:FitHeight(20.0)];
                [imgV autoSetDimension:ALDimensionHeight toSize:imgH];
                _lastImgV = imgV;
            }else{
                [imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
                [imgV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
                [imgV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_lastImgV withOffset:FitHeight(10)];
                [imgV autoSetDimension:ALDimensionHeight toSize:imgH];
                _lastImgV = imgV;
            }
        }
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
