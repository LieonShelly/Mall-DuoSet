//
//  ShoppingCartCell.m
//  DuoSet
//
//  Created by mac on 2017/1/5.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ShoppingCartCell.h"
#import "ItemCountModifyView.h"

@interface ShoppingCartCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *productImgV;
@property (nonatomic,strong) UIImageView *globalImgV;
@property (nonatomic,strong) UIView *markFullView;
@property (nonatomic,strong) UILabel *statusLable;
@property (nonatomic,strong) UILabel *wordLable;
@property (nonatomic,strong) UILabel *matchLable;
@property (nonatomic,strong) UILabel *productNameLable;
@property (nonatomic,strong) UILabel *standardLabel;
@property (nonatomic,strong) UILabel *productPriceLable;
@property (nonatomic,strong) UILabel *productAmountLable;
@property (nonatomic,strong) ShopCarModel *item;
@property (nonatomic,strong) UIView *line;

@end

@implementation ShoppingCartCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor colorFromHex:0xffffff];
        [self.contentView addSubview:_bgView];
        
        _selectedBtn = [UIButton newAutoLayoutView];
        [_selectedBtn setImage:[UIImage imageNamed:@"choose_default"] forState:UIControlStateNormal];
        [_selectedBtn setImage:[UIImage imageNamed:@"choose_selected"] forState:UIControlStateSelected];
        [_selectedBtn addTarget:self action:@selector(selectedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_selectedBtn];
        
        _productImgV = [UIImageView newAutoLayoutView];
        _productImgV.layer.cornerRadius = 3;
        _productImgV.layer.masksToBounds = true;
        _productImgV.contentMode = UIViewContentModeScaleAspectFill;
        [_bgView addSubview:_productImgV];//shopcart_sellEnd_Img@3x
        
        _globalImgV = [UIImageView newAutoLayoutView];
        _globalImgV.hidden = true;
        _globalImgV.image = [UIImage imageNamed:@"global_product_tag"];
        [_productImgV addSubview:_globalImgV];
        
        _markFullView = [UIView newAutoLayoutView];
        _markFullView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _markFullView.layer.cornerRadius = 55 * 0.5;
        _markFullView.layer.masksToBounds = true;
        _markFullView.hidden = true;
        [_productImgV addSubview:_markFullView];
        
        _statusLable = [UILabel newAutoLayoutView];
        _statusLable.textColor = [UIColor whiteColor];
        _statusLable.font = [UIFont systemFontOfSize:12];
        _statusLable.textAlignment = NSTextAlignmentCenter;
        [_markFullView addSubview:_statusLable];
        
        _productNameLable = [UILabel newAutoLayoutView];
        _productNameLable.textColor = [UIColor colorFromHex:0x222222];
        _productNameLable.numberOfLines = 2;
        _productNameLable.font = [UIFont systemFontOfSize:13];
        [_bgView addSubview:_productNameLable];
        
        _standardLabel = [UILabel newAutoLayoutView];
        _standardLabel.textColor = [UIColor colorFromHex:0x808080];
        _standardLabel.font = [UIFont systemFontOfSize:12];
        [_bgView addSubview:_standardLabel];
        
        _standardShowImgV = [UIImageView newAutoLayoutView];
        _standardShowImgV.image = [UIImage imageNamed:@"shopcart_choice_image"];
        [_bgView addSubview:_standardShowImgV];
        
        _matchLable = [UILabel newAutoLayoutView];
        _matchLable.font = [UIFont systemFontOfSize:11];
        _matchLable.textColor = [UIColor mainColor];
        _matchLable.layer.borderWidth = 0.5;
        _matchLable.layer.borderColor = [UIColor mainColor].CGColor;
        [_bgView addSubview:_matchLable];
        
        _standardModifyBtn = [UIButton newAutoLayoutView];
        _standardModifyBtn.backgroundColor = [UIColor clearColor];
        [_standardModifyBtn addTarget:self action:@selector(standarBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_standardModifyBtn];
        
        _productPriceLable = [UILabel newAutoLayoutView];
        _productPriceLable.textColor = [UIColor mainColor];
        _productPriceLable.font = CUSNEwFONT(18);
        _productPriceLable.textAlignment = NSTextAlignmentRight;
        [_bgView addSubview:_productPriceLable];
        
        _itemModifyView = [[ItemCountModifyView alloc]initWithFrame:CGRectMake(mainScreenWidth - 100 - 15, 100, 100, 35) andMinusHandle:^(NSInteger minus) {
            ChangeProductAountMinBlock block = _minHandle;
            if (block) {
                block(minus);
            }
        } andPlusHandle:^(NSInteger plus) {
            ChangeProductAountMaxBlock block = _plusHandle;
            if (block) {
                block(plus);
            }
        } resultHandle:^(NSInteger result) {
            //
        }];
        [_bgView addSubview:_itemModifyView];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithShopCarModel:(ShopCarModel *)item andIsEdit:(BOOL)isEdit{
    _item = item;
    _globalImgV.hidden = !item.isGlobal;
    
    NSInteger tmpMax = item.repertoryCount.integerValue > 200 ? 200 : item.repertoryCount.integerValue;
    [_itemModifyView setupInfoWithCurrentCount:item.count andMaxCount:[NSString stringWithFormat:@"%ld",tmpMax]];
    _productNameLable.text = item.productName;
    
    NSString *text = [NSString stringWithFormat:@"￥%@",item.price];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeString addAttribute:NSFontAttributeName value:CUSNEwFONT(15) range:NSMakeRange(0,1)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(0, 1)];
    _productPriceLable.attributedText = attributeString;
    
    _standardLabel.text = item.propertyName;
    [_productImgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImageSize(95, 110) options:0];
    if (isEdit) {
        _selectedBtn.selected = item.isSelected;
    }else{
        _selectedBtn.selected = item.cartSelect;
    }
    if (item.productStatus == ShopCarProductSellStatusSellEnd) {//已下架
        _markFullView.hidden = false;
        _statusLable.text = @"已下架";
        _selectedBtn.hidden = isEdit ? false : true;
        _itemModifyView.hidden = true;
        _productNameLable.textColor = [UIColor colorFromHex:0xcccccc];
        _standardLabel.textColor = [UIColor colorFromHex:0xcccccc];
        _standardModifyBtn.hidden = true;
        _standardShowImgV.hidden = true;
        _matchLable.hidden = true;
    }else{//正常情况下
        _markFullView.hidden = true;
        if (isEdit) {
            _selectedBtn.hidden = false;
            _standardModifyBtn.hidden = false;
            _standardShowImgV.hidden = false;
        }else{
            _selectedBtn.hidden = !item.canSelect;
            _standardModifyBtn.hidden = true;
            _standardShowImgV.hidden = true;
        }
        _itemModifyView.hidden = !item.canSelect;
        _productNameLable.textColor = [UIColor colorFromHex:0x222222];
        _standardLabel.textColor = [UIColor colorFromHex:0x808080];
        if (item.repertoryCount.integerValue == 0) {
            _standardLabel.textColor = [UIColor colorFromHex:0xcccccc];
            _markFullView.hidden = false;
            _statusLable.text = @"已售罄";
        }else if (item.repertoryCount.integerValue <= 5){
            _markFullView.hidden = false;
            _statusLable.text = [NSString stringWithFormat:@"仅剩%@件",item.repertoryCount];
        }else{
            _markFullView.hidden = true;
        }
        if (item.words.length > 0) {
            _matchLable.hidden = false;
            _matchLable.text = item.words;
        }else{
            _matchLable.hidden = true;
        }
    }
}

-(void)standarBtnAction:(UIButton *)btn{
    SingleProductChoiceOtherStandardBlock block = _productChoiceOtherStandardHandle;
    if (block) {
        block();
    }
}

-(void)selectedBtnAction:(UIButton *)btn{
    SingleProductSeletedBlock block = _productSelectedHandle;
    if (block) {
        block();
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgesToSuperviewEdges];
        
        [_selectedBtn autoSetDimension:ALDimensionWidth toSize:FitWith(84.0)];
        [_selectedBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_selectedBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_selectedBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_selectedBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:18];
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:35];
        [_productImgV autoSetDimension:ALDimensionWidth toSize:95];
        [_productImgV autoSetDimension:ALDimensionHeight toSize:110];
        
        [_globalImgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_globalImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_globalImgV autoSetDimension:ALDimensionWidth toSize:30];
        [_globalImgV autoSetDimension:ALDimensionHeight toSize:30];
        
        [_markFullView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_markFullView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_markFullView autoSetDimension:ALDimensionWidth toSize:55];
        [_markFullView autoSetDimension:ALDimensionHeight toSize:55];
        
        [_statusLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_statusLable autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [_productNameLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_productImgV withOffset:15];
        [_productNameLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_productImgV];
        [_productNameLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
        
        [_standardLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productNameLable withOffset:10];
        [_standardLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productNameLable];
        [_standardLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
        
        [_standardShowImgV autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_standardLabel];
        [_standardShowImgV autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_standardLabel];
        
        [_matchLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_standardLabel];
        [_matchLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_standardLabel withOffset:3];
        
        [_standardModifyBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
        [_standardModifyBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_standardLabel];
        [_standardModifyBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_standardLabel];
        [_standardModifyBtn autoSetDimension:ALDimensionHeight toSize:30];
        
        [_productPriceLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_standardLabel];
        [_productPriceLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_productImgV];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
