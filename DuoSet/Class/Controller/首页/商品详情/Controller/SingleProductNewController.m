//
//  SingleProductNewController.m
//  DuoSet
//
//  Created by fanfans on 2017/4/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SingleProductNewController.h"
#import "ProductNavTitleView.h"
#import "ProductDetailFootView.h"
#import "SingleProductMainView.h"
#import "SingleProductWebView.h"
#import "SingleProductCommentListView.h"
#import "AddressModel.h"
#import "CouponInfoData.h"
#import "CommentData.h"
#import "LoginViewController.h"
#import "CustomNavController.h"
#import "CommentHomeData.h"
#import "ProductStandardChoiceView.h"
#import "ShopCarSureData.h"
#import "OrderSureViewController.h"
#import "ShoppingCartViewController.h"
#import "MQChatViewManager.h"
#import "GetCouponsTableView.h"
#import "ShippingAddressView.h"
#import "AftermarketView.h"
#import "CitiesDataTool.h"
#import "ShareView.h"
#import "ProductTexDesView.h"
#import "MIPhotoBrowser.h"
#import "PBViewController.h"

typedef enum : NSUInteger {
    SingleItemBuyAddCart,
    SingleItemBuyToPay
}SingleItemBuyStyle;

typedef enum : NSUInteger {
    StandarsViewShowWithLook,
    StandarsViewShowWithAddCart
} StandarsViewShowStautus;

typedef enum : NSUInteger {
    MarkViewShowPromotion,//促销
    MarkViewShowCoupons,//优惠券
    MarkViewShowAddress,//地址
    MarkViewShowStandars,//规格
    MarkViewShowAftermarket,//售后支持
    MarkViewShowShare,//分享
    MarkViewShowTexDes//税率描述
} MarkViewShowStyle;


@interface SingleProductNewController ()<UIScrollViewDelegate, MIPhotoBrowserDelegate,PBViewControllerDataSource, PBViewControllerDelegate>

@property(nonatomic,copy) NSString *productNum;
//nav
@property(nonatomic,strong) UIView *navView;
@property(nonatomic,strong) UIButton *leftBtn;
@property(nonatomic,strong) UIButton *rightBtn;
@property(nonatomic,strong) ProductNavTitleView *titleView;
//View
@property(nonatomic,strong) UIScrollView *bgScrollView;
@property(nonatomic,strong) SingleProductMainView *mainView;
@property(nonatomic,strong) SingleProductWebView *productWebView;
@property(nonatomic,strong) SingleProductCommentListView *productCommentView;
@property(nonatomic,strong) ProductDetailFootView *footView;
@property(nonatomic,assign) MarkViewShowStyle markShowStatus;
@property(nonatomic,strong) GetCouponsTableView *getCouponsView;
@property(nonatomic,strong) ShippingAddressView *shipAddressView;
@property(nonatomic,strong) AftermarketView *aftermarkView;
@property(nonatomic,strong) ShareView *shareView;
@property(nonatomic,strong) ProductTexDesView *texDesView;

@property(nonatomic,strong) UIView *markView;
@property(nonatomic,strong) ProductStandardChoiceView *standarsView;
@property(nonatomic,assign) StandarsViewShowStautus standarsViewShowType;
@property(nonatomic,assign) BOOL standarsViewIsShow;
//Data
@property(nonatomic,copy)   NSString *cover;
@property(nonatomic,copy)   NSString *productTitle;
@property(nonatomic,copy)   NSString *productPrice;
@property(nonatomic,strong) ProductDetailsData *productItem;
@property(nonatomic,strong) NSMutableArray *couponCodeResponses;
@property(nonatomic,assign) ProductDetailStyle status;
@property(nonatomic,assign) NSInteger userCanSeckillCount;
@property(nonatomic,strong) NSMutableArray *commentArr;
@property(nonatomic,strong) NSMutableArray *commentListArr;
@property(nonatomic,copy)   NSString *properties;
@property(nonatomic,copy)   NSString *propertiesName;
@property(nonatomic,copy)   NSString *count;
@property(nonatomic,assign) SingleItemBuyStyle buyStatus;
@property(nonatomic,strong) NSMutableArray *addressDataArray;
@property(nonatomic,copy)   NSString *firstRequstPropertyCollection;
@property(nonatomic,copy)   NSString *requsetUrlStr;
//评论
@property(nonatomic,assign) NSInteger filter;
@property(nonatomic,assign) NSInteger page;
@property(nonatomic,assign) NSInteger lastRequsetCount;
@property(nonatomic,strong) CommentHomeData *commentHomeData;
@property(nonatomic,strong) UIImage *bigImage;

@property(nonatomic,strong) NSMutableArray *imgArr;
@property(nonatomic,assign) NSInteger imgindex;

@property(nonatomic,assign) BOOL thumb;

@end

@implementation SingleProductNewController

#pragma mark - init / viewWillAppear / viewWillDisappear / viewDidLoad
-(instancetype)initWithProductId:(NSString *)productNum{
    self = [super init];
    if (self) {
        _productNum = productNum;
    }
    return self;
}

-(instancetype)initWithProductId:(NSString *)productNum andPropertyCollection:(NSString *)propertyCollection{
    self = [super init];
    if (self) {
        _productNum = productNum;
        _firstRequstPropertyCollection = propertyCollection;
    }
    return self;
}

-(instancetype)initWithProductId:(NSString *)productNum andCover:(NSString *)cover productTitle:(NSString *)productTitle productPrice:(NSString *)productPrice andPropertyCollection:(NSString *)propertyCollection{
    self = [super init];
    if (self) {
        _productNum = productNum;
        _cover = cover;
        _productTitle = productTitle;
        _productPrice = productPrice;
        _firstRequstPropertyCollection = propertyCollection;
    }
    return self;
}

-(instancetype)initWithProductId:(NSString *)productNum andCover:(NSString *)cover productTitle:(NSString *)productTitle productPrice:(NSString *)productPrice{
    self = [super init];
    if (self) {
        _productNum = productNum;
        _cover = cover;
        _productTitle = productTitle;
        _productPrice = productPrice;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
  
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setCustomNavView];
    [self configUI];
    if (_firstRequstPropertyCollection.length > 0) {
        _requsetUrlStr = [NSString stringWithFormat:@"product/%@?propertyCollection=%@",_productNum,_firstRequstPropertyCollection];
    }else{
        _requsetUrlStr = [NSString stringWithFormat:@"product/%@",_productNum];
    }
    [self configDataWithUrlStr:_requsetUrlStr];
    [self configAddressData];
    _count = @"1";
    _filter = 0;
    _page = 0;
    _lastRequsetCount = 0;
    [self configCommentDataList:true];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productDetailsMainControllerShowWeb) name:@"ProductDetailsMainControllerShowWeb" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productDetailsMainControllerShowBaseInfo) name:@"ProductDetailsMainControllerShowBaseInfo" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucessHandle) name:@"LoginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySucceedChangeCountHandle) name:@"PaySucceedHandleChangeCount" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetAddressModleSeletcedStatus) name:@"ResetAddressModleSeletcedStatus" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productAmoutChangeHandle:) name:@"ProductAmoutChange" object:nil];
}

-(void)dealloc{
    if (_mainView) {
        [_mainView removeTimer];
    }
    NSLog(@"dealloc - SingleProductNewController");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - configUI
-(void)configUI{
    _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, mainScreenWidth, mainScreenHeight - 64 - 50)];
    _bgScrollView.pagingEnabled = YES;
    _bgScrollView.delegate = self;
    _bgScrollView.showsHorizontalScrollIndicator = false;
    _bgScrollView.bounces = NO;
    _bgScrollView.contentSize = CGSizeMake(mainScreenWidth * 3, 0);
    [self.view addSubview:_bgScrollView];
    
    __weak typeof(self) weakSelf = self;
    _mainView = [[SingleProductMainView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight - 64 - 50) andProductNum:_productNum];
    if (_cover.length > 0) {
        [_mainView setupInfoWithFirstLangchCover:_cover productTitle:_productTitle productPrice:_productPrice];
    }
    weakSelf.mainView.coverTapHandle = ^(NSInteger index) {
        if (weakSelf.productItem == nil) {
            return ;
        }
        [weakSelf scanPictures:weakSelf.productItem.showPics andIndex:index];
    };
    _mainView.cellHandle = ^(NSIndexPath *indexPath) {
        [weakSelf mainViewTableViewCellTapHandleWithNSIndexPath:indexPath];
    };
    _mainView.imgVTapHandle = ^(CommentData *item, NSInteger index) {
        [weakSelf scanPictures:item.pics andIndex:index];
    };
    _mainView.cutdownEndHandle = ^{
        [weakSelf configDataWithUrlStr:weakSelf.requsetUrlStr];
    };
    _mainView.texHandle = ^{
        [weakSelf showTexDesmarkView];
    };
    _mainView.webCallHandle = ^(NSString *str) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",str]]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",str]]];
        }
    };
    [_bgScrollView addSubview:_mainView];
    
    _productWebView = [[SingleProductWebView alloc]initWithFrame:CGRectMake(mainScreenWidth, 0, mainScreenWidth,  mainScreenHeight - 64 - 50) andProductNum:_productNum];
    _productWebView.webCallHandle = ^(NSString *str) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",str]]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",str]]];
        }
    };
    [_bgScrollView addSubview:_productWebView];
    
    self.productCommentView = [[SingleProductCommentListView alloc]initWithFrame:CGRectMake(mainScreenWidth * 2, 0, mainScreenWidth, mainScreenHeight) AndHeaderRefreshBlock:^{
        weakSelf.page = 0;
        [weakSelf configCommentDataList:true];
    } footRefreshBlock:^{
        if (weakSelf.lastRequsetCount < 10) {
            [weakSelf.productCommentView.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        weakSelf.page += 1;
        [weakSelf configCommentDataList:false];
    }];
    weakSelf.productCommentView.headerBtnHandle = ^(NSInteger index) {
        weakSelf.filter = index;
        weakSelf.page = 0;
        [weakSelf configCommentDataList:true];
    };
    
    self.productCommentView.imgVTapHandle = ^(CommentData *item, NSInteger index) {
        [weakSelf scanPictures:item.pics andIndex:index];
    };
    self.productCommentView.likeBtnHandle = ^(NSIndexPath *indexPath,CommentData *item,UIButton *btn) {
        if (![weakSelf checkLogin]) {
            [weakSelf userlogin];
            return ;
        }
        if (btn.selected) {
            [MQToast showToast:@"亲，你已经点过赞了哦！" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
            return;
        }
        NSString *urlStr = [NSString stringWithFormat:@"user/order/%@/comment/like",item.comment_id];
        [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:nil from:weakSelf showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *objectDic = [responseDic objectForKey:@"object"];
                    CommentData *data = [CommentData dataForDictionary:objectDic];
                    item.isLike = data.isLike;
                    item.goodCount = data.goodCount;
                    [weakSelf.productCommentView.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }
        } fail:^(NSError *error) {
            //
        }];
    };
    [_bgScrollView addSubview:weakSelf.productCommentView];
}

-(void)scrollToTopAction{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollToTopActionNotify" object:nil];
}

-(void)configFootView{
    __weak typeof(self) weakSelf = self;
    if (_footView == nil) {
        _footView = [[ProductDetailFootView alloc]initWithFrame:CGRectMake(0, mainScreenHeight - 50, mainScreenWidth, 50) andProductDetailsData:weakSelf.productItem];
        _footView.btnActionHandle = ^(UIButton* btn){
            [weakSelf footViewBtnsActionWithIndex:btn];
        };
        [weakSelf.view addSubview:_footView];
        [weakSelf configShopCartItemCount];
    }else{
        [weakSelf.footView setupInfoWithProductDetailsData:weakSelf.productItem];
    }
}

#pragma mark - configData & configAddressData & configShopCartItemCount & configCommentData
-(void)configDataWithUrlStr:(NSString *)urlStr{
    __weak typeof(self) weakSelf = self;
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"couponCodeResponses"] && [[objDic objectForKey:@"couponCodeResponses"] isKindOfClass:[NSArray class]]) {
                    weakSelf.couponCodeResponses = [NSMutableArray array];
                    NSArray *items = [objDic objectForKey:@"couponCodeResponses"];
                    for (NSDictionary *d in items ) {
                        CouponInfoData *item = [CouponInfoData dataForDictionary:d];
                        [weakSelf.couponCodeResponses addObject:item];
                    }
                }
                if ([objDic objectForKey:@"info"] && [[objDic objectForKey:@"info"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *infoDic = [objDic objectForKey:@"info"];
                    weakSelf.productItem = [ProductDetailsData dataForDictionary:infoDic];
                    weakSelf.rightBtn.hidden = weakSelf.productItem.status == ProductDetailsWithSoldOut;
                    [weakSelf configFootView];
                }
            }
            [weakSelf.mainView setupInfoWithCouponCodeResponses:weakSelf.couponCodeResponses];
            [weakSelf.mainView setupInfoWithProductDetailsData:weakSelf.productItem];
            if (weakSelf.standarsViewIsShow) {
                [weakSelf.standarsView setupInfoWithProductDetailsData:weakSelf.productItem];
            }
            if (weakSelf.autoAddtoShopCart) {
                [weakSelf showStandarsView];
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)configAddressData{
    UserInfo *info = [Utils getUserInfo];
    if (info.token == nil) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [RequestManager requestWithMethod:GET WithUrlPath:@"user/address" params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            weakSelf.addressDataArray = [NSMutableArray array];
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSArray class]]){
                NSArray *objArr = [responseDic objectForKey:@"object"];
                for (NSDictionary *d in objArr) {
                    AddressModel *item = [AddressModel dataForDictionary:d];
                    [weakSelf.addressDataArray addObject:item];
                }
                for (AddressModel *item in weakSelf.addressDataArray) {
                    if (item.isDEFAULT) {
                        [weakSelf.mainView setupInfoWithAddressModel:item];
                    }
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)configShopCartItemCount{
    UserInfo *info = [Utils getUserInfo];
    if (info.token == nil) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [RequestManager requestWithMethod:GET WithUrlPath:@"user/cart/count" params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]){
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"count"]) {//_footView
                    NSString *count = [objDic objectForKey:@"count"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[objDic objectForKey:@"count"]] : @"0";
                    [weakSelf.footView resetShopcartCountlableShowCount:count];
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)configCommentDataList:(BOOL)clear{
    __weak typeof(self) weakSelf = self;
    NSString *urlStr = [NSString stringWithFormat:@"product/%@/comment?limit=10&page=%ld&filter=%ld",_productNum,(long)_page,_filter];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if (clear) {
                weakSelf.commentListArr = [NSMutableArray array];
            }
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if (weakSelf.commentHomeData == nil) {
                    weakSelf.commentHomeData = [CommentHomeData dataForDictionary:objDic];
                    NSArray *countArr = @[weakSelf.commentHomeData.totalCount,weakSelf.commentHomeData.highGrade,weakSelf.commentHomeData.positiveGrade,weakSelf.commentHomeData.badGrade,weakSelf.commentHomeData.hasPic];
                    [weakSelf.productCommentView.headerView setCountLableContentWithCountArr:countArr];
                }
                if ([objDic objectForKey:@"comments"] && [[objDic objectForKey:@"comments"] isKindOfClass:[NSArray class]]) {
                    NSArray *commentsArr = [objDic objectForKey:@"comments"];
                    weakSelf.lastRequsetCount = commentsArr.count;
                    for (NSDictionary *d in commentsArr) {
                        CommentData *item = [CommentData dataForDictionary:d];
                        [weakSelf.commentListArr addObject:item];
                    }
                    [weakSelf.productCommentView.tableView.mj_footer endRefreshing];
                    [weakSelf.productCommentView.tableView.mj_header endRefreshing];
                }
                if (_commentArr == nil) {
                    NSArray *newArr = [NSArray array];
                    if (weakSelf.commentListArr.count > 2) {
                        NSMutableArray *arr = [NSMutableArray arrayWithArray:weakSelf.commentListArr];
                        newArr = [arr subarrayWithRange:NSMakeRange(0,2)];
                        weakSelf.commentArr = [NSMutableArray arrayWithArray:newArr];
                    }else{
                        weakSelf.commentArr = weakSelf.commentListArr;
                    }
                    [weakSelf.mainView setupInfoWithCommentArr:weakSelf.commentArr];
                }
                [weakSelf.productCommentView setupInfoWithCommentArr:weakSelf.commentListArr];
            }
            [weakSelf.productCommentView.tableView.mj_footer endRefreshing];
            [weakSelf.productCommentView.tableView.mj_header endRefreshing];
        }
    } fail:^(NSError *error) {
        [weakSelf.productCommentView.tableView.mj_footer endRefreshing];
        [weakSelf.productCommentView.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - setCustomNavView
-(void)setCustomNavView{
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 64)];
    _navView.backgroundColor = [UIColor colorFromHex:0xfafafa];
    [self.view addSubview:_navView];
    
    _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    [_leftBtn setImage:[UIImage imageNamed:@"new_nav_arrow_black"] forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(leftItemHandle) forControlEvents:UIControlEventTouchUpInside];
    _leftBtn.contentMode = UIViewContentModeCenter;
    [_navView addSubview:_leftBtn];
    
    _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - 44, 20, 44, 44)];
    [_rightBtn setImage:[UIImage imageNamed:@"nav_black_share"] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(rightBarItemAction) forControlEvents:UIControlEventTouchUpInside];
    _rightBtn.contentMode = UIViewContentModeCenter;
    [_navView addSubview:_rightBtn];
    
    _titleView = [[ProductNavTitleView alloc]initWithFrame:CGRectMake(44, 20, mainScreenWidth - 88, 44)];
    __weak typeof(self) weakSelf = self;
    _titleView.navbuttonHandle = ^(NSInteger index) {
        [weakSelf.bgScrollView setContentOffset:CGPointMake(index * mainScreenWidth, 0) animated:true];
    };
    [_navView addSubview:_titleView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, mainScreenWidth, 0.5)];
    line.backgroundColor = [UIColor colorFromHex:0xBABABA];
    [_navView addSubview:line];
}

#pragma nav_btn_action
-(void)leftItemHandle{
    [self.navigationController popViewControllerAnimated:true];
}

-(void)rightBarItemAction{
    [self showShareView];
}

#pragma mark - 底部按钮点
-(void)footViewBtnsActionWithIndex:(UIButton *)btn{
        if (_productItem == nil) {//判断数据是否请求完成
            return;
        }
        if (btn.tag == 0) {
            [self chatWithServer];
        }
        if (![self checkLogin]) {
            [self userlogin];
            return;
        }
    if (btn.tag == 4) {
        [self orderSureWithShopCarSureData:nil andProductNumber:self.productItem.productNumber propertyCollection:self.productItem.repertorySelect.propertyCollection count:_count];
        return;
        }
    if (btn.tag == 3) {
            _standarsViewShowType = StandarsViewShowWithAddCart;
            [self showStandarsView];
            _buyStatus = btn.tag == 3 ?  SingleItemBuyAddCart : SingleItemBuyToPay;
            return;
        }
        if (btn.tag == 1) {
            if (btn.selected) {
                [self cancelcollectProduct];
            }else{
                [self collectProduct];
            }
            return;
        }
        if (btn.tag == 2) {
            ShoppingCartViewController *shopCartVC = [[ShoppingCartViewController alloc]init];
            shopCartVC.isFromPrudoctDetail = true;
            shopCartVC.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:shopCartVC animated:true];
            return;
        }
}

-(void)productDetailsMainControllerShowWeb{
    [_titleView setupViewProductNavTitleViewShowStyle:ProductNavTitleViewShowWebDetails LineFrameChangeWithIndex:0];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.4f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [transition setValue:(id) kCFBooleanFalse forKey:kCATransitionFade];
    [self.titleView.layer addAnimation:transition forKey:nil];
    _bgScrollView.contentSize = CGSizeMake(0, 0);
}

-(void)productDetailsMainControllerShowBaseInfo{
    [_titleView setupViewProductNavTitleViewShowStyle:ProductNavTitleViewShowSubViews LineFrameChangeWithIndex:0];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.4f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    [transition setValue:(id) kCFBooleanFalse forKey:kCATransitionFade];
    [self.titleView.layer addAnimation:transition forKey:nil];
    _bgScrollView.contentSize = CGSizeMake(mainScreenWidth * 3, 0);
}

#pragma mark - ScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/ mainScreenWidth;
    [_titleView setupViewProductNavTitleViewShowStyle:ProductNavTitleViewShowSubViews LineFrameChangeWithIndex:index];
}

#pragma mark - 判断登录
-(BOOL)checkLogin{
    UserInfo *info = [Utils getUserInfo];
    return info.token.length > 0;
}

-(void)userlogin{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    CustomNavController *loginNav = [[CustomNavController alloc] initWithRootViewController:loginVC];
    [self presentViewController:loginNav animated:YES completion:nil];
}

#pragma mark - 登录成功监听处理
-(void)loginSucessHandle{
    [self configAddressData];
    [self configShopCartItemCount];
}

#pragma mark - 立即购买成功刷新库存
-(void)paySucceedChangeCountHandle{
    if (_productItem.status == ProductDetailsWithDefault) {
        [self configShopCartItemCount];
    }
    _requsetUrlStr = [NSString stringWithFormat:@"product/%@",_productNum];
    [self configDataWithUrlStr:_requsetUrlStr];
}

#pragma mark - 图片放大
-(void)scanPictures:(NSArray *)imgArr andIndex:(NSInteger)index{
    _imgArr = imgArr;
    _imgindex = index;
    self.thumb = YES;
    PBViewController *pbViewController = [PBViewController new];
    pbViewController.pb_dataSource = self;
    pbViewController.pb_delegate = self;
    pbViewController.pb_startPage = _imgindex;
    [self presentViewController:pbViewController animated:YES completion:nil];
}

#pragma mark - PBViewControllerDataSource

- (NSInteger)numberOfPagesInViewController:(PBViewController *)viewController {
    return _imgArr.count;
}

- (void)viewController:(PBViewController *)viewController presentImageView:(UIImageView *)imageView forPageAtIndex:(NSInteger)index progressHandler:(void (^)(NSInteger, NSInteger))progressHandler {
    NSString *url = self.imgArr[index];
    UIImage *placeholder = nil;
    [imageView sd_setImageWithURL:[NSURL URLWithString:url]
                 placeholderImage:placeholder
                          options:0
                         progress:progressHandler
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        }];
}

//- (UIView *)thumbViewForPageAtIndex:(NSInteger)index {
//    if (self.thumb) {
//        return self.imageViews[index];
//    }
//    return nil;
//}

#pragma mark - PBViewControllerDelegate

- (void)viewController:(PBViewController *)viewController didSingleTapedPageAtIndex:(NSInteger)index presentedImage:(UIImage *)presentedImage {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewController:(PBViewController *)viewController didLongPressedPageAtIndex:(NSInteger)index presentedImage:(UIImage *)presentedImage {
    NSLog(@"didLongPressedPageAtIndex: %@", @(index));
}


-(void)mainViewTableViewCellTapHandleWithNSIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {//促销
            NSLog(@"促销");
        }
        if (indexPath.row == 2) {//优惠券
            [self showCouponsView];
        }
    }
    if (indexPath.section == 1) {
        if ([[CitiesDataTool sharedManager]cityDataIsOK]) {
            [self showShipAddressView];
            return;
        }
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [RequestManager showHud:true showString:@"地址数据加载中" enableUserActions:true withViewController:weakSelf];
            [[CitiesDataTool sharedManager] requestGetData];
            　dispatch_sync(dispatch_get_main_queue(), ^{
                [RequestManager showHud:false showString:@"地址数据加载中" enableUserActions:true withViewController:weakSelf];
                [weakSelf showShipAddressView];
            });
        });
    }
    if (indexPath.section == 2) {
        _standarsViewShowType = StandarsViewShowWithLook;
        [self showStandarsView];
    }
    if (indexPath.section == 3) {
        [self showAftermarkView];
    }
    if (indexPath.section == 4) {
        if (indexPath.row == 0 && _commentArr.count > 0 ) {
            [self.bgScrollView setContentOffset:CGPointMake(mainScreenWidth * 2, 0) animated:true];
            [_titleView setupViewProductNavTitleViewShowStyle:ProductNavTitleViewShowSubViews LineFrameChangeWithIndex:2];
            return;
        }
        if (_commentArr.count > 0 && indexPath.row == _commentArr.count + 1) {
            [self.bgScrollView setContentOffset:CGPointMake(mainScreenWidth * 2, 0) animated:true];
            [_titleView setupViewProductNavTitleViewShowStyle:ProductNavTitleViewShowSubViews LineFrameChangeWithIndex:2];
        }
    }
}

#pragma mark - 3D动画
-(CATransform3D)firstTransform{
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0/-900;
    t1 = CATransform3DScale(t1, 0.9, 0.9, 0.9);
    t1 = CATransform3DRotate(t1, 15.0 * M_PI/180.0, 1, 0, 0);
    return t1;
}

-(CATransform3D)secondTransform{
    CATransform3D form2 = CATransform3DIdentity;
    form2.m34 = [self firstTransform].m34;
    form2 = CATransform3DTranslate(form2, 0, self.view.frame.size.height * (-0.08), 0);
    form2 = CATransform3DScale(form2, 0.9, 0.9, 1);
    return form2;
}

#pragma mark - 售后服务说明
-(void)showAftermarkView{
    __weak typeof(self) weakSelf = self;
    self.markShowStatus = MarkViewShowAftermarket;
    [[[UIApplication sharedApplication].windows lastObject] addSubview:self.markView];
    [[[UIApplication sharedApplication].windows lastObject] addSubview:self.aftermarkView];
    [weakSelf.aftermarkView setupInfoWithProductDetailsArticleArr:weakSelf.productItem.articles];
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.view.layer.transform = [weakSelf firstTransform];
        weakSelf.markView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            weakSelf.view.layer.transform = [weakSelf secondTransform];
            CGRect frame = self.aftermarkView.frame;
            frame.origin.y = mainScreenHeight - FitHeight(750.0);
            weakSelf.aftermarkView.frame = frame;
        } completion:^(BOOL finished) {
            
        }];
    }];
}

-(void)closeAftermarkView{
    CGRect frame = self.aftermarkView.frame;
    frame.origin.y = self.view.bounds.size.height;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        [weakSelf.view.layer setTransform:[weakSelf firstTransform]];
        weakSelf.aftermarkView.frame = frame;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.markView.backgroundColor = [[UIColor colorFromHex:0x484848] colorWithAlphaComponent:0.0];
            weakSelf.view.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            [weakSelf.markView removeFromSuperview];
            weakSelf.markView = nil;
            [weakSelf.aftermarkView removeFromSuperview];
            weakSelf.aftermarkView = nil;
        }];
    }];
}

-(AftermarketView *)aftermarkView{
    if (!_aftermarkView) {
        __weak typeof(self) weakSelf = self;
        _aftermarkView = [[AftermarketView alloc]initWithFrame:CGRectMake(0, mainScreenHeight, mainScreenWidth, FitHeight(750.0))];
        _aftermarkView.closeHandle = ^(){
            [weakSelf closeAftermarkView];
        };
        [[[UIApplication sharedApplication].windows lastObject] addSubview:_shipAddressView];
    }
    return _aftermarkView;
}

#pragma mark - 税率说明
-(void)showTexDesmarkView{
    self.markShowStatus = MarkViewShowTexDes;
    [[[UIApplication sharedApplication].windows lastObject] addSubview:self.markView];
    [[[UIApplication sharedApplication].windows lastObject] addSubview:self.texDesView];
    [self.texDesView setupInfoWithProductDetailsArticleArr:self.productItem.articlesGlobal];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.view.layer.transform = [weakSelf firstTransform];
        weakSelf.markView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            weakSelf.view.layer.transform = [self secondTransform];
            CGRect frame = self.texDesView.frame;
            frame.origin.y = mainScreenHeight - FitHeight(750.0);
            weakSelf.texDesView.frame = frame;
        } completion:^(BOOL finished) {
            
        }];
    }];
}

-(void)closeTexDesmarkView{
    CGRect frame = self.texDesView.frame;
    frame.origin.y = self.view.bounds.size.height;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        [weakSelf.view.layer setTransform:[weakSelf firstTransform]];
        weakSelf.texDesView.frame = frame;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.markView.backgroundColor = [[UIColor colorFromHex:0x484848] colorWithAlphaComponent:0.0];
            weakSelf.view.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            [weakSelf.markView removeFromSuperview];
            weakSelf.markView = nil;
            [weakSelf.texDesView removeFromSuperview];
            weakSelf.texDesView = nil;
        }];
    }];
}

-(ProductTexDesView *)texDesView{
    if (!_texDesView) {
        __weak typeof(self) weakSelf = self;
        _texDesView  = [[ProductTexDesView alloc]initWithFrame:CGRectMake(0, mainScreenHeight, mainScreenWidth, FitHeight(750.0))];
        _texDesView.closeHandle = ^(){
            [weakSelf closeTexDesmarkView];
        };
        [[[UIApplication sharedApplication].windows lastObject] addSubview:_texDesView];
    }
    return _texDesView;
}

#pragma mark - 运送地址选择
-(void)showShipAddressView{
    self.markShowStatus = MarkViewShowAddress;
    [[[UIApplication sharedApplication].windows lastObject] addSubview:self.markView];
    [[[UIApplication sharedApplication].windows lastObject] addSubview:self.shipAddressView];
    if (_addressDataArray.count > 0) {
        [self.shipAddressView setupInfoWithAddressModelInfoDataArr:_addressDataArray];
    }
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.view.layer.transform = [weakSelf firstTransform];
        weakSelf.markView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.view.layer.transform = [weakSelf secondTransform];
            CGRect frame = weakSelf.shipAddressView.frame;
            frame.origin.y = mainScreenHeight - FitHeight(750.0);
            weakSelf.shipAddressView.frame = frame;
        } completion:^(BOOL finished) {
            
        }];
    }];
}

-(void)closeShipAddressView{
    CGRect frame = self.shipAddressView.frame;
    frame.origin.y = mainScreenHeight;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        [weakSelf.view.layer setTransform:[weakSelf firstTransform]];
        weakSelf.shipAddressView.frame = frame;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.markView.backgroundColor = [[UIColor colorFromHex:0x484848] colorWithAlphaComponent:0.0];
            weakSelf.view.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            [weakSelf.markView removeFromSuperview];
            weakSelf.markView = nil;
            [weakSelf.shipAddressView removeFromSuperview];
            weakSelf.shipAddressView = nil;
        }];
    }];
}

-(ShippingAddressView *)shipAddressView{
    if (!_shipAddressView) {
        __weak typeof(self) weakSelf = self;
        _shipAddressView = [[ShippingAddressView alloc]initWithFrame:CGRectMake(0, mainScreenHeight, mainScreenWidth, FitHeight(750.0)) includeAddressAddressModel:_addressDataArray.count > 0];
        weakSelf.shipAddressView.seletcedHandle = ^(NSString *address) {
            [weakSelf.mainView setupInfoWithAddressStr:address];
            [weakSelf closeShipAddressView];
        };
        _shipAddressView.closeHandle = ^(){
            [weakSelf closeShipAddressView];
        };
        [[[UIApplication sharedApplication].windows lastObject] addSubview:weakSelf.shipAddressView];
    }
    return _shipAddressView;
}

-(void)resetAddressModleSeletcedStatus{
    for (AddressModel *item in _addressDataArray) {
        item.isSeletced = false;
    }
}

#pragma mark - 优惠券选择
-(void)showCouponsView{
    self.markShowStatus = MarkViewShowCoupons;
    [[[UIApplication sharedApplication].windows lastObject] addSubview:self.markView];
    [[[UIApplication sharedApplication].windows lastObject] addSubview:self.getCouponsView];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.view.layer.transform = [weakSelf firstTransform];
        weakSelf.markView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.view.layer.transform = [weakSelf secondTransform];
            CGRect frame = weakSelf.getCouponsView.frame;
            frame.origin.y = mainScreenHeight - FitHeight(750.0);
            weakSelf.getCouponsView.frame = frame;
        } completion:^(BOOL finished) {
            
        }];
    }];
}

-(void)closeCouponsView{
    CGRect frame = self.getCouponsView.frame;
    frame.origin.y = mainScreenHeight;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        [weakSelf.view.layer setTransform:[weakSelf firstTransform]];
        weakSelf.getCouponsView.frame = frame;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.markView.backgroundColor = [[UIColor colorFromHex:0x484848] colorWithAlphaComponent:0.0];
            weakSelf.view.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            [weakSelf.markView removeFromSuperview];
            weakSelf.markView = nil;
            [weakSelf.getCouponsView removeFromSuperview];
            weakSelf.getCouponsView = nil;
        }];
    }];
}

-(GetCouponsTableView *)getCouponsView{
    if (_getCouponsView) {
        return _getCouponsView;
    }else{
        __weak typeof(self) weakSelf = self;
        _getCouponsView = [[GetCouponsTableView alloc]initWithFrame:CGRectMake(0, mainScreenHeight, mainScreenWidth, FitHeight(750.0))];
        _getCouponsView.getCouponsHandle = ^(NSInteger index){
            [weakSelf getCouponsWithIndex:index];
        };
        _getCouponsView.closeHandle = ^(){
            [weakSelf closeCouponsView];
        };
        [[[UIApplication sharedApplication].windows lastObject] addSubview:_getCouponsView];
        [_getCouponsView setupInfoWithCouponInfoDataArr:_couponCodeResponses];
        _getCouponsView.hidden = false;
        UITapGestureRecognizer *singinVieTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getCouponsViewTap)];
        [_getCouponsView addGestureRecognizer:singinVieTap];
    }
    return _getCouponsView;
}

-(void)getCouponsViewTap{
    //什么都不用做，禁止事件向下传递
}

//领取优惠券
-(void)getCouponsWithIndex:(NSInteger)index{
    CouponInfoData *info = _couponCodeResponses[index];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:info.couponId forKey:@"couponId"];
    __weak typeof(self) weakSelf = self;
    [RequestManager requestWithMethod:POST WithUrlPath:@"user/coupon" params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            [MQToast showToast:@"领取成功" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
            info.codeStatus = CouponUseWithNoUse;
            [weakSelf.getCouponsView setupInfoWithCouponInfoDataArr:weakSelf.couponCodeResponses];
        }
    } fail:^(NSError *error) {
        //
    }];
}

#pragma mark - 规格选择
-(void)showStandarsView{
    self.standarsViewIsShow = true;
    self.markShowStatus = MarkViewShowStandars;
    [[UIApplication sharedApplication].keyWindow addSubview:self.markView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.standarsView];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.view.layer.transform = [weakSelf firstTransform];
        weakSelf.markView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.view.layer.transform = [weakSelf secondTransform];
            CGRect frame = weakSelf.standarsView.frame;
            frame.origin.y = FitHeight(300.0);
            weakSelf.standarsView.frame = frame;
        } completion:^(BOOL finished) {
            
        }];
    }];
}

-(void)closeStandarsView{
    self.standarsViewIsShow = false;
    [[UIApplication sharedApplication].keyWindow endEditing:true];
    CGRect frame = self.standarsView.frame;
    frame.origin.y = mainScreenHeight;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        [weakSelf.view.layer setTransform:[weakSelf firstTransform]];
        weakSelf.standarsView.frame = frame;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.markView.backgroundColor = [[UIColor colorFromHex:0x484848] colorWithAlphaComponent:0.0];
            weakSelf.view.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            [weakSelf.markView removeFromSuperview];
            weakSelf.markView = nil;
            [weakSelf.standarsView removeFromSuperview];
            weakSelf.standarsView = nil;
        }];
    }];
}

//遮罩
-(UIView *)markView{
    if (_markView) {
        return _markView;
    }
    _markView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight)];
    _markView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    _markView.userInteractionEnabled = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenMarkView)];
    [_markView addGestureRecognizer:tap];
    return _markView;
}

-(void)hiddenMarkView{//关闭弹出界面
    if ( self.markShowStatus == MarkViewShowStandars) {
        [self closeStandarsView];
    }
    if (self.markShowStatus == MarkViewShowCoupons) {
        [self closeCouponsView];
    }
    if (self.markShowStatus == MarkViewShowAddress) {
        [self closeShipAddressView];
    }
    if (self.markShowStatus == MarkViewShowAftermarket) {
        [self closeAftermarkView];
    }
    if (self.markShowStatus == MarkViewShowShare) {
        [self closeShareView];
    }
    if (self.markShowStatus == MarkViewShowTexDes) {
        [self closeTexDesmarkView];
    }
}

//规格选择界面
-(ProductStandardChoiceView *)standarsView{
    if (_standarsView) {
        _standarsView.hidden = false;
        return _standarsView;
    }
    __weak typeof(self) weakSelf = self;
    _standarsView = [[ProductStandardChoiceView alloc]initWithFrame:CGRectMake(0, mainScreenHeight, mainScreenWidth, mainScreenHeight - FitHeight(300.0))];
    [_standarsView setupInfoWithProductDetailsData:_productItem];
  
    UITapGestureRecognizer *singinVieTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(standarsViewTap)];
    [_standarsView addGestureRecognizer:singinVieTap];
    //规格点击回调
    _standarsView.indexChoiceHandle = ^(NSArray *indexArr){//选择规格 - 获取价格库存
        //获取多个name
        NSMutableArray *propertieNameArr = [NSMutableArray array];
        for (int i = 0; i < indexArr.count; i++) {
            NSString *itemIdStr = indexArr[i];
            ProductPropertyData *data = weakSelf.productItem.propertyProductEntities[i];
            for (ProductPropertyDetails *item in data.childValues) {
                if ([item.itemId isEqualToString:itemIdStr]) {
                    [propertieNameArr addObject:item.name];
                }
            }
        }
        //拼接id 为 id:id:id:id 样式
        NSMutableString *str = [NSMutableString string];
        for (NSString *s in indexArr) {
            [str appendFormat:@"%@", [NSString stringWithFormat:@"%@:",s]];
        }
        NSString *newStr = [str substringToIndex:[str length] - 1];
        //拼接属性名称
        NSMutableString *nameStr = [NSMutableString string];
        for (NSString *s in propertieNameArr) {
            [nameStr appendFormat:@"%@", [NSString stringWithFormat:@"%@，",s]];
        }
        weakSelf.propertiesName = nameStr;
        weakSelf.requsetUrlStr = [NSString stringWithFormat:@"product/%@?propertyCollection=%@",weakSelf.productNum,newStr];
        [weakSelf configDataWithUrlStr:weakSelf.requsetUrlStr];
    };
    _standarsView.closeHandle = ^(){
        [weakSelf closeStandarsView];
    };
    _standarsView.productImgTapAction = ^ (UIImage * image) {
        MIPhotoBrowser *photoBrowser = [[MIPhotoBrowser alloc] init];
        photoBrowser.delegate = weakSelf;
        photoBrowser.sourceImagesContainerView = self.standarsView;
        photoBrowser.imageCount = 1;
        photoBrowser.currentImageIndex = 0;
        weakSelf.bigImage = image;
        [photoBrowser show];
    };
    _standarsView.commitHandle = ^(NSArray *indexArr,NSInteger amount){//提交规格处理
        if (!weakSelf.autoAddtoShopCart) {
            if (weakSelf.standarsViewShowType == StandarsViewShowWithLook) {
                [weakSelf closeStandarsView];
                return ;
            }
        }
        weakSelf.autoAddtoShopCart = false;
        if (_buyStatus == SingleItemBuyToPay) {
            [weakSelf orderSureWithShopCarSureData:nil andProductNumber:weakSelf.productItem.productNumber propertyCollection:weakSelf.productItem.repertorySelect.propertyCollection count:weakSelf.count];
            return;
        }
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:weakSelf.productItem.productNumber forKey:@"productNumber"];
        [params setObject:weakSelf.productItem.repertorySelect.propertyCollection forKey:@"propertyCollection"];
        [params setObject:[NSNumber numberWithInteger:amount] forKey:@"count"];
        NSString *urlStr = _buyStatus == SingleItemBuyAddCart ? @"user/cart" : @"user/order/single/confirm";
        [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:weakSelf showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                [MQToast showToast:@"已加入购物车" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
                [weakSelf closeStandarsView];
                [weakSelf configShopCartItemCount];
            }
        } fail:^(NSError *error) {
            //
        }];
    };
    return _standarsView;
}

-(void)standarsViewTap{
    [[UIApplication sharedApplication].keyWindow endEditing:true];
    //什么都不用做，禁止事件向下传递
}

//确认下单
-(void)orderSureWithShopCarSureData:(ShopCarSureData *)item andProductNumber:(NSString *)num propertyCollection:(NSString *)propertyCollection count:(NSString *)count{
    OrderSureViewController *orderSureVC = [[OrderSureViewController alloc]initWithOrderSuerStatus:OrderSuerStatusBySingleItem ShopCarSureData:item andShopCartIdArr:[NSArray array]];
    orderSureVC.hidesBottomBarWhenPushed = true;
    orderSureVC.productNumber = num;
    orderSureVC.propertyCollection = propertyCollection;
    orderSureVC.count = count;
    orderSureVC.isGlobal = _productItem.isGlobal;
    [self.navigationController pushViewController:orderSureVC animated:true];
}

-(void)productAmoutChangeHandle:(NSNotification *)notify{
    _count = [NSString stringWithFormat:@"%@",notify.userInfo[@"productAmout"]];
}

#pragma mark - 收藏 & 取消收藏
-(void)cancelcollectProduct{
    _footView.collectBtn.userInteractionEnabled = false;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSArray *seletcedArr = @[_productItem.productNumber];
    [params setObject:@[_productItem.repertorySelect.propertyCollection] forKey:@"propertyCollections"];
    __weak typeof(self) weakSelf = self;
    [RequestManager requestWithMethod:POST WithUrlPath:@"product/collect/cancel/sku" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            weakSelf.footView.collectBtn.selected = false;
            weakSelf.footView.collectBtn.userInteractionEnabled = true;
            [weakSelf.footView.collectBtn setImageEdgeInsets:UIEdgeInsetsMake(-10, 0, 0, -25)];
        }
    } fail:^(NSError *error) {
        weakSelf.footView.collectBtn.userInteractionEnabled = true;
        //
    }];
}

-(void)collectProduct{
    _footView.collectBtn.userInteractionEnabled = false;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@[_productItem.repertorySelect.propertyCollection] forKey:@"propertyCollections"];
    __weak typeof(self) weakSelf = self;
    [RequestManager requestWithMethod:POST WithUrlPath:@"product/collect/multi/sku" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            weakSelf.footView.collectBtn.selected = true;
            weakSelf.footView.collectBtn.userInteractionEnabled = true;
            [weakSelf.footView.collectBtn setImageEdgeInsets:UIEdgeInsetsMake(-10, 0, 0, -35)];
        }
    } fail:^(NSError *error) {
        weakSelf.footView.collectBtn.userInteractionEnabled = true;
        //
    }];
}

#pragma mark - 美洽(客服聊天)
-(void)chatWithServer{
    if (![self checkLogin]) {
        [self userlogin];
        return;
    }
    UserInfo *info = [Utils getUserInfo];
    NSDictionary* clientCustomizedAttrs = @{
                                            @"link"             : [NSString stringWithFormat:@"%@product/detail/%@?_share=true",BaseUrl,_productItem.productNumber],
                                            @"price"            : _productItem.price,
                                            @"productName"      : _productItem.productName,
                                            @"productNumber"    : _productItem.productNumber
                                            };
    NSMutableDictionary *clientInfo = [NSMutableDictionary dictionaryWithDictionary:clientCustomizedAttrs];
    
    if (info.token) {
        [clientInfo setObject:info.name forKey:@"name"];
        [clientInfo setObject:[NSString stringWithFormat:@"%@%@",BaseImgUrl,info.avatar] forKey:@"avatar"];
    }
    DuojiProductMessage *meaasge = [[DuojiProductMessage alloc]initWithProductDetailsData:_productItem];
    DuojiProductModel *model = [[DuojiProductModel alloc]initCellModelWithMessage:meaasge cellWidth:FitWith(630.0) delegate:nil];
    MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
    chatViewManager.productCellModel = model;
    [chatViewManager setClientInfo:clientInfo override:true];
    [chatViewManager setLoginCustomizedId:[NSString stringWithFormat:@"%@_%@",_productItem.productNumber,info.userId]];
    chatViewManager.chatViewStyle.incomingBubbleColor = [UIColor colorFromHex:0xffffff];
    chatViewManager.chatViewStyle.incomingMsgTextColor = [UIColor colorFromHex:0x222222];
    chatViewManager.chatViewStyle.outgoingBubbleColor = [UIColor colorFromHex:0xffffff];
    chatViewManager.chatViewStyle.outgoingMsgTextColor = [UIColor colorFromHex:0x222222];
    chatViewManager.chatViewStyle.eventTextColor = [UIColor mainColor];
    chatViewManager.chatViewStyle.navBackButtonImage = [UIImage imageNamed:@"new_nav_arrow_black"];
    chatViewManager.chatViewStyle.enableIncomingAvatar = true;
    chatViewManager.chatViewStyle.enableRoundAvatar = true;
    chatViewManager.chatViewStyle.enableOutgoingAvatar = true;
    chatViewManager.chatViewStyle.btnTextColor = [UIColor mainColor];
    chatViewManager.chatViewStyle.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    chatViewManager.chatViewStyle.navBarTintColor = [UIColor colorFromHex:0x808080];
    [chatViewManager enableSendVoiceMessage:false];
    [chatViewManager enableChatWelcome:true];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - 44, 20, 44, 44)];
    [btn setImage:[UIImage imageNamed:@"server_right_btn"] forState:UIControlStateNormal];
    chatViewManager.chatViewStyle.navBarRightButton = btn;
    
    [chatViewManager pushMQChatViewControllerInViewController:self];
}

#pragma mark - 分享
-(void)showShareView{
    self.markShowStatus = MarkViewShowShare;
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self.markView];
    [window addSubview:self.shareView];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = weakSelf.shareView.frame;
        frame.origin.y -= FitHeight(600.0);
        weakSelf.shareView.frame = frame;
    }];
}

-(void)closeShareView{
    CGRect frame = self.shareView.frame;
    frame.origin.y = mainScreenHeight;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.shareView.frame = frame;
        weakSelf.markView.backgroundColor = [[UIColor colorFromHex:0x484848] colorWithAlphaComponent:0.0];
        weakSelf.shareView.frame = frame;
    } completion:^(BOOL finished) {
        [weakSelf.markView removeFromSuperview];
        weakSelf.markView = nil;
        [weakSelf.shareView removeFromSuperview];
        weakSelf.shareView = nil;
    }];
}

-(ShareView *)shareView{
    if (_shareView == nil) {
        _shareView = [[ShareView alloc]initWithFrame:CGRectMake(0, mainScreenHeight, mainScreenWidth, FitHeight(600.0))];
        __weak typeof(self) weakSelf = self;
        _shareView.cancelHandle = ^(){
            [weakSelf closeShareView];
        };
        _shareView.shareHandle = ^(NSInteger index){
            [weakSelf shareCotentWithIndex:index];
        };
        [[[UIApplication sharedApplication].windows lastObject] addSubview:_shareView];
        UITapGestureRecognizer *singinVieTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareViewTap)];
        [_shareView addGestureRecognizer:singinVieTap];
    }
    return _shareView;
}

-(void)shareViewTap{
    //什么都不用做，禁止touch事件向下传递
}

-(void)shareCotentWithIndex:(NSInteger)index{
    NSArray *imgArr = [NSArray arrayWithObjects:_productItem.showPics[0], nil];
    NSString *url = [NSString stringWithFormat:@"%@product/detail/%@?_share=true",BaseUrl,_productItem.productNumber];
    if (index == 5) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = url;
        [self.view makeToast:@"已复制到剪贴板,快去分享给您的朋友吧"];
        return;
    }
    NSString *title =_productItem.productName;
    NSString *contenText = _productItem.productSubName;
    SSDKPlatformType PlatformType = SSDKPlatformSubTypeWechatSession;
    if (index == 0) {
        PlatformType = SSDKPlatformSubTypeWechatSession;
    }
    if (index == 1) {
        PlatformType = SSDKPlatformSubTypeWechatTimeline;
    }
    if (index == 2) {
        PlatformType = SSDKPlatformTypeSinaWeibo;
    }
    if (index == 3) {
        PlatformType = SSDKPlatformSubTypeQQFriend;
    }
    if (index == 4) {
        PlatformType = SSDKPlatformSubTypeQZone;
    }
    if (PlatformType == SSDKPlatformTypeSinaWeibo) {//@哆集官微
        contenText = [NSString stringWithFormat:@"%@\n%@",title,url];
    }
    [Utils sharePlateType:PlatformType ImageArray:imgArr contentText:contenText shareURL:url shareTitle:title andViewController:self success:^(SSDKPlatformType plateType) {
        //
    }];
}

- (UIImage *)photoBrowser:(MIPhotoBrowser *)photoBrowser placeholderImageForIndex:(NSInteger)index{

    return  self.bigImage;
}


-(void)didReceiveMemoryWarning{
//    [self.view removeFromSuperview];
    NSLog(@"didReceiveMemoryWarning - SingleProductNewController ");
}


@end
