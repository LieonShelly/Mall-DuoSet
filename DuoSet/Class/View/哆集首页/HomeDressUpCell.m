//
//  HomeDressUpCell.m
//  DuoSet
//
//  Created by mac on 2017/1/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "HomeDressUpCell.h"

@interface HomeDressUpCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *imgVArr;

@end

@implementation HomeDressUpCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.userInteractionEnabled = true;
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(440.0))];
        _scrollView.contentSize = CGSizeMake(FitWith(220.0) * 10 + FitWith(20.0), 0);
        _scrollView.scrollEnabled = true;
        [self.contentView addSubview:_scrollView];
        
        _imgVArr = [NSMutableArray array];
        
        for (int i = 0; i < 10; i++) {
            UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(FitWith(20) + (FitWith(200.0) + FitWith(20.0)) * i, FitHeight(20.0), FitWith(200.0), FitHeight(400.0))];
            imgv.image = [UIImage imageNamed:@"替代10"];
            imgv.userInteractionEnabled = true;
            imgv.tag = i;
            UITapGestureRecognizer*singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
            singleRecognizer.numberOfTapsRequired = 1;
            [imgv addGestureRecognizer:singleRecognizer];
            [_scrollView addSubview:imgv];
            [_imgVArr addObject:imgv];
        }
    }
    return self;
}

-(void)SingleTap:(UITapGestureRecognizer *)tap{
    DressUpSingleItemBlock block = _dressupHandle;
    if (block) {
        block(tap.view.tag);
    }
}

@end
