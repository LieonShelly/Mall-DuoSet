//
//  ViewControllerRecommendToYouCollectionViewCell.m
//  DuoSet
//
//  Created by Seven-Augus on 2016/11/23.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "ViewControllerRecommendToYouCollectionViewCell.h"

@interface ViewControllerRecommendToYouCollectionViewCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;

@end

@implementation ViewControllerRecommendToYouCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化视图
        [self initView];
    }
    return self;
}
/**初始化视图*/
- (void)initView {
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _productsRecommendImageView = [UIImageView newAutoLayoutView];
    _productsRecommendImageView.contentMode = UIViewContentModeScaleAspectFill;
    _productsRecommendImageView.layer.masksToBounds = true;
    [self.contentView addSubview:_productsRecommendImageView];
    
    _productsRecommendDetailLabel = [UILabel newAutoLayoutView];
    _productsRecommendDetailLabel.font = [UIFont systemFontOfSize:13];
    _productsRecommendDetailLabel.textColor = [UIColor colorWithHexString:@"222222"];
    _productsRecommendDetailLabel.numberOfLines = 1;
    _productsRecommendDetailLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_productsRecommendDetailLabel];
    
    _productsRecommendPriceLabel = [UILabel newAutoLayoutView];
    _productsRecommendPriceLabel.font = [UIFont systemFontOfSize:15];
    _productsRecommendPriceLabel.textColor = [UIColor mainColor];
    _productsRecommendPriceLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.productsRecommendPriceLabel];
    
    _productsRecommendPerSonNumLabel = [UILabel newAutoLayoutView];
    _productsRecommendPerSonNumLabel.font = [UIFont systemFontOfSize:12];
    _productsRecommendPerSonNumLabel.textColor = [UIColor colorFromHex:0x808080];
    _productsRecommendPerSonNumLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_productsRecommendPerSonNumLabel];
    
    [self.contentView setNeedsUpdateConstraints];
}


-(void)setupInfoWithProductListData:(ProductListData *)item{
    __weak typeof(self) weakSelf = self;
    SDWebImageOptions options = SDWebImageRetryFailed | SDWebImageLowPriority;
    [self.productsRecommendImageView sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImageSize(380, 500) options:options completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        CGImageRef imageRef = image.CGImage;
//        CGRect rectEnable = CGRectMake((image.size.width - 380) * 0.5, 0 ,380,500);
//        CGImageRef imageRefRectEnable = CGImageCreateWithImageInRect(imageRef, rectEnable);
//        UIImage *newImageEnable = [[UIImage alloc] initWithCGImage:imageRefRectEnable];
//        weakSelf.productsRecommendImageView.image = newImageEnable;
    }];
    if (item.productName != nil) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 3;
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        NSDictionary *attributes = @{
                                     NSFontAttributeName:CUSFONT(12),
                                     NSParagraphStyleAttributeName:paragraphStyle
                                     };
        
        NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:item.productName attributes:attributes];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,item.productName.length)];
        self.productsRecommendDetailLabel.attributedText = attributedString;
    }
    self.productsRecommendPerSonNumLabel.text = [NSString stringWithFormat:@"%@人查看",item.seeCount];
    if (item.price != nil) {
        NSString *text = [NSString stringWithFormat:@"￥%@",item.price];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
        if (text.length > 2) {
            [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(text.length - 2, 2)];
            [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(text.length - 2, 2)];
        }
        self.productsRecommendPriceLabel.attributedText = attributeString;
    }
}

-(void)setUPInfoWithRecommendListData:(RecommendListData *)item{
    [self.productsRecommendImageView sd_setImageWithURL:[NSURL URLWithString:item.picture] placeholderImage:placeholderImageSize(380, 500) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            CGImageRef imageRef = image.CGImage;
            CGRect rectEnable = CGRectMake((image.size.width - 380) * 0.5, 0 ,380,500);
            CGImageRef imageRefRectEnable = CGImageCreateWithImageInRect(imageRef, rectEnable);
            UIImage *newImageEnable = [[UIImage alloc] initWithCGImage:imageRefRectEnable];
            self.productsRecommendImageView.image = newImageEnable;
        }
    }];
    if (item.productName != nil) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        paragraphStyle.lineSpacing = 3;
        NSDictionary *attributes = @{
                                     NSFontAttributeName:CUSFONT(12),
                                     NSParagraphStyleAttributeName:paragraphStyle
                                     };
        
        NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:item.productName attributes:attributes];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,item.productName.length)];
        self.productsRecommendDetailLabel.attributedText = attributedString;
        
    }
    self.productsRecommendPerSonNumLabel.text = [NSString stringWithFormat:@"%@人查看",item.seeCount];
    if (item.price != nil) {
        NSString *text = [NSString stringWithFormat:@"￥%@",item.price];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
        if (text.length > 2) {
            [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(text.length - 2, 2)];
            [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(text.length - 2, 2)];
        }
        self.productsRecommendPriceLabel.attributedText = attributeString;
        
    }
}

-(void)setUPInfoWithHomeMatchProductData:(HomeMatchProductData *)item{
    [self.productsRecommendImageView sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImageSize(380, 500) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            CGImageRef imageRef = image.CGImage;
            CGRect rectEnable = CGRectMake((image.size.width - 380) * 0.5, 0 ,380,500);
            CGImageRef imageRefRectEnable = CGImageCreateWithImageInRect(imageRef, rectEnable);
            UIImage *newImageEnable = [[UIImage alloc] initWithCGImage:imageRefRectEnable];
            self.productsRecommendImageView.image = newImageEnable;
        }
    }];
    
    if (item.productName) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 3;
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        NSDictionary *attributes = @{
                                     NSFontAttributeName:[UIFont systemFontOfSize:12],
                                     NSParagraphStyleAttributeName:paragraphStyle
                                     };
        
        NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:item.productName attributes:attributes];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,item.productName.length)];
        self.productsRecommendDetailLabel.attributedText = attributedString;
        
    }
    if (item.price != nil) {
        NSString *text = [NSString stringWithFormat:@"￥%@",item.price];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
        if (text.length > 2) {
            [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(text.length - 2, 2)];
            [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(text.length - 2, 2)];
        }
        self.productsRecommendPriceLabel.attributedText = attributeString;
        
    }
    self.productsRecommendPerSonNumLabel.text = [NSString stringWithFormat:@"%@人查看",item.seeCount];
}

-(void)setUPInfoWithProductForListData:(ProductForListData *)item{
    [self.productsRecommendImageView sd_setImageWithURL:[NSURL URLWithString:item.picture] placeholderImage:placeholderImageSize(380, 500) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            CGImageRef imageRef = image.CGImage;
            CGRect rectEnable = CGRectMake((image.size.width - 380) * 0.5, 0 ,380,500);
            CGImageRef imageRefRectEnable = CGImageCreateWithImageInRect(imageRef, rectEnable);
            UIImage *newImageEnable = [[UIImage alloc] initWithCGImage:imageRefRectEnable];
            self.productsRecommendImageView.image = newImageEnable;
        }
    }];
    if (item.productName != nil) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 3;
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        NSDictionary *attributes = @{
                                     NSFontAttributeName:[UIFont systemFontOfSize:12],
                                     NSParagraphStyleAttributeName:paragraphStyle
                                     };
        
        NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:item.productName attributes:attributes];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,item.productName.length)];
        self.productsRecommendDetailLabel.attributedText = attributedString;
        
    }
    if (item.price != nil) {
        NSString *text = [NSString stringWithFormat:@"￥%@",item.price];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
        if (text.length > 2) {
            [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(text.length - 2, 2)];
            [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(text.length - 2, 2)];
        }
        self.productsRecommendPriceLabel.attributedText = attributeString;
    }
    self.productsRecommendPerSonNumLabel.text = [NSString stringWithFormat:@"%@人查看",item.seeCount];
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        [_productsRecommendImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_productsRecommendImageView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_productsRecommendImageView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_productsRecommendImageView autoSetDimension:ALDimensionHeight toSize:FitHeight(496.0)];
        
        [_productsRecommendDetailLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_productsRecommendDetailLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(20.0)];
        [_productsRecommendDetailLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productsRecommendImageView withOffset:5];
        
        [_productsRecommendPriceLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_productsRecommendPriceLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(10.0)];
        
        [_productsRecommendPerSonNumLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_productsRecommendPriceLabel];
        [_productsRecommendPerSonNumLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(20.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
