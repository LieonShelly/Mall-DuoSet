//
//  SeckillListController.m
//  DuoSet
//
//  Created by mac on 2017/1/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SeckillListController.h"
#import "SeckillHeaderView.h"
#import "SeckillFirstTableView.h"
#import "SeckillSecondTableView.h"
#import "SeckillThirdTableView.h"
#import "SeckillFourthTableView.h"
#import "SeckillTifthTableView.h"

@interface SeckillListController ()<UIScrollViewDelegate>

@property(nonatomic,strong) SeckillHeaderView *headerView;
@property(nonatomic,strong) UIScrollView *bgScrollView;
@property(nonatomic,strong) SeckillFirstTableView *firstTable;
@property(nonatomic,strong) SeckillSecondTableView *secondTable;
@property(nonatomic,strong) SeckillThirdTableView *thirdTable;
@property(nonatomic,strong) SeckillFourthTableView *fourthTable;
@property(nonatomic,strong) SeckillTifthTableView *tifthTable;

@end

@implementation SeckillListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"哆集秒杀";
    [self configUI];
}

-(void)configUI{
    _headerView = [[SeckillHeaderView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, FitHeight(116.0))];
    __weak typeof(self) weakSelf = self;
    _headerView.btnActionHandle = ^(NSInteger index){
        [weakSelf.bgScrollView setContentOffset:CGPointMake(index *mainScreenWidth, 0) animated:true];
    };
    [self.view addSubview:_headerView];
    
    _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _headerView.frame.origin.y + _headerView.frame.size.height, mainScreenWidth, mainScreenHeight - 64 - FitHeight(120.0))];
    [_bgScrollView setContentSize:CGSizeMake(mainScreenWidth * 5, 0)];
    _bgScrollView.pagingEnabled = YES;
    _bgScrollView.delegate = self;
    _bgScrollView.showsHorizontalScrollIndicator = false;
    [self.view addSubview:_bgScrollView];
    
    _firstTable = [SeckillFirstTableView contentTableView];
    [_bgScrollView addSubview:_firstTable];
    
    _secondTable = [SeckillSecondTableView contentTableView];
    [_bgScrollView addSubview:_secondTable];
    
    _thirdTable = [SeckillThirdTableView contentTableView];
    [_bgScrollView addSubview:_thirdTable];
    
    _fourthTable = [SeckillFourthTableView contentTableView];
    [_bgScrollView addSubview:_fourthTable];
    
    _tifthTable = [SeckillTifthTableView contentTableView];
    [_bgScrollView addSubview:_tifthTable];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/ mainScreenWidth;
    [_headerView setBtnChangeWithIndex:index];
}

@end
