//
//  QualificationRegistFootView.m
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "QualificationRegistFootView.h"

@interface QualificationRegistFootView()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UILabel *downLoadLable;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) UILabel *desLable;
@property(nonatomic,strong) UIButton *commitBtn;

@end

@implementation QualificationRegistFootView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _downLoadLable = [UILabel newAutoLayoutView];
        _downLoadLable.textAlignment = NSTextAlignmentLeft;
        _downLoadLable.text = @"委托书模板下载";
        _downLoadLable.font = CUSFONT(14);
        _downLoadLable.textColor = [UIColor mainColor];
        _downLoadLable.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(downLoadPhoto)];
        [_downLoadLable addGestureRecognizer:tap];
        [self addSubview:_downLoadLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor mainColor];
        [self addSubview:_line];
        
        _desLable = [UILabel newAutoLayoutView];
        _desLable.textColor = [UIColor colorFromHex:0x808080];
        _desLable.font = CUSFONT(12);
        _desLable.numberOfLines = 0;
        _desLable.text = @"使用方法：上传文件需盖公章，增值授权委托书可下载并填写下载模板拍照上传。\n本页面上传图片仅供审核使用，切勿进行支付相关业务。";
        [self addSubview:_desLable];
        
        _commitBtn = [UIButton newAutoLayoutView];
        [_commitBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_normal"] forState:UIControlStateNormal];
        [_commitBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_highlighted"] forState:UIControlStateHighlighted];
        _commitBtn.titleLabel.font = CUSFONT(16);
        [_commitBtn setTitle:@"提 交" forState:UIControlStateNormal];
        [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_commitBtn];
        
        [self updateConstraints];
    }
    return self;
}

-(void)setupInfoWithQualificationData:(QualificationData *)item{
    if (item.status == CheckInfoNotBegin) {
        _commitBtn.userInteractionEnabled = false;
        [_commitBtn setTitle:@"审核中" forState:UIControlStateNormal];
        [_commitBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_highlighted"] forState:UIControlStateNormal];
    }
    if (item.status == CheckInfoFailure) {
        [_commitBtn setTitle:@"重新申请" forState:UIControlStateNormal];
    }
    if (item.status == CheckInfoSuccess) {
        _commitBtn.hidden = true;
    }
}


-(void)downLoadPhoto{
    DownImageBlock block = _downHandle;
    if (block) {
        block();
    }
}

-(void)sureBtnAction{
    CommitBtnAcitonBlock block = _commitHandle;
    if (block) {
        block();
    }
}

//-(void)setupInfoWithProductForListData:(ProductForListData *)item{
//    [_productImgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:[UIImage imageNamed:@""] options:0];
//    _productName.text = item.productName;
//    NSString *text = [NSString stringWithFormat:@"￥%@",item.price];
//    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
//    [attributeString addAttribute:NSFontAttributeName value:CUSFONT(13) range:NSMakeRange(text.length - 2,2)];
//    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(text.length - 2, 2)];
//    _priceLable.attributedText = attributeString;
//}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_downLoadLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_downLoadLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(24.0)];
        
        [_line autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_downLoadLable];
        [_line autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_downLoadLable];
        [_line autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_downLoadLable withOffset:1];
        [_line autoSetDimension:ALDimensionHeight toSize:1];
        
        [_desLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_desLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_desLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_downLoadLable withOffset:FitHeight(10.0)];
        
        [_commitBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_commitBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_commitBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(90.0)];
        [_commitBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(24.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
