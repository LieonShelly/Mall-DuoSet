//
//  ProductStandardChoiceView.m
//  DuoSet
//
//  Created by fanfans on 2017/3/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ProductStandardChoiceView.h"
#import "MKJTagViewTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "SKTagButton.h"
#import "StandarTitleCell.h"
#import "StandarCountChoiceCell.h"

@interface ProductStandardChoiceView()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIView *whiteBgView;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) UIImageView *productImgV;
@property(nonatomic,strong) UIButton *closeBtn;
@property(nonatomic,strong) UILabel *productNumLable;
//@property(nonatomic,strong) UILabel *productCountLable;
@property(nonatomic,strong) UITableView *standardTableView;
@property(nonatomic,strong) UIButton *commitBtn;
@property(nonatomic,strong) NSArray *propertyProductEntities;
@property(nonatomic,assign) NSInteger productAmout;
@property(nonatomic,copy)   NSString *maxCountStr;

@property(nonatomic,strong) NSMutableArray *standardIndexArr;

@end

static NSString *identyfy = @"MKJTagViewTableViewCell";

@implementation ProductStandardChoiceView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, frame.size.height)];
        _bgView.backgroundColor = [UIColor clearColor];
        [self addSubview:_bgView];
        
        _whiteBgView = [UIView newAutoLayoutView];
        _whiteBgView.backgroundColor = [UIColor whiteColor];
        [_bgView addSubview:_whiteBgView];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [_bgView addSubview:_line];
        
        _productImgV = [UIImageView newAutoLayoutView];
        _productImgV.contentMode = UIViewContentModeScaleAspectFill;
        _productImgV.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(productImgTapHandle:)];
        [_productImgV addGestureRecognizer:tap];
        _productImgV.layer.cornerRadius = 5;
        _productImgV.layer.masksToBounds = true;
        [_bgView addSubview:_productImgV];
        
        _priceLable = [UILabel newAutoLayoutView];
        _priceLable.textColor = [UIColor mainColor];
        _priceLable.font = CUSFONT(18);
        _priceLable.textAlignment = NSTextAlignmentLeft;
        [_bgView addSubview:_priceLable];
        
        _closeBtn = [UIButton newAutoLayoutView];
        [_closeBtn setImage:[UIImage imageNamed:@"close_coupons"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_whiteBgView addSubview:_closeBtn];
        
        _productNumLable = [UILabel newAutoLayoutView];
        _productNumLable.textColor = [UIColor colorFromHex:0x666666];
        _productNumLable.font = CUSFONT(12);
        _productNumLable.textAlignment = NSTextAlignmentLeft;
        [_bgView addSubview:_productNumLable];
        
        _commitBtn = [UIButton newAutoLayoutView];
        [_commitBtn setBackgroundImage:[UIImage imageWithColor:[UIColor mainColor]] forState:UIControlStateNormal];
        [_commitBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorFromHex:0xe5e5e5]] forState:UIControlStateDisabled];
        _commitBtn.titleLabel.font = CUSFONT(16);
        [_commitBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_commitBtn setTitle:@"暂无库存" forState:UIControlStateDisabled];
        [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitBtn addTarget:self action:@selector(commitBuyInfo) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_commitBtn];
        
        _standardTableView = [UITableView newAutoLayoutView];
        _standardTableView.backgroundColor = [UIColor whiteColor];
        _standardTableView.showsVerticalScrollIndicator = false;
        _standardTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _standardTableView.dataSource = self;
        _standardTableView.delegate = self;
        [_standardTableView registerNib:[UINib nibWithNibName:identyfy bundle:nil] forCellReuseIdentifier:identyfy];
        [_bgView addSubview:_standardTableView];
        _standardTableView.tableFooterView = [UIView new];
        
        [self updateConstraints];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_propertyProductEntities.count == 0) {
        return 0;
    }
    return  _propertyProductEntities == nil ? 1 : _propertyProductEntities.count + 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_propertyProductEntities == nil) {
        return 4;
    }else{
        return  section == _propertyProductEntities.count ? 4 : 2;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_propertyProductEntities == nil) {
        return [[UITableViewCell alloc]initWithFrame:CGRectZero];
    }
    if (indexPath.section != _propertyProductEntities.count) {
        if (indexPath.row == 0) {
            static NSString *StandarTitleCellID = @"StandarTitleCellID";
            StandarTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:StandarTitleCellID];
            if (cell == nil) {
                cell = [[StandarTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StandarTitleCellID];
            }
            ProductPropertyData *item = _propertyProductEntities[indexPath.section];
            cell.tipsLable.text = item.propertyName;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            MKJTagViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identyfy forIndexPath:indexPath];
            [self configCell:cell indexpath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    if (indexPath.section == _propertyProductEntities.count && indexPath.row == 0) {
        static NSString *StandarCountChoiceCellID = @"StandarCountChoiceCellID";
        StandarCountChoiceCell * cell = [tableView dequeueReusableCellWithIdentifier:StandarCountChoiceCellID];
        if (cell == nil) {
            cell = [[StandarCountChoiceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StandarCountChoiceCellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.numBtn.maxValue = _maxCountStr.integerValue;
        __weak typeof(self) weakSelf = self;
        cell.amountChangeHandle = ^(NSInteger amout){
            NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:amout] forKey:@"productAmout"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ProductAmoutChange" object:nil userInfo:dic];
            weakSelf.productAmout = amout;
        };
        return cell;
    }
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

- (void)configCell:(MKJTagViewTableViewCell *)cell indexpath:(NSIndexPath *)indexpath
{
    [cell.tagView removeAllTags];
    cell.tagView.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width;
    cell.tagView.padding = UIEdgeInsetsMake(20, FitWith(20), 20, FitWith(20));
    cell.tagView.lineSpacing = 20;
    cell.tagView.interitemSpacing = 20;
    cell.tagView.singleLine = NO;
    
    ProductPropertyData *item = _propertyProductEntities[indexpath.section];
    
    [item.childValues enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        SKTag *tag = [[SKTag alloc] initWithProductPropertyDetails:item.childValues[idx]];
        tag.font = [UIFont systemFontOfSize:13];
        tag.cornerRadius = 3;
        tag.borderWidth = 0.5;
        tag.enable = true;
        tag.padding = UIEdgeInsetsMake(5, 10, 5, 10);
        [cell.tagView addTag:tag];
    }];
    __weak typeof(self) weakSelf = self;
    cell.tagView.didTapTagAtIndex = ^(NSUInteger index,UIButton *btn,NSArray *tagBtns)
    {
//        for (SKTagButton *button in tagBtns) {
//            if (button == btn) {
//                button.backgroundColor = [UIColor mainColor];
//                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//                button.layer.borderColor = [UIColor mainColor].CGColor;
//            }else{
//                button.backgroundColor = [UIColor whiteColor];
//                [button setTitleColor:[UIColor colorFromHex:0x333333] forState:UIControlStateNormal];
//                button.layer.borderColor = [UIColor colorFromHex:0x666666].CGColor;
//            }
//        }
        SKTagButton *button = (SKTagButton *)btn;
        if (button.isSelected) {
            return ;
        }
        [weakSelf.standardIndexArr replaceObjectAtIndex:indexpath.section withObject:button.itemId];
        StandardIndexAllChoice block = weakSelf.indexChoiceHandle;
        if (block) {
            block(weakSelf.standardIndexArr);
        }
    };
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 2) {
        __weak typeof(self) weakSelf = self;
        return indexPath.row == 0 ? FitHeight(120.0) : [tableView fd_heightForCellWithIdentifier:identyfy configuration:^(id cell) {
            [weakSelf configCell:cell indexpath:indexPath];
        }];
    }
    return FitHeight(100.0);
}

-(void)setupInfoWithProductDetailsData:(ProductDetailsData *)info{
    _productNumLable.text = [NSString stringWithFormat:@"商品编号:%@",info.productNumber];
    _standardIndexArr = [NSMutableArray array];
    _propertyProductEntities = info.propertyProductEntities;
    for (int i = 0; i < info.propertyProductEntities.count; i++) {
        ProductPropertyData *item = info.propertyProductEntities[i];
        for (ProductPropertyDetails *it in item.childValues) {
            if (it.selected) {
                [_standardIndexArr addObject:it.itemId];
            }
        }
    }
    [_standardTableView reloadData];
    NSString *repertoryNum = @"";
    NSString *newPrice = @"";
    if (info.seckillStatus == ProductDetailsSeckilling) {
        repertoryNum = [NSString stringWithFormat:@"%@",info.productNewRobResponse.curDetailResponse.robCount];
        newPrice = info.productNewRobResponse.curDetailResponse.robPrice;
    }else{
        repertoryNum = [NSString stringWithFormat:@"%@",info.repertorySelect.count];
        newPrice = info.price;
    }
    _maxCountStr = repertoryNum.integerValue > 200 ? @"200" : repertoryNum;
    [self setItemRepertoryNum:repertoryNum andNewPrice:newPrice coverPic:info.repertorySelect.picture];
}

-(void)setItemRepertoryNum:(NSString *)repertoryNum andNewPrice:(NSString *)newStr coverPic:(NSString *)cover{
    [_productImgV sd_setImageWithURL:[NSURL URLWithString:cover] placeholderImage:placeholderImage_226_256 options:0];
    StandarCountChoiceCell *cell = [_standardTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_propertyProductEntities.count]];
    cell.numBtn.maxValue = repertoryNum.integerValue > 200 ? 200 : repertoryNum.integerValue;
    if (repertoryNum.integerValue == 0) {
        cell.numBtn.currentNumber = 0;
        _productAmout = 0;
        NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:0] forKey:@"productAmout"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ProductAmoutChange" object:nil userInfo:dic];
    }else{
        cell.numBtn.currentNumber = 1;
        _productAmout = 1;
        NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:1] forKey:@"productAmout"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ProductAmoutChange" object:nil userInfo:dic];
    }
    NSString *text = [NSString stringWithFormat:@"￥ %.2lf",newStr.floatValue];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    if (text.length > 2) {
        [attributeString addAttribute:NSFontAttributeName value:CUSFONT(11) range:NSMakeRange(text.length - 2, 2)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(text.length - 2, 2)];
    }
    _priceLable.attributedText = attributeString;
    _commitBtn.enabled = repertoryNum.integerValue > 0;
}

-(void)commitBuyInfo{
    StandarCountChoiceCell *cell = [_standardTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_propertyProductEntities.count]];
    if (cell.numBtn.currentNumber < 0) {
        [MQToast showToast:@"请先选择数量" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
        return;
    }
    CommitProductBuyInfoBlock block = _commitHandle;
    __weak typeof(self) weakSelf = self;
    if (block) {
        block(weakSelf.standardIndexArr,weakSelf.productAmout);
    }
}

-(void)closeBtnAction{
    CloseBlock block = _closeHandle;
    if (block) {
        block();
    }
}

- (void)productImgTapHandle:(UITapGestureRecognizer *) tap {
    UIImageView * iv = tap.view;
    if (self.productImgTapAction) {
        self.productImgTapAction(iv.image);
    }
}
//Layout
- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_whiteBgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        [_whiteBgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_whiteBgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_whiteBgView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_productImgV autoSetDimension:ALDimensionWidth toSize:FitWith(220.0)];
        [_productImgV autoSetDimension:ALDimensionHeight toSize:FitWith(220.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productImgV withOffset:FitHeight(38.0)];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        [_priceLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_whiteBgView withOffset:FitHeight(90.0)];
        [_priceLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_productImgV withOffset:FitWith(20.0)];
        
        [_closeBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(5)];
        [_closeBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitHeight(5)];
        [_closeBtn autoSetDimension:ALDimensionWidth toSize:FitWith(70.0)];
        [_closeBtn autoSetDimension:ALDimensionHeight toSize:FitWith(70.0)];
        
        [_productNumLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_productImgV];
        [_productNumLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_priceLable];
        
        [_commitBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_commitBtn autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_commitBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_commitBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(90.0)];
        
        [_standardTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productImgV withOffset:FitHeight(40.0)];
        [_standardTableView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:_commitBtn withOffset:0];
        [_standardTableView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_standardTableView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
