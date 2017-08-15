//
//  ScreenProductController.m
//  DuoSet
//
//  Created by mac on 2017/1/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//  分类列表

#import "ScreenProductController.h"
#import "SingleProductNewController.h"
#import "CommonSievingSectionView.h"
#import "SynthesizeView.h"
#import "ScreenView.h"
#import "ProductListData.h"
#import "ListSearchView.h"
#import "SearchData.h"
#import "ViewControllerRecommendToYouCollectionViewCell.h"

typedef enum : NSUInteger {
    ChoiceSortTypeByDefault,
    ChoiceSortTypeBySales,
    ChoiceSortTypeByPrice,
    ChoiceSortTypeByHuman,
} ChoiceSortType;

typedef enum : NSUInteger {
    SortTypeByDefaultWithSynthesize,//综合排序
    SortTypeByDefaultWithNewProduct,//新品优先
    SortTypeByDefaultWithCommountTop//评论最多
} SortDefaultStatus;

typedef enum : NSUInteger {
    SortByAsc,//升序
    SortByDesc,//降序
} SortByStauts;

@interface ScreenProductController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic,assign) ChoiceSortType choiceType;
@property(nonatomic,assign) SortDefaultStatus defaultType;
@property(nonatomic,assign) SortByStauts sortType;

@property(nonatomic,strong) UIView *navView;
@property(nonatomic,strong) UILabel *hotWordLable;
@property(nonatomic,strong) ScreenView *screenView;
@property(nonatomic,strong) SynthesizeView *synthesizeView;
@property(nonatomic,strong) UIView *markView;
@property(nonatomic,strong) CommonSievingSectionView *sectionView;
@property(nonatomic,strong) ListSearchView *searchView;
@property(nonatomic,strong) UIView *srcrollToTopView;
@property(nonatomic,strong) CommonDefeatedView *defeatedView;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,assign) BOOL sortViewShow;

//Data
@property(nonatomic,assign) ScreenProductStyle type;
@property(nonatomic,copy) NSString *level;
@property(nonatomic,copy) NSString *itemId;
@property(nonatomic,strong) NSMutableArray *items;
@property(nonatomic,copy) NSString *keyWords;

@property(nonatomic,assign) BOOL firstRequest;
@property(nonatomic,copy) NSString *urlStr;
@property(nonatomic,assign) NSInteger page;//页数
@property(nonatomic,assign) NSInteger limit;//数据长度 ，默认10

@property(nonatomic,assign) NSInteger lastRequsetCount;
@property(nonatomic,strong) ProductListData *seletcedItem;

@end

@implementation ScreenProductController

#pragma mark - viewWillAppear & viewWillDisappear & viewDidLoad

-(instancetype)initWithScreenProductStyle:(ScreenProductStyle)type andclassifyLevel:(NSString *)level  andItemId:(NSString *)itemId{
    self = [super init];
    if (self) {
        _type = type;
        _level = level;
        _itemId = itemId;
    }
    return self;
}

-(instancetype)initWithScreenProductStyle:(ScreenProductStyle)type andItemId:(NSString *)itemId{
    self = [super init];
    if (self) {
        _type = type;
        _itemId = itemId;
    }
    return self;
}

-(instancetype)initWithScreenProductStyle:(ScreenProductStyle)type andKeyWords:(NSString *)keyWords{
    self = [super init];
    if (self) {
        _type = type;
        _keyWords = keyWords;
    }
    return self;
}

-(void)dealloc{
    NSLog(@"dealloc");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _firstRequest = true;
    _page = 0;
    _limit = 10;
    _lastRequsetCount = 0;
    [self configUI];
    [self configNavView];
    [self getHotWordData];
    [self configDataClearArr:true showHud:true];
}

-(void)getHotWordData{
    if (_keyWords.length > 0) {
        _hotWordLable.text = _keyWords;
        return;
    }
    __weak typeof(self) weakSelf = self;
    [RequestManager requestWithMethod:GET WithUrlPath:@"product/keyword" params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] &&[[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]] ) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"hot"] && [[objDic objectForKey:@"hot"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *hotDic = [objDic objectForKey:@"hot"];
                    if ([hotDic objectForKey:@"word"]) {
                        weakSelf.hotWordLable.text = [NSString stringWithFormat:@"%@",[hotDic objectForKey:@"word"]];
                    }
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

#pragma mark - configNavView & configUI & viewDidLoad
-(void)configNavView{
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 64)];
    _navView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
    [self.view addSubview:_navView];
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    [leftBtn setImage:[UIImage imageNamed:@"new_nav_arrow_black"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(progressLeftSignInButton) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.contentMode = UIViewContentModeCenter;
    [_navView addSubview:leftBtn];
    
    UIButton *centerSearchButton = [[UIButton alloc]initWithFrame:CGRectMake(44, 22, mainScreenWidth - 44 - 15, 38)];
    [centerSearchButton setBackgroundImage:[UIImage imageNamed:@"common_search_bg"] forState:UIControlStateNormal];
    [centerSearchButton setBackgroundImage:[UIImage imageNamed:@"common_search_bg"] forState:UIControlStateHighlighted];
    [centerSearchButton addTarget:self action:@selector(progressClassificationCenterSearchButton) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:centerSearchButton];
    
    _hotWordLable = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(90), 0, FitWith(300.0), 38)];
    _hotWordLable.textColor = [UIColor colorFromHex:0xb3b3b3];
    _hotWordLable.font = CUSFONT(13);
    _hotWordLable.textAlignment = NSTextAlignmentLeft;
    [centerSearchButton addSubview:_hotWordLable];
    
    UIImageView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(FitWith(24.0), 12, 15, 15)];
    leftView.image = [UIImage imageNamed:@"home_nav_search"];
    leftView.contentMode = UIViewContentModeScaleAspectFill;
    [centerSearchButton addSubview:leftView];
    
    [self.view bringSubviewToFront:_navView];
    
    _markView = [[UIView alloc]initWithFrame:CGRectMake(0, FitHeight(100) + 64, mainScreenWidth, mainScreenHeight - 64 - FitHeight(100.0))];
    _markView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    _markView.userInteractionEnabled = true;
    UITapGestureRecognizer*singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap)];
    singleRecognizer.numberOfTapsRequired = 1;
    [_markView addGestureRecognizer:singleRecognizer];
    [self.view addSubview:_markView];
    _markView.hidden = true;
}

- (void)configUI{
    self.view.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _sectionView = [[CommonSievingSectionView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, FitHeight(100.0))];
    __weak typeof(self) weakSelf = self;
    _sectionView.seletcedHandle = ^(NSInteger index,UIButton *btn){
        if (index == 0) {
            [weakSelf showSortView:!weakSelf.sortViewShow];
            return ;
        }
        if (index == 1) {
            [weakSelf showSortView:false];
            weakSelf.choiceType = ChoiceSortTypeBySales;
            weakSelf.sortType = SortByDesc;
            weakSelf.page = 0;
            weakSelf.lastRequsetCount = 0;
            [weakSelf configDataClearArr:true showHud:true];
        }
        if (index == 2) {
            [weakSelf showSortView:false];
            weakSelf.choiceType = ChoiceSortTypeByPrice;
            weakSelf.sortType = btn.selected ? SortByDesc : SortByAsc;
            weakSelf.page = 0;
            weakSelf.lastRequsetCount = 0;
            [weakSelf configDataClearArr:true showHud:true];
        }
        if (index == 3) {
            [weakSelf showSortView:false];
            weakSelf.choiceType = ChoiceSortTypeByHuman;
            weakSelf.sortType = SortByDesc;
            weakSelf.page = 0;
            weakSelf.lastRequsetCount = 0;
            [weakSelf configDataClearArr:true showHud:true];
        }
    };
    [self.view addSubview:_sectionView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _sectionView.frame.origin.y + _sectionView.frame.size.height, mainScreenWidth, mainScreenHeight - 64 - _sectionView.frame.size.height) collectionViewLayout:flowLayout];
    flowLayout.minimumLineSpacing = 3;
    flowLayout.minimumInteritemSpacing = 3;
    flowLayout.itemSize = CGSizeMake((mainScreenWidth-3)/2, FitHeight(600.0));
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _collectionView.showsVerticalScrollIndicator = false;
    [_collectionView registerClass:[ViewControllerRecommendToYouCollectionViewCell class] forCellWithReuseIdentifier:@"ViewControllerRecommendToYouCollectionViewCellIdentifier"];
    [self.view addSubview:_collectionView];
    
    _collectionView.mj_header= [FFGifHeader headerWithRefreshingBlock:^{
        weakSelf.page = 0;
        [weakSelf configDataClearArr:true showHud:false];
    }];
    _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (weakSelf.lastRequsetCount < weakSelf.limit) {
            [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        weakSelf.page += 1;
        [weakSelf configDataClearArr:false showHud:false];
    }];
    
    _srcrollToTopView = [[UIView alloc]initWithFrame:CGRectMake(mainScreenWidth - FitWith(100.0) - FitWith(40.0), mainScreenHeight - 50 - FitWith(120.0), FitWith(100.0), FitWith(100.0))];
    [self.view addSubview:_srcrollToTopView];
    _srcrollToTopView.layer.borderColor = [UIColor colorFromHex:0xe5e5e5].CGColor;
    _srcrollToTopView.layer.borderWidth = 1;
    _srcrollToTopView.layer.cornerRadius = FitWith(100.0) * 0.5;
    _srcrollToTopView.layer.masksToBounds = true;
    _srcrollToTopView.userInteractionEnabled = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollToTopAction)];
    [_srcrollToTopView addGestureRecognizer:tap];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc]initWithEffect:blur];
    blurView.frame = CGRectMake(0, 0, FitWith(100.0), FitWith(100.0));
    [_srcrollToTopView addSubview:blurView];
    
    UIImageView *totopImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, FitWith(100.0), FitWith(100.0))];
    totopImgV.image = [UIImage imageNamed:@"home_scroll_top"];
    totopImgV.contentMode = UIViewContentModeCenter;
    [_srcrollToTopView addSubview:totopImgV];
    _srcrollToTopView.hidden = true;
}

#pragma mark - confiData
-(void)configDataClearArr:(BOOL)clear showHud:(BOOL)showHud{
    if (_firstRequest) {//第一次请求
        _firstRequest = false;
        if (_keyWords.length > 0) {
            NSString *str = [NSString stringWithFormat:@"product?keywords=%@&page=%ld&limit=%ld",self.keyWords,self.page,self.limit];
            _urlStr = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        }else{
            _urlStr = [NSString stringWithFormat:@"product?classifyId=%@&page=%ld&limit=%ld",_itemId,_page,_limit];
            if (_level != nil && _level.length > 0) {
                _urlStr = [NSString stringWithFormat:@"product?classifyId=%@&classifyLevel=%@&page=%ld&limit=%ld",_itemId,_level,_page,_limit];
            }
        }
    }else{//下拉刷新的时候
        if (_keyWords.length > 0) {
            if (_choiceType == ChoiceSortTypeByDefault) {
                if (_defaultType == SortTypeByDefaultWithSynthesize) {
                    NSString *str = [NSString stringWithFormat:@"product?keywords=%@&page=%ld&limit=%ld",self.keyWords,self.page,self.limit];
                    _urlStr = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                }
                if (_defaultType == SortTypeByDefaultWithNewProduct) {
                    NSString *str = [NSString stringWithFormat:@"product?keywords=%@&page=%ld&limit=%ld&sortType=default&sortBy=1",self.keyWords,self.page,self.limit];
                    _urlStr = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                }
            }
            if (_choiceType == ChoiceSortTypeBySales) {
                NSString *str = [NSString stringWithFormat:@"product?keywords=%@&page=%ld&limit=%ld&sortType=sales&sortBy=1",self.keyWords,self.page,self.limit];
                _urlStr = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            }
            if (_choiceType == ChoiceSortTypeByPrice) {
                if (_sortType == SortByAsc) {//默认升序
                    NSString *str = [NSString stringWithFormat:@"product?keywords=%@&page=%ld&limit=%ld&sortType=price&sortBy=0",self.keyWords,self.page,self.limit];
                    _urlStr = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                }else{//降序
                    NSString *str = [NSString stringWithFormat:@"product?keywords=%@&page=%ld&limit=%ld&sortType=price&sortBy=1",self.keyWords,self.page,self.limit];
                    _urlStr = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                }
            }
            if (_choiceType == ChoiceSortTypeByHuman) {
                NSString *str = [NSString stringWithFormat:@"product?keywords=%@&page=%ld&limit=%ld&sortType=human&sortBy=1",self.keyWords,self.page,self.limit];
                _urlStr = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            }
        }else{
            if (_choiceType == ChoiceSortTypeByDefault) {
                if (_defaultType == SortTypeByDefaultWithSynthesize) {
                    _urlStr = [NSString stringWithFormat:@"product?classifyId=%@&page=%ld&limit=%ld",_itemId,_page,_limit];
                    if (_level != nil && _level.length > 0) {
                        _urlStr = [NSString stringWithFormat:@"product?classifyId=%@&classifyLevel=%@&page=%ld&limit=%ld",_itemId,_level,_page,_limit];
                    }
                }
                if (_defaultType == SortTypeByDefaultWithNewProduct) {
                    _urlStr = [NSString stringWithFormat:@"product?classifyId=%@&page=%ld&limit=%ld&sortType=default&sortBy=1",_itemId,_page,_limit];
                    if (_level != nil && _level.length > 0) {
                        _urlStr = [NSString stringWithFormat:@"product?classifyId=%@&classifyLevel=%@&page=%ld&limit=%ld&sortType=default&sortBy=1",_itemId,_level,_page,_limit];
                    }
                }
            }
            if (_choiceType == ChoiceSortTypeBySales) {
                _urlStr = [NSString stringWithFormat:@"product?classifyId=%@&page=%ld&limit=%ld&sortType=sales&sortBy=1",_itemId,_page,_limit];
                if (_level != nil && _level.length > 0) {
                    _urlStr = [NSString stringWithFormat:@"product?classifyId=%@&classifyLevel=%@&page=%ld&limit=%ld&sortType=sales&sortBy=1",_itemId,_level,_page,_limit];
                }
            }
            if (_choiceType == ChoiceSortTypeByPrice) {
                if (_sortType == SortByAsc) {//默认升序
                    _urlStr = [NSString stringWithFormat:@"product?classifyId=%@&page=%ld&limit=%ld&sortType=price&sortBy=0",_itemId,_page,_limit];
                    if (_level != nil && _level.length > 0) {
                        _urlStr = [NSString stringWithFormat:@"product?classifyId=%@&classifyLevel=%@&page=%ld&limit=%ld&sortType=price&sortBy=0",_itemId,_level,_page,_limit];
                    }
                }else{//降序
                    _urlStr = [NSString stringWithFormat:@"product?classifyId=%@&page=%ld&limit=%ld&sortType=price&sortBy=1",_itemId,_page,_limit];
                    if (_level != nil && _level.length > 0) {
                        _urlStr = [NSString stringWithFormat:@"product?classifyId=%@&classifyLevel=%@&page=%ld&limit=%ld&sortType=price&sortBy=1",_itemId,_level,_page,_limit];
                    }
                }
            }
            if (_choiceType == ChoiceSortTypeByHuman) {
                _urlStr = [NSString stringWithFormat:@"product?classifyId=%@&page=%ld&limit=%ld&sortType=human&sortBy=1",_itemId,_page,_limit];
                if (_level != nil && _level.length > 0) {
                    _urlStr = [NSString stringWithFormat:@"product?classifyId=%@&classifyLevel=%@&page=%ld&limit=%ld&sortType=human&sortBy=1",_itemId,_level,_page,_limit];
                }
            }
        }
    }
    __weak typeof(self) weakSelf = self;
    [RequestManager requestWithMethod:GET WithUrlPath:_urlStr params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        [RequestManager showHud:true showString:nil enableUserActions:false withViewController:weakSelf];
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if (clear) {
                weakSelf.items = [NSMutableArray array];
            }
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSArray class]]) {
                NSArray *objectArr = [responseDic objectForKey:@"object"];
                weakSelf.lastRequsetCount = objectArr.count;
                for (NSDictionary *d in objectArr) {
                    ProductListData *item = [ProductListData dataForDictionary:d];
                    [weakSelf.items addObject:item];
                }
                
                [weakSelf.collectionView reloadData];
                [RequestManager showHud:false showString:nil enableUserActions:false withViewController:weakSelf];
                
            }
            if (![responseDic objectForKey:@"object"]) {
                weakSelf.lastRequsetCount = 0;
            }
            [weakSelf.collectionView.mj_footer endRefreshing];
            [weakSelf.collectionView.mj_header endRefreshing];
            [self showDefeatedView:_items.count == 0];
        }
    } fail:^(NSError *error) {
        [weakSelf.collectionView.mj_footer endRefreshing];
        [weakSelf.collectionView.mj_header endRefreshing];
    }];
}


#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ViewControllerRecommendToYouCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ViewControllerRecommendToYouCollectionViewCellIdentifier" forIndexPath:indexPath];
    ProductListData *item = _items[indexPath.row];
    [cell setupInfoWithProductListData:item];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductListData *item = _items[indexPath.row];
    SingleProductNewController *productVC = [[SingleProductNewController alloc]initWithProductId:item.productNumber andCover:item.cover productTitle:item.productName productPrice:item.price];;
    productVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:productVC animated:true];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _srcrollToTopView.hidden = scrollView.contentOffset.y < mainScreenHeight;
}

#pragma mark - 按钮点击
-(void)progressLeftSignInButton{
    [self.navigationController popToRootViewControllerAnimated:true];
    [_sectionView removeFromSuperview];
}

-(void)progressRightButton{
//    [RequestManager showAlertFrom:self title:@"'" mesaage:@"研发中" success:^{
//       //
//    }];
//    MessageCenterViewController *messageCenterVC = [[MessageCenterViewController alloc] init];
//    messageCenterVC.hidesBottomBarWhenPushed = YES;
//    [self pushController:messageCenterVC titleName:@"消息中心"];
}

#pragma mark - 显示筛选 & 显示排序
-(void)SingleTap{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.sortViewShow = false;
        weakSelf.markView.hidden = true;
        weakSelf.synthesizeView.hidden = true;
//        CGRect frame = _synthesizeView.frame;
//        frame.origin.y = - FitHeight(200.0);
//        _synthesizeView.frame = frame;
    } completion:^(BOOL finished) {
        weakSelf.markView.hidden = true;
    }];
}

-(void)showScreenView{
    __weak typeof(self) weakSelf = self;
    if (_screenView != nil) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = weakSelf.screenView.frame;
            frame.origin.x = 0;
            weakSelf.screenView.frame = frame;
        } completion:^(BOOL finished) {
            weakSelf.screenView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        }];
    }else{
        _screenView = [[ScreenView alloc]initWithFrame:CGRectMake(mainScreenWidth, 0, mainScreenWidth, mainScreenHeight)];
        [self.view addSubview:_screenView];
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = weakSelf.screenView.frame;
            frame.origin.x = 0;
            weakSelf.screenView.frame = frame;
        } completion:^(BOOL finished) {
            weakSelf.screenView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        }];
    }
}

-(void)showSortView:(BOOL)show{
    __weak typeof(self) weakSelf = self;
    if (show) {
        if (_synthesizeView != nil) {
            [UIView animateWithDuration:0.25 animations:^{
                CGRect frame = weakSelf.synthesizeView.frame;
                frame.origin.y = FitHeight(100.0) + 64;
                weakSelf.synthesizeView.frame = frame;
            } completion:^(BOOL finished) {
                weakSelf.markView.hidden = false;
                weakSelf.synthesizeView.hidden = false;
            }];
        }else{
            _synthesizeView = [[SynthesizeView alloc]initWithFrame:CGRectMake(0, FitHeight(200.0), mainScreenWidth, FitHeight(200.0))];
            __weak typeof(self) weakSelf = self;
            _synthesizeView.seletedHandle = ^(NSInteger index){
                if (index == 0) {
                    weakSelf.choiceType = ChoiceSortTypeByDefault;
                    weakSelf.defaultType = SortTypeByDefaultWithSynthesize;
                    weakSelf.page = 0;
                    weakSelf.lastRequsetCount = 0;
                    [weakSelf configDataClearArr:true showHud:true];
                    [weakSelf SingleTap];
                }else{
                    weakSelf.choiceType = ChoiceSortTypeByDefault;
                    weakSelf.defaultType = SortTypeByDefaultWithNewProduct;
                    weakSelf.page = 0;
                    weakSelf.lastRequsetCount = 0;
                    [weakSelf configDataClearArr:true showHud:true];
                    [weakSelf SingleTap];
                }
            };
            [self.view addSubview:_synthesizeView];
            [UIView animateWithDuration:0.25 animations:^{
                CGRect frame = weakSelf.synthesizeView.frame;
                frame.origin.y = FitHeight(100.0) + 64;
                weakSelf.synthesizeView.frame = frame;
            } completion:^(BOOL finished) {
                weakSelf.markView.hidden = false;
                weakSelf.synthesizeView.hidden = false;
            }];
        }
        self.sortViewShow = true;
    }else{
        self.sortViewShow = false;
        _markView.hidden = true;
        _synthesizeView.hidden = true;
    }
}

-(void)progressClassificationCenterSearchButton{
    __weak typeof(self) weakSelf = self;
    if (_searchView == nil) {
        _searchView = [[ListSearchView alloc]initWithFrame:CGRectMake(0,0, mainScreenWidth, mainScreenHeight)];
        _searchView.closeHanld = ^(){
            weakSelf.searchView.hidden = true;
        };
        _searchView.choiceHanld = ^(SearchData *item){
            weakSelf.searchView.hidden = true;
            if (item.obj_id.integerValue > 0) {
                weakSelf.level = 0;
                weakSelf.keyWords = @"";
                weakSelf.firstRequest = true;
                weakSelf.page = 0;
                weakSelf.lastRequsetCount = 0;
                weakSelf.itemId = item.obj_id;
                weakSelf.hotWordLable.text = item.name;
                [weakSelf configDataClearArr:true showHud:true];
            }else{
                weakSelf.keyWords = item.name;
                weakSelf.hotWordLable.text = item.name;
                weakSelf.page = 0;
                weakSelf.lastRequsetCount = 0;
                [weakSelf configDataClearArr:true showHud:true];
            }
        };
        _searchView.noResultHanld = ^(NSString *keyWord){
            weakSelf.hotWordLable.text = keyWord;
            weakSelf.firstRequest = true;
            weakSelf.searchView.hidden = true;
            weakSelf.keyWords = keyWord;
            weakSelf.page = 0;
            weakSelf.lastRequsetCount = 0;
            [weakSelf configDataClearArr:true showHud:true];
        };
        [self.view addSubview:_searchView];
        [self.view bringSubviewToFront:_searchView];
        _searchView.hidden = false;
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            weakSelf.searchView.hidden = false;
            [self.view bringSubviewToFront:weakSelf.searchView];
        }];
    }
}

-(void)scrollToTopAction{
    [_collectionView setContentOffset:CGPointMake(0, 0) animated:true];
}

-(void)showDefeatedView:(BOOL)show{
    if (show) {
        if (_defeatedView == nil) {
            __weak typeof(self) weakSelf = self;
            _defeatedView = [[CommonDefeatedView alloc]initWithFrame:CGRectMake(0, FitHeight(100) + 64, mainScreenWidth, mainScreenHeight - 64 - FitHeight(100.0)) andDefeatedImageName:@"defeated_no_find_product" messageName:@"找不到相关商品哦~" backBlockBtnName:nil backBlock:^{
                [weakSelf.navigationController popViewControllerAnimated:true];
            }];
            [self.view addSubview:_defeatedView];
            [self.view bringSubviewToFront:_defeatedView];
        }else{
            _defeatedView.hidden = false;
        }
    }else{
        _defeatedView.hidden = true;
    }
}

-(void)didReceiveMemoryWarning{
    NSLog(@"didReceiveMemoryWarning - ScreenProductController ");
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
}

@end
