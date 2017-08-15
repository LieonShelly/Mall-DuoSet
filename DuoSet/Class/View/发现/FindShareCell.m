//
//  FindShareCell.m
//  DuoSet
//
//  Created by mac on 2017/1/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "FindShareCell.h"
#import "FindShareProductView.h"

@interface FindShareCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *avatar;
@property (nonatomic,strong) UILabel *uesrNameLable;
@property (nonatomic,strong) UILabel *contentLable;
@property (nonatomic,strong) UIImageView *shareImgV1;
@property (nonatomic,strong) UIImageView *shareImgV2;
@property (nonatomic,strong) UIImageView *shareImgV3;
@property (nonatomic,strong) UIImageView *shareImgV4;
@property (nonatomic,strong) UIImageView *shareImgV5;
@property (nonatomic,strong) UIImageView *shareImgV6;
@property (nonatomic,strong) UIImageView *shareImgV7;
@property (nonatomic,strong) UIImageView *shareImgV8;
@property (nonatomic,strong) UIImageView *shareImgV9;
@property (nonatomic,strong) NSMutableArray *imgVArr;
@property (nonatomic,strong) FindShareProductView *productView;
@property (nonatomic,strong) UIButton *likeBtn;
@property (nonatomic,strong) UIButton *unLikeBtn;

@end


static NSInteger imgCount = 9;
//static float space_X = FitWith(30.0);


@implementation FindShareCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        
        _avatar = [UIImageView newAutoLayoutView];
        _avatar.image = [UIImage imageNamed:@"用户头像png"];
        _avatar.layer.cornerRadius = FitWith(60.0) * 0.5;
        _avatar.layer.masksToBounds = true;
        [_bgView addSubview:_avatar];
        
        _uesrNameLable = [UILabel newAutoLayoutView];
        _uesrNameLable.textColor = [UIColor mainColor];
        _uesrNameLable.text = @"火锅美少女";
        _uesrNameLable.textAlignment = NSTextAlignmentLeft;
        _uesrNameLable.font = CUSFONT(12);
        [_bgView addSubview:_uesrNameLable];
        
        _contentLable = [UILabel newAutoLayoutView];
        _contentLable.textColor = [UIColor colorFromHex:0x333333];
        _contentLable.text = @"火锅美少女,今年穿的衣服好流行啊。火锅美少女,今年穿的衣服好流行啊。火锅美少女,今年穿的衣服好流行啊。火锅美少女,今年穿的衣服好流行啊。火锅美少女,今年穿的衣服好流行啊。";
        _contentLable.numberOfLines = 0;
        _contentLable.textAlignment = NSTextAlignmentLeft;
        _contentLable.font = CUSFONT(11);
        [_bgView addSubview:_contentLable];
        
        _imgVArr = [NSMutableArray array];
        
        _shareImgV1 = [UIImageView newAutoLayoutView];
        [_bgView addSubview:_shareImgV1];
        [_imgVArr addObject:_shareImgV1];
        
        _shareImgV2 = [UIImageView newAutoLayoutView];
        [_bgView addSubview:_shareImgV2];
        [_imgVArr addObject:_shareImgV2];
        
        _shareImgV3 = [UIImageView newAutoLayoutView];
        [_bgView addSubview:_shareImgV3];
        [_imgVArr addObject:_shareImgV3];
        
        _shareImgV4 = [UIImageView newAutoLayoutView];
        [_bgView addSubview:_shareImgV4];
        [_imgVArr addObject:_shareImgV4];
        
        _shareImgV5 = [UIImageView newAutoLayoutView];
        [_bgView addSubview:_shareImgV5];
        [_imgVArr addObject:_shareImgV5];
        
        _shareImgV6 = [UIImageView newAutoLayoutView];
        [_bgView addSubview:_shareImgV6];
        [_imgVArr addObject:_shareImgV6];
        
        _shareImgV7 = [UIImageView newAutoLayoutView];
        [_bgView addSubview:_shareImgV7];
        [_imgVArr addObject:_shareImgV7];
        
        _shareImgV8 = [UIImageView newAutoLayoutView];
        [_bgView addSubview:_shareImgV8];
        [_imgVArr addObject:_shareImgV8];
        
        _shareImgV9 = [UIImageView newAutoLayoutView];
        [_bgView addSubview:_shareImgV9];
        [_imgVArr addObject:_shareImgV9];
        
        for (int i = 0; i < _imgVArr.count; i++) {
            UIImageView *imgV = _imgVArr[i];
            imgV.contentMode = UIViewContentModeScaleAspectFill;
            imgV.layer.masksToBounds = true;
        }
        _productView = [FindShareProductView  newAutoLayoutView];
        [_bgView addSubview:_productView];
        
        _likeBtn = [UIButton newAutoLayoutView];
        _likeBtn.titleLabel.font = CUSFONT(10.0);
        [_likeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5)];
        [_likeBtn setTitle:@"123" forState:UIControlStateNormal];
        [_likeBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"赞png"] forState:UIControlStateNormal];
        [_bgView addSubview:_likeBtn];
        
        _unLikeBtn = [UIButton newAutoLayoutView];
        _unLikeBtn.titleLabel.font = CUSFONT(10.0);
        [_unLikeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5)];
        [_unLikeBtn setTitle:@"3" forState:UIControlStateNormal];
        [_unLikeBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        [_unLikeBtn setImage:[UIImage imageNamed:@"踩png"] forState:UIControlStateNormal];
        [_bgView addSubview:_unLikeBtn];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

//-(void)setupInfoWithShopCarModel:(ShopCarModel *)item{
//    _item = item;
//    _numBtn.currentNumber = item.amount.integerValue;
//    _productNameLable.text = item.productName;
//    _productPriceLable.text = item.price;
//    _standardLabel.text = item.standard;
//    [_productImgV sd_setImageWithURL:[NSURL URLWithString:item.smallImg] placeholderImage:[UIImage imageNamed:@"数据加载失败"] options:0];
//    _selectedBtn.selected = item.isSelected;
//}


- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(30.0)];
        
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10.0)];
        [_avatar autoSetDimension:ALDimensionWidth toSize:FitWith(60.0)];
        [_avatar autoSetDimension:ALDimensionHeight toSize:FitWith(60.0)];
        
        [_uesrNameLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_avatar];
        [_uesrNameLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_avatar];
        [_uesrNameLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_uesrNameLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avatar withOffset:FitWith(10.0)];
        
        [_contentLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_avatar withOffset:FitHeight(10.0)];
        [_contentLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_contentLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        
        if (imgCount == 1) {
            for (int i = 0; i < _imgVArr.count; i++) {
                UIImageView *imgV = _imgVArr[i];
                imgV.hidden = i != 0;
                if (i == 0) {
                    [imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
                    [imgV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
                    [imgV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentLable withOffset:FitHeight(10.0)];
                    [imgV autoSetDimension:ALDimensionHeight toSize:mainScreenWidth - FitWith(60.0)];
                    [self setConstraintsWithImgV:imgV];
                }
            }
        }
        
        if (imgCount == 2) {
            for (int i = 0; i < _imgVArr.count; i++) {
                UIImageView *imgV = _imgVArr[i];
                imgV.hidden = (i != 0 || i != 1);
                if (i == 0) {
                    [imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
                    [imgV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentLable withOffset:FitHeight(10.0)];
                    [imgV autoSetDimension:ALDimensionHeight toSize:(mainScreenWidth - FitWith(60.0) - FitWith(30.0)) * 0.5];
                    [imgV autoSetDimension:ALDimensionWidth toSize:(mainScreenWidth - FitWith(60.0) - FitWith(30.0)) * 0.5];
                }
                if (i == 1) {
                    [imgV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
                    [imgV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentLable withOffset:FitHeight(10.0)];
                    [imgV autoSetDimension:ALDimensionHeight toSize:(mainScreenWidth - FitWith(60.0) - FitWith(30.0)) * 0.5];
                    [imgV autoSetDimension:ALDimensionWidth toSize:(mainScreenWidth - FitWith(60.0) - FitWith(30.0)) * 0.5];
                    [self setConstraintsWithImgV:imgV];
                }
            }
        }
        
        if (imgCount == 3) {
            _shareImgV4.hidden = true;
            _shareImgV5.hidden = true;
            _shareImgV6.hidden = true;
            _shareImgV7.hidden = true;
            _shareImgV8.hidden = true;
            _shareImgV9.hidden = true;
            
            [_shareImgV1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
            [_shareImgV1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentLable withOffset:FitHeight(10.0)];
            [_shareImgV1 autoSetDimension:ALDimensionWidth toSize:(mainScreenWidth - FitWith(10.0)) * 0.3];
            [_shareImgV1 autoSetDimension:ALDimensionHeight toSize:(mainScreenWidth - FitWith(10.0)) * 0.3];
            
            [_shareImgV2 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_shareImgV1];
            [_shareImgV2 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_shareImgV1];
            [_shareImgV2 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [_shareImgV2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareImgV1 withOffset:FitWith(10.0)];
            
            [_shareImgV3 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_shareImgV1];
            [_shareImgV3 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_shareImgV1];
            [_shareImgV3 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [_shareImgV3 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareImgV2 withOffset:FitWith(10.0)];
            [self setConstraintsWithImgV:_shareImgV3];
        }
        if (imgCount == 4) {
            _shareImgV5.hidden = true;
            _shareImgV6.hidden = true;
            _shareImgV7.hidden = true;
            _shareImgV8.hidden = true;
            _shareImgV9.hidden = true;
            
            [_shareImgV1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
            [_shareImgV1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentLable withOffset:FitHeight(10.0)];
            [_shareImgV1 autoSetDimension:ALDimensionWidth toSize:(mainScreenWidth - FitWith(10.0)) * 0.3];
            [_shareImgV1 autoSetDimension:ALDimensionHeight toSize:(mainScreenWidth - FitWith(10.0)) * 0.3];
            
            [_shareImgV2 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_shareImgV1];
            [_shareImgV2 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_shareImgV1];
            [_shareImgV2 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [_shareImgV2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareImgV1 withOffset:FitWith(10.0)];
            
            [_shareImgV3 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_shareImgV1];
            [_shareImgV3 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_shareImgV1];
            [_shareImgV3 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [_shareImgV3 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareImgV2 withOffset:FitWith(10.0)];
            
            [_shareImgV4 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_shareImgV1];
            [_shareImgV4 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_shareImgV3 withOffset:FitWith(10.0)];
            [_shareImgV4 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [_shareImgV4 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_shareImgV1];;
            [self setConstraintsWithImgV:_shareImgV4];
        }
        if (imgCount == 5) {
            _shareImgV6.hidden = true;
            _shareImgV7.hidden = true;
            _shareImgV8.hidden = true;
            _shareImgV9.hidden = true;
            
            [_shareImgV1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
            [_shareImgV1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentLable withOffset:FitHeight(10.0)];
            [_shareImgV1 autoSetDimension:ALDimensionWidth toSize:(mainScreenWidth - FitWith(10.0)) * 0.3];
            [_shareImgV1 autoSetDimension:ALDimensionHeight toSize:(mainScreenWidth - FitWith(10.0)) * 0.3];
            
            [_shareImgV2 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_shareImgV1];
            [_shareImgV2 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_shareImgV1];
            [_shareImgV2 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [_shareImgV2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareImgV1 withOffset:FitWith(10.0)];
            
            [_shareImgV3 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_shareImgV1];
            [_shareImgV3 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_shareImgV1];
            [_shareImgV3 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [_shareImgV3 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareImgV2 withOffset:FitWith(10.0)];
            
            [_shareImgV4 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_shareImgV1];
            [_shareImgV4 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_shareImgV3 withOffset:FitWith(10.0)];
            [_shareImgV4 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [_shareImgV4 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_shareImgV1];
            
            [_shareImgV5 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_shareImgV4];
            [_shareImgV5 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_shareImgV4];
            [_shareImgV5 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareImgV1 withOffset:FitWith(10.0)];
            [_shareImgV5 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [self setConstraintsWithImgV:_shareImgV5];
        }
        if (imgCount == 6) {
            _shareImgV7.hidden = true;
            _shareImgV8.hidden = true;
            _shareImgV9.hidden = true;
            
            [_shareImgV1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
            [_shareImgV1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentLable withOffset:FitHeight(10.0)];
            [_shareImgV1 autoSetDimension:ALDimensionWidth toSize:(mainScreenWidth - FitWith(10.0)) * 0.3];
            [_shareImgV1 autoSetDimension:ALDimensionHeight toSize:(mainScreenWidth - FitWith(10.0)) * 0.3];
            
            [_shareImgV2 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_shareImgV1];
            [_shareImgV2 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_shareImgV1];
            [_shareImgV2 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [_shareImgV2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareImgV1 withOffset:FitWith(10.0)];
            
            [_shareImgV3 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_shareImgV1];
            [_shareImgV3 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_shareImgV1];
            [_shareImgV3 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [_shareImgV3 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareImgV2 withOffset:FitWith(10.0)];
            
            [_shareImgV4 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_shareImgV1];
            [_shareImgV4 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_shareImgV3 withOffset:FitWith(10.0)];
            [_shareImgV4 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [_shareImgV4 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_shareImgV1];
            
            [_shareImgV5 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_shareImgV4];
            [_shareImgV5 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_shareImgV4];
            [_shareImgV5 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareImgV1 withOffset:FitWith(10.0)];
            [_shareImgV5 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            
            [_shareImgV6 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_shareImgV4];
            [_shareImgV6 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_shareImgV4];
            [_shareImgV6 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareImgV5 withOffset:FitWith(10.0)];
            [_shareImgV6 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [self setConstraintsWithImgV:_shareImgV6];
        }
        if (imgCount == 7) {
            _shareImgV8.hidden = true;
            _shareImgV9.hidden = true;
            
            [_shareImgV1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
            [_shareImgV1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentLable withOffset:FitHeight(10.0)];
            [_shareImgV1 autoSetDimension:ALDimensionWidth toSize:(mainScreenWidth - FitWith(10.0)) * 0.3];
            [_shareImgV1 autoSetDimension:ALDimensionHeight toSize:(mainScreenWidth - FitWith(10.0)) * 0.3];
            
            [_shareImgV2 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_shareImgV1];
            [_shareImgV2 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_shareImgV1];
            [_shareImgV2 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [_shareImgV2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareImgV1 withOffset:FitWith(10.0)];
            
            [_shareImgV3 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_shareImgV1];
            [_shareImgV3 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_shareImgV1];
            [_shareImgV3 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [_shareImgV3 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareImgV2 withOffset:FitWith(10.0)];
            
            [_shareImgV4 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_shareImgV1];
            [_shareImgV4 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_shareImgV3 withOffset:FitWith(10.0)];
            [_shareImgV4 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [_shareImgV4 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_shareImgV1];
            
            [_shareImgV5 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_shareImgV4];
            [_shareImgV5 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_shareImgV4];
            [_shareImgV5 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareImgV1 withOffset:FitWith(10.0)];
            [_shareImgV5 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            
            [_shareImgV6 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_shareImgV4];
            [_shareImgV6 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_shareImgV4];
            [_shareImgV6 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareImgV5 withOffset:FitWith(10.0)];
            [_shareImgV6 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            
            [_shareImgV7 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_shareImgV4 withOffset:FitWith(10.0)];
            [_shareImgV7 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_shareImgV1];
            [_shareImgV7 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [_shareImgV7 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_shareImgV1];
            [self setConstraintsWithImgV:_shareImgV7];
        }
        if (imgCount == 8) {
            _shareImgV9.hidden = true;
            
            [_shareImgV1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
            [_shareImgV1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentLable withOffset:FitHeight(10.0)];
            [_shareImgV1 autoSetDimension:ALDimensionWidth toSize:(mainScreenWidth - FitWith(10.0)) * 0.3];
            [_shareImgV1 autoSetDimension:ALDimensionHeight toSize:(mainScreenWidth - FitWith(10.0)) * 0.3];
            
            [_shareImgV2 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_shareImgV1];
            [_shareImgV2 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_shareImgV1];
            [_shareImgV2 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [_shareImgV2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareImgV1 withOffset:FitWith(10.0)];
            
            [_shareImgV3 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_shareImgV1];
            [_shareImgV3 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_shareImgV1];
            [_shareImgV3 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [_shareImgV3 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareImgV2 withOffset:FitWith(10.0)];
            
            [_shareImgV4 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_shareImgV1];
            [_shareImgV4 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_shareImgV3 withOffset:FitWith(10.0)];
            [_shareImgV4 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [_shareImgV4 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_shareImgV1];
            
            [_shareImgV5 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_shareImgV4];
            [_shareImgV5 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_shareImgV4];
            [_shareImgV5 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareImgV1 withOffset:FitWith(10.0)];
            [_shareImgV5 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            
            [_shareImgV6 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_shareImgV4];
            [_shareImgV6 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_shareImgV4];
            [_shareImgV6 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareImgV5 withOffset:FitWith(10.0)];
            [_shareImgV6 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            
            [_shareImgV7 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_shareImgV4 withOffset:FitWith(10.0)];
            [_shareImgV7 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_shareImgV1];
            [_shareImgV7 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [_shareImgV7 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_shareImgV1];
            
            [_shareImgV8 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_shareImgV7];
            [_shareImgV8 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_shareImgV7];
            [_shareImgV8 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareImgV7 withOffset:FitWith(10.0)];
            [_shareImgV8 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [self setConstraintsWithImgV:_shareImgV8];
        }
        if (imgCount == 9) {
            
            [_shareImgV1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
            [_shareImgV1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentLable withOffset:FitHeight(10.0)];
            [_shareImgV1 autoSetDimension:ALDimensionWidth toSize:(mainScreenWidth - FitWith(10.0)) * 0.3];
            [_shareImgV1 autoSetDimension:ALDimensionHeight toSize:(mainScreenWidth - FitWith(10.0)) * 0.3];
            
            [_shareImgV2 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_shareImgV1];
            [_shareImgV2 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_shareImgV1];
            [_shareImgV2 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [_shareImgV2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareImgV1 withOffset:FitWith(10.0)];
            
            [_shareImgV3 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_shareImgV1];
            [_shareImgV3 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_shareImgV1];
            [_shareImgV3 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [_shareImgV3 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareImgV2 withOffset:FitWith(10.0)];
            
            [_shareImgV4 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_shareImgV1];
            [_shareImgV4 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_shareImgV3 withOffset:FitWith(10.0)];
            [_shareImgV4 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [_shareImgV4 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_shareImgV1];
            
            [_shareImgV5 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_shareImgV4];
            [_shareImgV5 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_shareImgV4];
            [_shareImgV5 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareImgV1 withOffset:FitWith(10.0)];
            [_shareImgV5 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            
            [_shareImgV6 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_shareImgV4];
            [_shareImgV6 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_shareImgV4];
            [_shareImgV6 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareImgV5 withOffset:FitWith(10.0)];
            [_shareImgV6 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            
            [_shareImgV7 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_shareImgV4 withOffset:FitWith(10.0)];
            [_shareImgV7 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_shareImgV1];
            [_shareImgV7 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [_shareImgV7 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_shareImgV1];
            
            [_shareImgV8 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_shareImgV7];
            [_shareImgV8 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_shareImgV7];
            [_shareImgV8 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareImgV7 withOffset:FitWith(10.0)];
            [_shareImgV8 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            
            [_shareImgV9 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_shareImgV7];
            [_shareImgV9 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_shareImgV7];
            [_shareImgV9 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareImgV8 withOffset:FitWith(10.0)];
            [_shareImgV9 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_shareImgV1];
            [self setConstraintsWithImgV:_shareImgV9];
        }
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

-(void)setConstraintsWithImgV:(UIImageView *)imgV{
    [_productView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
    [_productView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
    [_productView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:imgV withOffset:FitWith(30.0)];
    [_productView autoSetDimension:ALDimensionHeight toSize:FitHeight(160.0)];
    
    [_likeBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productView ];
    [_likeBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(450.0)];
    [_likeBtn autoSetDimension:ALDimensionWidth toSize:FitWith(120.0)];
    [_likeBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(50.0)];
    
    [_unLikeBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_likeBtn];
    [_unLikeBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_likeBtn withOffset:FitWith(20.0)];
    [_unLikeBtn autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_likeBtn];
    [_unLikeBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_likeBtn];
}

@end
