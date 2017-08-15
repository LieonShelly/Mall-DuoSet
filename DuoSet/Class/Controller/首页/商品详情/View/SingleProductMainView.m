//
//  SingleProductMainView.m
//  DuoSet
//
//  Created by fanfans on 2017/5/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//  商品详情WebView

#define KendDragHeight 50.0
//导航栏的高度
#define KnavHeight 64.0
//提示上下拉视图的高度
#define KmsgVIewHeight 40.0
#define WS(b_self)  __weak __typeof(&*self)b_self = self;

#import "SingleProductMainView.h"
#import "NewProductDetailsHeaderView.h"
#import "OnPullMsgView.h"
#import "DownPullMsgView.h"
//Cell
#import "ProductDetailsBaseInfoCell.h"
#import "ProductDetailsWillSeckillCell.h"
#import "ProductDetailsSeckillCell.h"
#import "ProductDetailsPromotionCell.h"
#import "SingleProductCouponsCell.h"
#import "ProductDetailsAddressCell.h"
#import "ProductDetaisSeletcedCell.h"
#import "ProductShowAllCommentCell.h"
#import "productCommentCountCell.h"
#import "CommentProductCell.h"
#import "AftermarketTipsCell.h"
#import "AftermarketContentCell.h"
#import <WebKit/WebKit.h>

@interface SingleProductMainView()<UITableViewDataSource, UITableViewDelegate,UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate>

@property(nonatomic,copy)   NSString *productNum;
@property(nonatomic,copy)   NSString *productTitle;
@property(nonatomic,copy)   NSString *productPrice;
@property(nonatomic,strong) UIView *bigView;
@property(nonatomic,strong) NewProductDetailsHeaderView *headerView;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) OnPullMsgView *pullMsgView;
@property(nonatomic,strong) WKWebView *webView;
@property(nonatomic,strong) UIScrollView *tempScrollView;//添加在头部视图的tempScrollView
@property(nonatomic,assign) BOOL isConverAnimation;//记录是否需要滚动视图差效果的动画
@property(nonatomic,assign) CGFloat bottomHeight;//记录底部空间所需的高度
@property(nonatomic,strong) UIView *srcrollToTopView;
@property(nonatomic,assign) BOOL isScrollToTopAction;

@property(nonatomic,strong) ProductDetailsData *productItem;
@property(nonatomic,strong) AddressModel *addressItem;
@property(nonatomic,strong) NSMutableArray *couponCodeResponses;
@property(nonatomic,strong) NSMutableArray *commentArr;
@property(nonatomic,copy)   NSString *addressStr;
@property(nonatomic,copy)   NSString *propertiesName;
@property(nonatomic,copy)   NSString *count;
@property(nonatomic,copy) NSString *systemTime;
@property(nonatomic,copy) NSString *newsystemTime;
@property(nonatomic,retain) dispatch_source_t timer;

@end

@implementation SingleProductMainView

-(instancetype)initWithFrame:(CGRect)frame andProductNum:(NSString *)productNum{
    self = [super initWithFrame:frame];
    if (self) {
        _productNum = productNum;
        _bottomHeight = 50.0;
        _count = @"1";
        [self configUI];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productAmoutChangeHandle:) name:@"ProductAmoutChange" object:nil];
    }
    return self;
}

-(void)productAmoutChangeHandle:(NSNotification *)notify{
    _count = [NSString stringWithFormat:@"%@",notify.userInfo[@"productAmout"]];
    ProductDetaisSeletcedCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    cell.seletcedLable.text = [NSString stringWithFormat:@"%@%@件",_productItem.repertorySelect.propertyName,_count];
}

-(void)dealloc{
    NSLog(@"dealloc - SingleProductMainView");
    _webView.navigationDelegate = nil;
    _webView.UIDelegate = nil;
    _webView.scrollView.delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)removeTimer{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

-(void)configUI{
    self.bigView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, (mainScreenHeight - 64 - _bottomHeight)*2)];
    self.bigView.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight - 64 - _bottomHeight)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, mainScreenHeight - 64 - _bottomHeight, mainScreenWidth, mainScreenHeight - _bottomHeight - 64)];
    _webView.backgroundColor = [UIColor clearColor];
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    _webView.userInteractionEnabled = true;
    [_webView setAllowsBackForwardNavigationGestures:true];
    self.webView.scrollView.delegate = self;
    
    [self addSubview:_bigView];
    [_bigView addSubview:_tableView];
    [_bigView addSubview:_webView];
    
    _srcrollToTopView = [[UIView alloc]initWithFrame:CGRectMake(mainScreenWidth - FitWith(100.0) - FitWith(40.0), _webView.frame.size.height - FitWith(120.0), FitWith(100.0), FitWith(100.0))];
    [self.webView addSubview:_srcrollToTopView];
    
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
    
    //设置上下拉提示的视图
    [self setMsgView];
    _isConverAnimation = true;
    // 加载图文详情
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSString *str = [NSString stringWithFormat:@"%@product/%@/detail-pic",BaseUrl,weakSelf.productNum];
        [weakSelf.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    });
}

-(void)scrollToTopAction{
    self.isScrollToTopAction = true;
    [self.webView.scrollView setContentOffset:CGPointMake(0, 0) animated:true];
}

-(void)setupInfoWithFirstLangchCover:(NSString *)cover productTitle:(NSString *)productTitle productPrice:(NSString *)productPrice{
    [_headerView setupinfoWithImgArr:@[cover]];
    _productTitle = productTitle;
    _productPrice = productPrice;
}

-(void)setMsgView{
    //添加头部和尾部视图
    UIView*headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, FitHeight(750.0))];
    headerView.backgroundColor = [UIColor clearColor];
    
    _tempScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(750.0))];
    [headerView addSubview:_tempScrollView];
    
    _headerView = [[NewProductDetailsHeaderView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(750.0))];
    [_tempScrollView addSubview:_headerView];
    _tableView.tableHeaderView = headerView;
    
    __weak typeof(self) weakSelf = self;
    _headerView.imgTapHandle = ^(NSInteger index) {
        HeaderViewCoverTapHandle block = weakSelf.coverTapHandle;
        if (block) {
            block(index);
        }
    };
    //设置上拉提示视图
    _pullMsgView = [[OnPullMsgView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, KmsgVIewHeight)];
    _tableView.tableFooterView = _pullMsgView;
    _pullMsgView.hidden = true;
    
    //设置下拉提示视图
    DownPullMsgView*downPullMsgView = [[DownPullMsgView alloc]initWithFrame:CGRectMake(0, -KmsgVIewHeight, mainScreenWidth, KmsgVIewHeight)];
    [_webView.scrollView addSubview:downPullMsgView];
}

-(void)setupInfoWithProductDetailsData:(ProductDetailsData *)productItem{
    _productItem = productItem;
    if (_productItem.robSessionResponse.countDown.length > 0) {
        [self handleSystime];
    }
    [_headerView setupinfoWithProductDetailsData:productItem];
    [_tableView reloadData];
    _pullMsgView.hidden = false;
}

//处理倒计时 防止cell重用导致的倒计时混乱
-(void)handleSystime{
    if (_timer != nil) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
    if (_timer == nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
        __weak typeof(self) weakSelf = self;
        dispatch_source_set_event_handler(weakSelf.timer, ^{
            long long int nowSec = weakSelf.productItem.robSessionResponse.countDown.longLongValue;
            nowSec -= 1000;
            if (nowSec <= 1000) {
                dispatch_source_cancel(_timer);
                weakSelf.timer = nil;
                SeckillCutdownEndBLock block = weakSelf.cutdownEndHandle;
                if (block) {
                    block();
                }
            }
            weakSelf.productItem.robSessionResponse.countDown = [NSString stringWithFormat:@"%lld",nowSec];
        });
        dispatch_resume(_timer);
    }
}

-(void)setupInfoWithCouponCodeResponses:(NSMutableArray *)couponCodeResponses{
    _couponCodeResponses = couponCodeResponses;
    [_tableView reloadData];
}

-(void)setupInfoWithAddressModel:(AddressModel *)addressItem{
    _addressItem = addressItem;
    ProductDetailsAddressCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    _addressStr = [NSString stringWithFormat:@"%@%@%@%@",_addressItem.province,_addressItem.city,_addressItem.area,_addressItem.addr];
    cell.addressLable.text = [NSString stringWithFormat:@"%@%@%@%@",_addressItem.province,_addressItem.city,_addressItem.area,_addressItem.addr];
}

-(void)setupInfoWithAddressStr:(NSString *)addressStr{
    ProductDetailsAddressCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    _addressStr = addressStr;
    cell.addressLable.text = addressStr;
}

-(void)setupInfoWithCommentArr:(NSMutableArray *)commentArr{
    _commentArr = commentArr;
    [_tableView reloadData];
}

-(void)setupPropertiesName:(NSString *)propertiesName andSeletcedCount:(NSString *)count{
    _propertiesName = propertiesName;
    _count = count;
    ProductDetaisSeletcedCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    cell.seletcedLable.text = [NSString stringWithFormat:@"%@%@件",_propertiesName,_count];
}


#pragma mark - UitableViewDataSource & UItableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _productItem == nil ? 1 : 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        //0：基本信息 1：促销 2：优惠券
        return  _productItem == nil ? 1 : 3;
    }
    if (section == 1) {//地址
        return 1;
    }
    if (section == 2) {//已选规格
        return 1;
    }
    if (section == 3) {//售后服务支持
        return 2;
    }
    if (section == 4) {//评论
        return _commentArr.count > 0 ? _commentArr.count + 2 : 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (_productItem == nil) {
                return FitHeight(170.0);
            }
            
            if (_productItem.seckillStatus == ProductDetailsDefault) {
                return _productItem.baseInfoCellHight;
            }
            if (_productItem.seckillStatus == ProductDetailsSeckilling) {
                return _productItem.seckillCellHight;
            }
            if (_productItem.seckillStatus == ProductDetailsSeckillWillBegin) {
                return _productItem.seckillWillBeginCellHight;
            }
            return _productItem.baseInfoCellHight;
        }
        if (indexPath.row == 1) {
            return 0;
//            return FitHeight(120.0);
        }
        if (indexPath.row == 2) {
            return _couponCodeResponses.count > 0 ? FitHeight(100.0) : 0;
        }
    }
    if (indexPath.section == 1) {
        return FitHeight(150.0);
    }
    if (indexPath.section == 2) {
        return FitHeight(100.0);
    }
    if (indexPath.section == 3) {
        return FitHeight(70.0);
    }
    if (indexPath.section == 4) {
        if (indexPath.row == 0 || indexPath.row == _commentArr.count + 1) {
            return FitHeight(90.0);
        }
        CommentData *item = _commentArr[indexPath.row - 1];
        return item.productCellHight;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (_productItem == nil) {
                static NSString *ProductDetailsBaseInfoCellID = @"ProductDetailsBaseInfoCellID";
                ProductDetailsBaseInfoCell * cell = [_tableView dequeueReusableCellWithIdentifier:ProductDetailsBaseInfoCellID];
                if (cell == nil) {
                    cell = [[ProductDetailsBaseInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ProductDetailsBaseInfoCellID];
                }
                [cell setupInfoWithFirstLangchProductTitle:_productTitle productPrice:_productPrice];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            if (_productItem.seckillStatus == ProductDetailsDefault) {//不是秒杀商品
                static NSString *ProductDetailsBaseInfoCellID = @"ProductDetailsBaseInfoCellID";
                ProductDetailsBaseInfoCell * cell = [_tableView dequeueReusableCellWithIdentifier:ProductDetailsBaseInfoCellID];
                if (cell == nil) {
                    cell = [[ProductDetailsBaseInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ProductDetailsBaseInfoCellID];
                }
                __weak typeof(self) weakSelf = self;
                if (_productItem) {
                    [cell setupInfoWithProductDetailsData:_productItem];
                }
                cell.texBtnHandle = ^{
                    [weakSelf handleTexBtnAction];
                };
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            if (_productItem.seckillStatus == ProductDetailsSeckilling) {//正在抢购中
                if (_productItem.productNewRobResponse) {
                    static NSString *ProductDetailsSeckillCellID = @"ProductDetailsSeckillCellID";
                    ProductDetailsSeckillCell * cell = [_tableView dequeueReusableCellWithIdentifier:ProductDetailsSeckillCellID];
                    if (cell == nil) {
                        cell = [[ProductDetailsSeckillCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ProductDetailsSeckillCellID];
                    }
                    if (_productItem) {
                        [cell setupInfoWithProductDetailsData:_productItem];
                    }
                    __weak typeof(self) weakSelf = self;
                    cell.texBtnHandle = ^{
                        [weakSelf handleTexBtnAction];
                    };
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }
            }
            if (_productItem.seckillStatus == ProductDetailsSeckillWillBegin) {//秒杀即将开始
                if (_productItem.productNewRobResponse) {
                    static NSString *ProductDetailsWillSeckillCellID = @"ProductDetailsWillSeckillCellID";
                    ProductDetailsWillSeckillCell * cell = [_tableView dequeueReusableCellWithIdentifier:ProductDetailsWillSeckillCellID];
                    if (cell == nil) {
                        cell = [[ProductDetailsWillSeckillCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ProductDetailsWillSeckillCellID];
                    }
                    if (_productItem) {
                        [cell setupInfoWithProductDetailsData:_productItem];
                    }
                    __weak typeof(self) weakSelf = self;
                    cell.texBtnHandle = ^{
                        [weakSelf handleTexBtnAction];
                    };
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }
            }
        }
        if (indexPath.row == 1) {
            return [[UITableViewCell alloc]initWithFrame:CGRectZero];
            //促销后期才做
//            static NSString *ProductDetailsPromotionCellID = @"ProductDetailsPromotionCellID";
//            ProductDetailsPromotionCell * cell = [_tableView dequeueReusableCellWithIdentifier:ProductDetailsPromotionCellID];
//            if (cell == nil) {
//                cell = [[ProductDetailsPromotionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ProductDetailsPromotionCellID];
//            }
//            if (_productItem) {
//                
//            }
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            return cell;
        }
        if (indexPath.row == 2) {
            if (_couponCodeResponses.count == 0) {
                return [[UITableViewCell alloc]initWithFrame:CGRectZero];
            }
            static NSString *SingleProductCouponsCellID = @"SingleProductCouponsCellID";
            SingleProductCouponsCell * cell = [_tableView dequeueReusableCellWithIdentifier:SingleProductCouponsCellID];
            if (cell == nil) {
                cell = [[SingleProductCouponsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SingleProductCouponsCellID];
            }
            if (_couponCodeResponses) {
                [cell setupInfoWithCouponInfoDataArr:_couponCodeResponses];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    
    if (indexPath.section == 1) {//地址
        static NSString *ProductDetailsAddressCellID = @"ProductDetailsAddressCellID";
        ProductDetailsAddressCell * cell = [_tableView dequeueReusableCellWithIdentifier:ProductDetailsAddressCellID];
        if (cell == nil) {
            cell = [[ProductDetailsAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ProductDetailsAddressCellID];
        }
        cell.addressLable.text = _addressStr.length == 0 ? @"请选择收货地址" : _addressStr;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (indexPath.section == 2) {
        static NSString *ProductDetaisSeletcedCellID = @"ProductDetaisSeletcedCellID";
        ProductDetaisSeletcedCell * cell = [_tableView dequeueReusableCellWithIdentifier:ProductDetaisSeletcedCellID];
        if (cell == nil) {
            cell = [[ProductDetaisSeletcedCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ProductDetaisSeletcedCellID];
        }
        if (_productItem.repertorySelect) {
            if (_productItem.repertorySelect.propertyName.length > 0 && _count.length > 0) {
                cell.seletcedLable.text = [NSString stringWithFormat:@"%@%@件",_productItem.repertorySelect.propertyName,_count];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            static NSString *AftermarketTipsCellID = @"AftermarketTipsCellID";
            AftermarketTipsCell * cell = [_tableView dequeueReusableCellWithIdentifier:AftermarketTipsCellID];
            if (cell == nil) {
                cell = [[AftermarketTipsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AftermarketTipsCellID];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row == 1) {
            static NSString *AftermarketContentCellID = @"AftermarketContentCellID";
            AftermarketContentCell * cell = [_tableView dequeueReusableCellWithIdentifier:AftermarketContentCellID];
            if (cell == nil) {
                cell = [[AftermarketContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AftermarketContentCellID];
            }
            if (_productItem) {
                [cell setupInfoWithProductDetailsData:_productItem];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    
    if (indexPath.section == 4) {
        if (_commentArr.count > 0 && indexPath.row == _commentArr.count + 1) {
            static NSString *ProductShowAllCommentCellID = @"ProductShowAllCommentCellID";
            ProductShowAllCommentCell * cell = [_tableView dequeueReusableCellWithIdentifier:ProductShowAllCommentCellID];
            if (cell == nil) {
                cell = [[ProductShowAllCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ProductShowAllCommentCellID];
            }
            if (_productItem) {
                cell.showAllLable.text = [NSString stringWithFormat:@"查看全部评价(%@)",_productItem.commentCount];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row == 0) {
            static NSString *productCommentCountCellID = @"productCommentCountCellID";
            productCommentCountCell * cell = [_tableView dequeueReusableCellWithIdentifier:productCommentCountCellID];
            if (cell == nil) {
                cell = [[productCommentCountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productCommentCountCellID];
            }
            [cell setupInfoWithProductDetailsData:_productItem];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        CommentData *item = _commentArr[indexPath.row - 1];
        NSString *CommentCellID = [NSString stringWithFormat:@"CommentCellID-%ld",(unsigned long)item.pics.count];
        CommentProductCell * cell = [_tableView dequeueReusableCellWithIdentifier:CommentCellID];
        if (cell == nil) {
            cell = [[CommentProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommentCellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak typeof(self) weakSelf = self;
        cell.imgVTapActionHandle = ^(NSInteger index){
            ImageViewTapBlock block = weakSelf.imgVTapHandle;
            if (block) {
                block(item,index);
            }
        };
        [cell setupInfoWithCommentData:item];
        return cell;
    }
    static NSString *SingleProductCouponsCellID = @"SingleProductCouponsCellID";
    UITableViewCell * cell = [_tableView dequeueReusableCellWithIdentifier:SingleProductCouponsCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SingleProductCouponsCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return FitHeight(20.0);
    }
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SingleProductMainViewCellSeletcedBlock block = _cellHandle;
    if (block) {
        block(indexPath);
    }
}

#pragma mark -- UIScrollViewDelegate 用于控制头部视图滑动的视差效果
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
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
        if (scrollView == self.webView.scrollView && self.isScrollToTopAction == true) {
            if (offset == 0) {
                self.isScrollToTopAction = false;
                __weak typeof(self) weakSelf = self;
                [UIView animateWithDuration:0.1 animations:^{
                    weakSelf.bigView.transform = CGAffineTransformIdentity;
                    [weakSelf.tableView setContentOffset:CGPointMake(0, 0) animated:true];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"ProductDetailsMainControllerShowBaseInfo" object:nil];
                } completion:^(BOOL finished) {
                }];
            }
        }
    }else{
        NSLog(@"");
    }
}

#pragma mark -- 监听滚动实现商品详情与图文详情界面的切换
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    __weak typeof(self) weakSelf = self;
    CGFloat offset = scrollView.contentOffset.y;
    if (scrollView == _tableView) {
        if (offset > _tableView.contentSize.height - mainScreenHeight + weakSelf.bottomHeight + KendDragHeight) {
            [UIView animateWithDuration:0.4 animations:^{
                weakSelf.bigView.transform = CGAffineTransformTranslate(weakSelf.bigView.transform, 0, -mainScreenHeight +  weakSelf.bottomHeight + KnavHeight);
            } completion:^(BOOL finished) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ProductDetailsMainControllerShowWeb" object:nil];
            }];
        }
    }
    if (scrollView == _webView.scrollView) {
        if (offset < - KendDragHeight) {
            [UIView animateWithDuration:0.4 animations:^{
                [UIView animateWithDuration:0.4 animations:^{
                    weakSelf.bigView.transform = CGAffineTransformIdentity;
                    
                }];
            } completion:^(BOOL finished) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ProductDetailsMainControllerShowBaseInfo" object:nil];
            }];
        }
    }
}

-(void)handleTexBtnAction{
    __weak typeof(self) weakSelf = self;
    SingleProductMainViewTexBtnActionBlock block = weakSelf.texHandle;
    if (block) {
        block();
    }
}

#pragma mark - WKNavigationDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSURL *url = webView.URL;
    NSLog(@"url.absoluteString : %@",url.absoluteString);
    if ([url.absoluteString hasPrefix:@"https://cn.hlhdj.duoji/callPhone/"]) {//拨打电话
        NSString *str = [url.absoluteString stringByReplacingOccurrencesOfString:@"https://cn.hlhdj.duoji/callPhone/" withString:@""];
        WebViewPhoneCallBlock block = _webCallHandle;
        if (block) {
            block(str);
        }
        return;
    }
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSString *jsMeta = [NSString stringWithFormat:@"var meta = document.createElement('meta');meta.content='width=device-width,initial-scale=1.0,minimum-scale=.5,maximum-scale=3';meta.name='viewport';document.getElementsByTagName('head')[0].appendChild(meta);"];
    [webView evaluateJavaScript:jsMeta completionHandler:^(id _Nullable objerct, NSError * _Nullable error) {
        //
    }];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}

@end
