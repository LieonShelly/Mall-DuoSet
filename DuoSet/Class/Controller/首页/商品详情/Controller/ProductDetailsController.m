//
//  ProductDetailsController.m
//  DuoSet
//
//  Created by fanfans on 2017/4/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//


//拖拽的高度
#define KendDragHeight 50.0
//导航栏的高度
#define KnavHeight 64.0
//提示上下拉视图的高度
#define KmsgVIewHeight 40.0
#define WS(b_self)  __weak __typeof(&*self)b_self = self;

#import "ProductDetailsController.h"
#import "NewProductDetailsHeaderView.h"
#import "OnPullMsgView.h"
#import "DownPullMsgView.h"
#import "ProductDetailFootView.h"

@interface ProductDetailsController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,copy) NSString *productNum;

@property (nonatomic,strong) UIView *bigView;
@property (nonatomic,strong) NewProductDetailsHeaderView *headerView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) ProductDetailFootView *footView;
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) UIScrollView *tempScrollView;//添加在头部视图的tempScrollView
@property (nonatomic,assign) BOOL isConverAnimation;//记录是否需要滚动视图差效果的动画
@property (nonatomic,assign) CGFloat bottomHeight;//记录底部空间所需的高度

@property(nonatomic,strong) ProductDetailsData *productItem;

@end

@implementation ProductDetailsController

-(instancetype)initWithProductId:(NSString *)productNum{
    self = [super init];
    if (self) {
        _productNum = productNum;
        _bottomHeight = 50.0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

-(void)configUI{
    self.bigView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, (mainScreenHeight - 64 - _bottomHeight)*2)];
    self.bigView.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight - 64 - _bottomHeight)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, mainScreenHeight - 64 - _bottomHeight, mainScreenWidth, mainScreenHeight - _bottomHeight - 64)];
    _webView.backgroundColor = [UIColor clearColor];
    self.webView.scrollView.delegate = self;
    
    [self.view addSubview:_bigView];
    [_bigView addSubview:_tableView];
    [_bigView addSubview:_webView];
    
    //设置上下拉提示的视图
    [self setMsgView];
//    [self.view sendSubviewToBack:self.view];
    _isConverAnimation = true;
    // 加载图文详情
    WS(b_self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSString *str = [NSString stringWithFormat:@"%@product/%@/detail-pic",BaseUrl,_productNum];
        [b_self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    });
    
    _footView = [[ProductDetailFootView alloc]initWithFrame:CGRectMake(0, mainScreenHeight - 50, mainScreenWidth, 50) andProductDetailsData:b_self.productItem];
    _footView.btnActionHandle = ^(UIButton* btn){
        [b_self footViewBtnsActionWithIndex:btn];
    };
    [self.view addSubview:_footView];
}

-(void)setMsgView{
    //添加头部和尾部视图
    UIView*headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, FitHeight(690.0))];
    headerView.backgroundColor = [UIColor blueColor];
    
    _tempScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, mainScreenWidth, FitHeight(690.0))];
    [headerView addSubview:_tempScrollView];
    
    _headerView = [[NewProductDetailsHeaderView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, FitHeight(690.0))];
    [_tempScrollView addSubview:_headerView];
    _tableView.tableHeaderView = headerView;
    //设置上拉提示视图
    OnPullMsgView*pullMsgView = [[OnPullMsgView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, KmsgVIewHeight)];
    _tableView.tableFooterView = pullMsgView;
    //设置下拉提示视图
    DownPullMsgView*downPullMsgView = [[DownPullMsgView alloc]initWithFrame:CGRectMake(0, -KmsgVIewHeight, mainScreenWidth, KmsgVIewHeight)];
    [_webView.scrollView addSubview:downPullMsgView];
}

#pragma mark - UitableViewDataSource & UItableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark -- 每个cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *SingleProductCouponsCellID = @"SingleProductCouponsCellID";
    UITableViewCell * cell = [_tableView dequeueReusableCellWithIdentifier:SingleProductCouponsCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SingleProductCouponsCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark -- 每组头部视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 5;
}


#pragma mark -- 选择每个cell执行的操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark -- UIScrollViewDelegate 用于控制头部视图滑动的视差效果
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_isConverAnimation) {
        CGFloat offset = scrollView.contentOffset.y;
        if (scrollView == _tableView){
            //重新赋值，就不会有用力拖拽时的回弹
            _tempScrollView.contentOffset = CGPointMake(_tempScrollView.contentOffset.x, 0);
            if (offset >= 0 && offset <= mainScreenWidth) {
                //因为tempScrollView是放在tableView上的，tableView向上速度为1，实际上tempScrollView的速度也是1，此处往反方向走1/2的速度，相当于tableView还是正向在走1/2，这样就形成了视觉差！
                _tempScrollView.contentOffset = CGPointMake(_tempScrollView.contentOffset.x, - offset / 2.0f);
            }
        }
    }else{}
}

#pragma mark -- 监听滚动实现商品详情与图文详情界面的切换
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    WS(b_self);
    CGFloat offset = scrollView.contentOffset.y;
    if (scrollView == _tableView) {
        if (offset > _tableView.contentSize.height - mainScreenHeight + self.bottomHeight + KendDragHeight) {
            [UIView animateWithDuration:0.4 animations:^{
                b_self.bigView.transform = CGAffineTransformTranslate(b_self.bigView.transform, 0, -mainScreenHeight +  self.bottomHeight + KnavHeight);
            } completion:^(BOOL finished) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ProductDetailsMainControllerShowWeb" object:nil];
            }];
        }
    }
    if (scrollView == _webView.scrollView) {
        if (offset < - KendDragHeight) {
            [UIView animateWithDuration:0.4 animations:^{
                [UIView animateWithDuration:0.4 animations:^{
                    b_self.bigView.transform = CGAffineTransformIdentity;
                    
                }];
            } completion:^(BOOL finished) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ProductDetailsMainControllerShowBaseInfo" object:nil];
            }];
        }
    }
}

#pragma mark - 底部按钮点
-(void)footViewBtnsActionWithIndex:(UIButton *)btn{
//    if (_productItem == nil) {//判断数据是否请求完成
//        return;
//    }
//    if (btn.tag == 0) {
//        [self chatWithServer];
//    }
//    
//    if (![self checkLogin]) {
//        [self userlogin];
//        return;
//    }
//    if (btn.tag == 3 || btn.tag == 4) {
//        [self showStandarsView:true];
//        _buyStatus = btn.tag == 3 ?  SingleItemBuyAddCart : SingleItemBuyToPay;
//        return;
//    }
//    if (btn.tag == 1) {
//        if (btn.selected) {
//            [self cancelcollectProduct];
//        }else{
//            [self collectProduct];
//        }
//        return;
//    }
//    if (btn.tag == 2) {//goto shopcart
//        ShoppingCartViewController *shopCartVC = [[ShoppingCartViewController alloc]init];
//        shopCartVC.isFromPrudoctDetail = true;
//        shopCartVC.hidesBottomBarWhenPushed = true;
//        [self.navigationController pushViewController:shopCartVC animated:true];
//        return;
//    }
}

@end
