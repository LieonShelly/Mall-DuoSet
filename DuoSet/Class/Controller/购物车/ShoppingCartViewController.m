//
//  ShoppingCartViewController.m
//  DuoSet
//
//  Created by Seven-Augus on 2016/11/23.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShoppingCartCell.h"
#import "HeadCollectionReusableView.h"
#import "RegisterViewController.h"
#import "ShopCarModel.h"
#import "RecommendForYouProductsDataModel.h"
#import "SingleProductNewController.h"
//#import "ShopCartBottomView.h"
#import "Product.h"
#import "CommonTitleImageCell.h"
#import "CommonRecommendForYouCell.h"
#import "ShopCartDB.h"
#import "LoginViewController.h"
#import "CustomNavController.h"

#import "ShopCarSureData.h"
#import "ShopCartNoLoginCell.h"
#import "ShopCartEmptyCell.h"
#import "ProductForListData.h"
#import "ShopCartInputToolBar.h"
#import "ShopCartStandardChoiceView.h"
#import "ShopCartStandardRepertoryData.h"
#import "ShopCartSelectInfo.h"

#import "ShopCartShowPriceFootView.h"
#import "ShopCartEditFootView.h"
#import "ShopCartSurebuyChoiceView.h"
#import "MIPhotoBrowser.h"

typedef enum : NSUInteger {
    BottomViewShowStyleAmountForMoney,//非编辑状态
    BottomViewShowStyleOtherAciton//编辑状态
} ShopCartBottomViewStatus;

@interface ShoppingCartViewController () <MIPhotoBrowserDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    NSInteger numLabels;
}
//nav
@property(nonatomic,strong) UIView *navView;
@property(nonatomic,strong) UILabel *titleLable;
@property(nonatomic,strong) UIButton *rightEditBtn;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) UIView *unredView;

@property (nonatomic, copy) UITableView *shoppingCartTableView;
@property (nonatomic, copy) UICollectionView *recommendToYouCollectionView; // 为你推荐
@property (nonatomic, strong) NSMutableArray *shopCarDataArray;
@property (nonatomic, strong) ShopCartSelectInfo *selectInfoData;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UIButton *allChoseProBtn;
@property (nonatomic, strong) UIView *clearMarkView;
@property (nonatomic, assign) ShopCartBottomViewStatus choiceStatus;
@property (nonatomic, strong) ShopCartInputToolBar *toolbar;

@property (nonatomic,copy)   NSString *recommendIconStr;
@property (nonatomic,strong) NSMutableArray *recommendArr;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger limit;
@property (nonatomic,assign) NSInteger lastRequsetCount;
@property (nonatomic,assign) NSInteger currentEditIndex;
@property (nonatomic,strong) NSIndexPath *currentIndexPath;
@property (nonatomic,strong) NSMutableArray *propertyProductEntities;
@property (nonatomic,strong) ShopCartStandardRepertoryData *repertoryData;
@property (nonatomic,strong) ShopCartStandardChoiceView *standarsView;
@property (nonatomic,strong) UIView *markView;

@property(nonatomic,strong) ShopCartShowPriceFootView *showPriceFootView;
@property(nonatomic,strong) ShopCartEditFootView *editFootView;

@property(nonatomic,strong) UIView *sureChoiceMarkView;
@property(nonatomic,strong) ShopCartSurebuyChoiceView *sureChoiceView;

@property (nonatomic,assign) BOOL isLogin;
@property(nonatomic, strong) UIImage *bigImage;

@end

@implementation ShoppingCartViewController

#pragma mark - viewWillAppear & viewWillDisappear & viewDidLoad
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    if (_isLogin) {
        if ([self checkRefreshToken]) {
            [self getShopCarDataShowHud:false];
        }else{
            [RequestManager refershTokenSuccess:^{
                [self getShopCarDataShowHud:false];
            }];
        }
    }else{
        [self hiddenFootView];
    }
    //IQKeyboardManager
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = true;
    manager.shouldResignOnTouchOutside = true;
    manager.shouldToolbarUsesTextFieldTintColor = true;
    manager.enableAutoToolbar = false;
    manager.shouldShowTextFieldPlaceholder = false;
    manager.enableAutoToolbar = false;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    //IQKeyboardManager
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = true;
    manager.shouldResignOnTouchOutside = false;
    manager.shouldToolbarUsesTextFieldTintColor = true;
    manager.enableAutoToolbar = true;
    manager.shouldShowTextFieldPlaceholder = false;
    manager.enableAutoToolbar = false;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"doneAction" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"购物车";
    _choiceStatus = BottomViewShowStyleAmountForMoney;
    UserInfo *info = [Utils getUserInfo];
    _isLogin = info.token != nil;
    [self initView];
    [self configNav];
    _page = 0;
    _lastRequsetCount = 0;
    _limit = 10;
    _recommendArr = [NSMutableArray array];
    [self configRecommendDataClear:true showHud:true];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucessHandle) name:@"LoginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutSucessHandle) name:@"LogoutSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSopCartNumber) name:@"NewAddProductIntoSHopCart" object:nil];
    
    _clearMarkView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight)];
    _clearMarkView.userInteractionEnabled = true;
    _clearMarkView.hidden = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenToolBarAndKeyBord)];
    [_clearMarkView addGestureRecognizer:tap];
    [self.view addSubview:_clearMarkView];
    
    _toolbar = [[ShopCartInputToolBar alloc]initWithFrame:CGRectMake(0, mainScreenHeight, mainScreenWidth, 44)];
    __weak typeof(self) weakSelf = self;
    _toolbar.btnActionHandle = ^(NSInteger index) {
        if (index == 0) {
            weakSelf.clearMarkView.hidden = true;
            IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
            [manager resignFirstResponder];
            ShopCarModel *item = weakSelf.shopCarDataArray[weakSelf.currentEditIndex];
            ShoppingCartCell * cell = [weakSelf.shoppingCartTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:weakSelf.currentEditIndex inSection:0]];
            [cell.itemModifyView setupInfoWithCurrentCount:item.count];
        }
        if (index == 1) {
            IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
            [manager resignFirstResponder];
            ShoppingCartCell * cell = [weakSelf.shoppingCartTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:weakSelf.currentEditIndex inSection:0]];
            NSInteger tmpCount = cell.itemModifyView.countTextField.text.integerValue;
            ShopCarModel *item = weakSelf.shopCarDataArray[weakSelf.currentEditIndex];
            if (cell.itemModifyView.countTextField.text.integerValue > item.repertoryCount.integerValue) {
                tmpCount = item.repertoryCount.integerValue;
                if (tmpCount > 200) {
                    tmpCount = 200;
                }
            }
            if (cell.itemModifyView.countTextField.text.integerValue == 0) {
                tmpCount = 1;
            }
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:[NSNumber numberWithInteger:item.cartId.integerValue] forKey:@"cartId"];
            [params setObject:[NSNumber numberWithInteger:tmpCount] forKey:@"count"];
            [RequestManager requestWithMethod:POST WithUrlPath:@"user/cart/cartCount" params:params from:weakSelf showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
                NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
                if ([resultCode isEqualToString:@"ok"]) {
                    item.count = [NSString stringWithFormat:@"%ld",(long)tmpCount];
                    [cell.itemModifyView setupInfoWithCurrentCount:item.count];
                    [weakSelf reSetBottomViewAllPrice];
                }else{
                    [cell.itemModifyView setupInfoWithCurrentCount:item.count];
                    [weakSelf reSetBottomViewAllPrice];
                }
            } fail:^(NSError *error) {
                //
            }];
        }
    };
    [self.view addSubview:_toolbar];
}

-(void)loginSucessHandle{
    _isLogin = true;
    [self getShopCarDataShowHud:true];
    [self reSetBottomViewAllPrice];
    [self.shoppingCartTableView setContentOffset:CGPointMake(0, 0) animated:true];
}

-(void)logoutSucessHandle{
    _isLogin = false;
    _shopCarDataArray = [NSMutableArray array];
    [_shoppingCartTableView reloadData];
    _rightEditBtn.hidden = true;
    [self hiddenFootView];
    NSArray *tabBarItems = self.navigationController.tabBarController.tabBar.items;
    UITabBarItem *shopCartItem = [tabBarItems objectAtIndex:3];
    shopCartItem.badgeValue = nil;
    CGFloat tableViewH = mainScreenHeight  - 50 - 44;
    _shoppingCartTableView.frame = CGRectMake(0, 44, mainScreenWidth, tableViewH);
}

#pragma mark - getShopCarData & getRecommendForYouProductsData
- (void)getShopCarDataShowHud:(BOOL)showHud{
    [RequestManager requestWithMethod:GET WithUrlPath:@"user/cart/list" params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                _shopCarDataArray = [NSMutableArray array];
                if ([objDic objectForKey:@"cart"] && [[objDic objectForKey:@"cart"] isKindOfClass:[NSArray class]]) {
                    NSArray *cartArr = [objDic objectForKey:@"cart"];
                    for (NSDictionary *d in cartArr) {
                        ShopCarModel *item = [ShopCarModel dataForDictionary:d];
                        [_shopCarDataArray addObject:item];
                    }
                }
            }
            [_shoppingCartTableView reloadData];
            if (_shopCarDataArray.count > 0) {
                [self reSetBottomViewAllPrice];
                _rightEditBtn.hidden = false;
                NSArray *tabBarItems = self.navigationController.tabBarController.tabBar.items;
                UITabBarItem *shopCartItem = [tabBarItems objectAtIndex:3];
                shopCartItem.badgeValue = _shopCarDataArray.count > 99 ? @"99+" : [NSString stringWithFormat:@"%ld",_shopCarDataArray.count];
                [self configFootView];
            }else{
                _choiceStatus = BottomViewShowStyleAmountForMoney;
                [_rightEditBtn setTitle:@"编辑" forState:UIControlStateNormal];
                if (_isFromPrudoctDetail) {
                    CGFloat tableViewH = mainScreenHeight - 44;
                    _shoppingCartTableView.frame = CGRectMake(0, 44, mainScreenWidth, tableViewH);
                }else{
                    CGFloat tableViewH = mainScreenHeight - 44 - 50;
                    _shoppingCartTableView.frame = CGRectMake(0, 44, mainScreenWidth, tableViewH);
                }
                _rightEditBtn.hidden = true;
                [self hiddenFootView];
                NSArray *tabBarItems = self.navigationController.tabBarController.tabBar.items;
                UITabBarItem *shopCartItem = [tabBarItems objectAtIndex:3];
                shopCartItem.badgeValue = nil;
            }
            if (_isFromPrudoctDetail) {
                CGFloat tableViewH = _shopCarDataArray.count > 0 ? mainScreenHeight  - 50 - 44 : mainScreenHeight - 44;
                _shoppingCartTableView.frame = CGRectMake(0, 44, mainScreenWidth, tableViewH);
            }else{
                CGFloat tableViewH = _shopCarDataArray.count > 0 ? mainScreenHeight  - 50 - 44 - 50 : mainScreenHeight  - 50 - 44 ;
                _shoppingCartTableView.frame = CGRectMake(0, 44, mainScreenWidth, tableViewH);
            }
            [_shoppingCartTableView reloadData];
        }
    } fail:^(NSError *error) {
        //
    }];
}

//获取推荐商品
-(void)configRecommendDataClear:(BOOL)clear showHud:(BOOL)showHud{
    NSString *urlStr = @"";
    urlStr = [NSString stringWithFormat:@"homepage/20/recommend?page=%ld&limit=%ld",_page,_limit];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {//
            if (clear) {
                _recommendArr = [NSMutableArray array];
            }
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"productResponses"] && [[objDic objectForKey:@"productResponses"] isKindOfClass:[NSArray class]]) {
                    NSArray *productArr = [objDic objectForKey:@"productResponses"];
                    _lastRequsetCount = productArr.count;
                    for (NSDictionary *d in productArr) {
                        ProductForListData *item = [ProductForListData dataForDictionary:d];
                        [_recommendArr addObject:item];
                    }
                }
                if ([objDic objectForKey:@"adResponse"] && [[objDic objectForKey:@"adResponse"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *adDic = [objDic objectForKey:@"adResponse"];
                    _recommendIconStr = [adDic objectForKey:@"titleIcon"] != nil ? [NSString stringWithFormat:@"%@%@",BaseImgUrl,[adDic objectForKey:@"titleIcon"]] : @"";
                }
            }
            [_shoppingCartTableView reloadData];
        }
        [_shoppingCartTableView.mj_footer endRefreshing];
        [_shoppingCartTableView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        [_shoppingCartTableView.mj_footer endRefreshing];
        [_shoppingCartTableView.mj_header endRefreshing];
        //
    }];
}

#pragma mark - initView & configNav
- (void)initView{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.shoppingCartTableView];
    if (!_isFromPrudoctDetail) {
        UIImage *img = [UIImage imageNamed:@"home_footLine"];
        UIImageView *footLineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, mainScreenHeight - img.size.height - 42, mainScreenWidth, img.size.height)];
        footLineView.image = [UIImage imageNamed:@"home_footLine"];
        [self.view addSubview:footLineView];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)configNav{
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 64)];
    _navView.backgroundColor = [UIColor colorFromHex:0xfafafa];
    [self.view addSubview:_navView];
    
    if (_isFromPrudoctDetail) {
        UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
        [leftBtn setImage:[UIImage imageNamed:@"new_nav_arrow_black"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(leftItemHandle) forControlEvents:UIControlEventTouchUpInside];
        leftBtn.contentMode = UIViewContentModeCenter;
        [_navView addSubview:leftBtn];
    }
    
    _rightEditBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - 64,20,44,44)];
    _rightEditBtn.titleLabel.font = CUSFONT(13);
    [_rightEditBtn setTitleColor:[UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
    [_rightEditBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [_rightEditBtn addTarget:self action:@selector(rightEditHandle) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_rightEditBtn];
    
    if (!_isLogin) {
        _rightEditBtn.hidden = true;
        [self hiddenFootView];
    }
    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(44, 20, mainScreenWidth - 88, 44)];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.textColor = [UIColor blackColor];
    _titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    _titleLable.text = @"购物车";
    [_navView addSubview:_titleLable];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, mainScreenWidth, 0.5)];
    line.backgroundColor = [UIColor colorFromHex:0xBABABA];
    [_navView addSubview:line];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_choiceStatus == BottomViewShowStyleOtherAciton) {
        return 1;
    }else{
        return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (!_isLogin) {
            return 1;
        }
        if (_shopCarDataArray == nil) {
            return 0;
        }
        return _shopCarDataArray.count == 0 ? 1 : _shopCarDataArray.count;
    }
    if (section == 1) {
        if (_recommendArr == nil) {
            return 1;
        }
        return  _recommendArr.count == 0 ? 1 : 2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) { // 为你推荐
        if (indexPath.row == 0) {
            static NSString *CommonTipsCellID = @"CommonTipsCellID";
            CommonTitleImageCell * cell = [tableView dequeueReusableCellWithIdentifier:CommonTipsCellID];
            if (cell == nil) {
                cell = [[CommonTitleImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommonTipsCellID];
            }
            if (_recommendIconStr.length > 0) {
                [cell setupInfoWithTitleImageUrlStr:_recommendIconStr];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row == 1) {
            static NSString *CommonRecommendForYouCellID = @"CommonRecommendForYouCellID";
            CommonRecommendForYouCell * cell = [_shoppingCartTableView dequeueReusableCellWithIdentifier:CommonRecommendForYouCellID];
            if (cell == nil) {
                cell = [[CommonRecommendForYouCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommonRecommendForYouCellID];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            __weak typeof(self) weakSelf = self;
            [cell setupInfoWithRecommendListDataArr:_recommendArr];
            
            cell.recommendHandle = ^(NSInteger index){
                [weakSelf RecommendForYouProductItem:index];
            };
            return cell;
        }
    }
    if (!_isLogin) {//未登录
        static NSString *ShopCartNoLoginCellID = @"ShopCartNoLoginCellID";
        ShopCartNoLoginCell * cell = [tableView dequeueReusableCellWithIdentifier:ShopCartNoLoginCellID];
        if (cell == nil) {
            cell = [[ShopCartNoLoginCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ShopCartNoLoginCellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak typeof(self) weakSelf = self;
        cell.loginHandle = ^(){
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            CustomNavController *loginNav = [[CustomNavController alloc] initWithRootViewController:loginVC];
            [weakSelf presentViewController:loginNav animated:YES completion:nil];
        };
        return cell;
    }
    if (_shopCarDataArray.count == 0) {//购物车是空的
        static NSString *ShopCartEmptyCellID = @"ShopCartEmptyCellID";
        ShopCartEmptyCell * cell = [tableView dequeueReusableCellWithIdentifier:ShopCartEmptyCellID];
        if (cell == nil) {
            cell = [[ShopCartEmptyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ShopCartEmptyCellID];
        }
        cell.lookProductListHandle = ^(){//去逛逛
            @try {
                if (_isFromPrudoctDetail) {
                    UITabBarController *tabar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                    if (tabar.selectedIndex != 0) {
                        tabar.selectedIndex = 0;
                    }else{
                        [self.navigationController popToRootViewControllerAnimated:true];
                    }
                    return ;
                }
                UITabBarController *tabar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                tabar.selectedIndex = 0;
            } @catch (NSException *exception) {
                //
            } @finally {
                //
            }
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    static NSString *ShoppingCartCellID = @"ShoppingCartCellID";
    ShoppingCartCell * cell = [tableView dequeueReusableCellWithIdentifier:ShoppingCartCellID];
    if (cell == nil) {
        cell = [[ShoppingCartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ShoppingCartCellID];
    }
    ShopCarModel *item = _shopCarDataArray[indexPath.row];
    [cell setupInfoWithShopCarModel:item andIsEdit:_choiceStatus == BottomViewShowStyleOtherAciton];
    cell.itemModifyView.countTextField.tag = indexPath.row;
    cell.itemModifyView.countTextField.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.minHandle = ^(NSInteger amount){
        if (amount <= 1) {
            [MQToast showToast:@"至少选择一个数量" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
            return ;
        }
        [self modifyProductAmountWithShopCarModel:item andIndexPath:indexPath withAmount:amount - 1];
    };
    cell.plusHandle = ^(NSInteger amount){
        if (amount + 1 > item.repertoryCount.integerValue || amount + 1 > 200) {
            [MQToast showToast:@"商品库存数量不足" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
            return ;
        }
        [self modifyProductAmountWithShopCarModel:item andIndexPath:indexPath withAmount:amount + 1];
    };
    cell.productSelectedHandle = ^(){//选中修改
        if (_choiceStatus == BottomViewShowStyleAmountForMoney) {
            item.cartSelect = !item.cartSelect;
            [self modifyProductSelectedWithSelected:item.cartSelect andShopCarModel:item withIndexPath:indexPath];
        }else{
            item.isSelected = !item.isSelected;
            cell.selectedBtn.selected = item.isSelected;
            _editFootView.allSelectedBtn.selected = [self checkWithAllSeletcedForEdit];
            NSInteger selectedCount = 0;
            for (ShopCarModel *it in _shopCarDataArray) {
                if (it.isSelected) {
                    selectedCount += 1;
                }
            }
            [_editFootView setupSeletcedShopCartDataWithCount:selectedCount];
        }
    };
    cell.productChoiceOtherStandardHandle = ^{//编辑状态下修改属性 颜色尺寸
        _currentIndexPath = indexPath;
        [self productChoiceOtherStandardHandleWithIndexPath:indexPath];
    };
    return cell;
}

-(BOOL)checkWithAllSeletced{//true 全选
    for ( ShopCarModel *item in _shopCarDataArray) {
        if (!item.cartSelect) {
            return false;
        }
    }
    return true;
}

-(BOOL)checkWithAllSeletcedForEdit{
    for ( ShopCarModel *item in _shopCarDataArray) {
        if (!item.isSelected) {
            return false;
        }
    }
    return true;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) { // 为你推荐
        if (indexPath.row == 0) {
            return FitHeight(100.0);
        }
        if (indexPath.row == 1) {
            if (_recommendArr != nil && _recommendArr.count > 0) {
                return (FitHeight(600.0) + 3) * ((_recommendArr.count + 1) / 2);
            }else{
                return 0;
            }
        }
    }
    if (!_isLogin || _shopCarDataArray.count == 0) {
        return 110;
    }
    return 150;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && _shopCarDataArray.count > 0) {
        return UITableViewCellEditingStyleDelete;
    }else{
        return UITableViewCellEditingStyleNone;
    }
}

-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath {
    return @"删除";
}

//左滑点击事件
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        ShopCarModel *item = _shopCarDataArray[indexPath.row];
        NSMutableArray *arr = [NSMutableArray arrayWithObject:[NSNumber numberWithInteger:item.cartId.integerValue]];
        [params setObject:arr forKey:@"cartIds"];
        [RequestManager requestWithMethod:POST WithUrlPath:@"user/cart?remove" params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                [self getShopCarDataShowHud:true];
            }
        } fail:^(NSError *error) {
            //
        }];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (_shopCarDataArray.count > 0) {
            ShopCarModel *item = _shopCarDataArray[indexPath.row];
            SingleProductNewController *singleItemVC = [[SingleProductNewController alloc]initWithProductId:item.productNumber andCover:item.cover productTitle:item.productName productPrice:item.price andPropertyCollection:item.propertyCollection];
            singleItemVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:singleItemVC animated:true];
        }
    }
}

#pragma mark - IQKeyBord
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    _currentEditIndex = textField.tag;
    _clearMarkView.hidden = false;
}

- (void)keyboardWasShown:(NSNotification*)aNotification{
    _clearMarkView.hidden = false;
    NSDictionary *userInfo = aNotification.userInfo;
    CGRect keyBoardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGPoint point = _shoppingCartTableView.contentOffset;
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.y = keyBoardFrame.origin.y - self.toolbar.height;
        CGPoint newpoint = CGPointMake(0, point.y + 44);
        [_shoppingCartTableView setContentOffset:newpoint animated:true];
    }];
}

-(void)keyboardWillBeHidden:(NSNotification*)aNotification{
    _clearMarkView.hidden = true;
    NSDictionary *userInfo = aNotification.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGPoint point = _shoppingCartTableView.contentOffset;
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.y = mainScreenHeight;
        CGPoint newpoint = CGPointMake(0, point.y - 44);
        [_shoppingCartTableView setContentOffset:newpoint animated:true];
    }];
}

#pragma mark - Nav 编辑按钮操作 & 消息按钮
-(void)leftItemHandle{
    [self.navigationController popViewControllerAnimated:true];
}

-(void)rightEditHandle{
    if (_choiceStatus == BottomViewShowStyleAmountForMoney) {
        _choiceStatus = BottomViewShowStyleOtherAciton;
        [_rightEditBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_shoppingCartTableView reloadData];
        _editFootView.allSelectedBtn.selected = [self checkWithAllSeletcedForEdit];
    }else{
        _choiceStatus = BottomViewShowStyleAmountForMoney;
        [_rightEditBtn setTitle:@"编辑" forState:UIControlStateNormal];
        for (ShopCarModel *item in _shopCarDataArray) {
            item.isSelected = false;
        }
        [_shoppingCartTableView reloadData];
    }
    [self configFootView];
}

#pragma mark - 修改商品个数
-(void)modifyProductAmountWithShopCarModel:(ShopCarModel *)item andIndexPath:(NSIndexPath *)indexPath withAmount:(NSInteger)amount{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:item.cartId.integerValue] forKey:@"cartId"];
    [params setObject:[NSNumber numberWithInteger:amount] forKey:@"count"];
    [RequestManager requestWithMethod:POST WithUrlPath:@"user/cart/cartCount" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            item.count = [NSString stringWithFormat:@"%ld",amount];
            ShoppingCartCell *cell = [_shoppingCartTableView cellForRowAtIndexPath:indexPath];
            [cell.itemModifyView setupInfoWithCurrentCount:item.count];
            [self reSetBottomViewAllPrice];
        }
    } fail:^(NSError *error) {
        //
    }];
}

#pragma mark - 修改商品选中状态
-(void)modifyProductSelectedWithSelected:(BOOL)selected andShopCarModel:(ShopCarModel *)item withIndexPath:(NSIndexPath *)indexPath{
    item.cartSelect = selected;
    ShoppingCartCell * cell = [_shoppingCartTableView cellForRowAtIndexPath:indexPath];
    cell.selectedBtn.selected = item.cartSelect;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:1] forKey:@"selectType"];
    [params setObject:[NSNumber numberWithBool:selected] forKey:@"cartSelect"];
    [params setObject:[NSNumber numberWithInteger:item.cartId.integerValue] forKey:@"cartId"];
    [RequestManager requestWithMethod:POST WithUrlPath:@"user/cart/optCart" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            _showPriceFootView.allSelectedBtn.selected = [self checkWithAllSeletced];
            [self reSetBottomViewAllPrice];
        }
    } fail:^(NSError *error) {
        //
    }];
}

#pragma mark - 为你推荐 点击跳转
-(void)RecommendForYouProductItem:(NSInteger)index{
    ProductForListData *item = _recommendArr[index];
    SingleProductNewController *singleItemVC = [[SingleProductNewController alloc]initWithProductId:item.productNumber];
    singleItemVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:singleItemVC animated:true];
}

#pragma mark - 懒加载
- (UITableView *)shoppingCartTableView{
    if (!_shoppingCartTableView) {
        _shoppingCartTableView = ({
            CGFloat tableViewH = _isFromPrudoctDetail ? mainScreenHeight  - 44 :  mainScreenHeight - 44 - 50;
            UITableView *shoppingCartTableViews = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, mainScreenWidth, tableViewH) style:UITableViewStylePlain];
            [shoppingCartTableViews registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
            shoppingCartTableViews.delegate = self;
            shoppingCartTableViews.dataSource = self;
            shoppingCartTableViews.separatorStyle = UITableViewCellSeparatorStyleNone;
            shoppingCartTableViews.showsVerticalScrollIndicator = false;
            shoppingCartTableViews.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                if (_lastRequsetCount < _limit) {
                    [shoppingCartTableViews.mj_footer endRefreshingWithNoMoreData];
                    return ;
                }
                _page += 1;
                [self configRecommendDataClear:false showHud:false];
            }];
            shoppingCartTableViews.mj_header= [FFGifHeader headerWithRefreshingBlock:^{
                if (_isLogin) {
                    [self getShopCarDataShowHud:false];
                }
                _page = 0;
                _lastRequsetCount = 0;
                [self configRecommendDataClear:true showHud:false];
            }];
            shoppingCartTableViews;
        });
    }
    return _shoppingCartTableView;
}

#pragma mark - 重新获取价格
-(void)reSetBottomViewAllPrice{
    [RequestManager requestWithMethod:GET WithUrlPath:@"user/cart/price" params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"price"] && [[objDic objectForKey:@"price"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *priceDic = [objDic objectForKey:@"price"];
                    _selectInfoData = [ShopCartSelectInfo dataForDictionary:priceDic];
                }
                [_showPriceFootView setupInfoWithShopCartSelectInfo:_selectInfoData];
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)getSopCartNumber{
    [RequestManager requestWithMethod:GET WithUrlPath:@"user/cart/count" params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]){
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"count"]) {//_footView
                    NSString *count = [objDic objectForKey:@"count"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[objDic objectForKey:@"count"]] : @"0";
                    if (count.integerValue > 0) {
                        NSArray *tabBarItems = self.navigationController.tabBarController.tabBar.items;
                        UITabBarItem *shopCartItem = [tabBarItems objectAtIndex:3];
                        shopCartItem.badgeValue = count.integerValue > 99 ? @"99+" : count;
                    }
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

#pragma mark - 从新选择规格 颜色/尺寸
-(void)productChoiceOtherStandardHandleWithIndexPath:(NSIndexPath *)indexPath{
    ShopCarModel *item = _shopCarDataArray[indexPath.row];
    [RequestManager requestWithMethod:GET WithUrlPath:[NSString stringWithFormat:@"product/%@/propertyList?repertoryId=%@",item.productNumber,item.repertoryId] params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"propertyProductEntities"]) {
                    if ([[objDic objectForKey:@"propertyProductEntities"] isKindOfClass:[NSArray class]]) {
                        NSArray *arr = [objDic objectForKey:@"propertyProductEntities"];
                        _propertyProductEntities = [NSMutableArray array];
                        for (NSDictionary *d in arr) {
                            ProductPropertyData *item = [ProductPropertyData dataForDictionary:d];
                            [_propertyProductEntities addObject:item];
                        }
                        if (_propertyProductEntities.count > 0) {
                            NSMutableArray *idArr = [NSMutableArray array];
                            for (int i = 0; i < _propertyProductEntities.count; i++) {
                                ProductPropertyData *data = _propertyProductEntities[i];
                                for (ProductPropertyDetails *item in data.childValues) {
                                    if (item.selected) {
                                        [idArr addObject:item.itemId];
                                    }
                                }
                            }
                            NSString *str = [idArr componentsJoinedByString:@":"];
                            [self showStandarsView];
                            [self getProductInfoWithPropertyCollection:str andProductNum:item.productNumber];
                        }
                    }
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)getProductInfoWithPropertyCollection:(NSString *)propertyCollection andProductNum:(NSString *)productNum{
    [RequestManager requestWithMethod:GET WithUrlPath:[NSString stringWithFormat:@"product/%@/repertory?propertyCollection=%@",productNum,propertyCollection] params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"repertory"] && [[objDic objectForKey:@"repertory"] isKindOfClass:[NSDictionary class]]  ) {
                    NSDictionary *repertoryDic = [objDic objectForKey:@"repertory"];
                    _repertoryData = [ShopCartStandardRepertoryData dataForDictionary:repertoryDic]
                    ;
                    if (_standarsView) {
                        [_standarsView setupInfoWithPropertyProductEntities:_propertyProductEntities andShopCartStandardRepertoryData:_repertoryData];
                    }
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

#pragma mark - 规格选择
-(void)showStandarsView{
    [[[UIApplication sharedApplication].windows lastObject] addSubview:self.markView];
    [[[UIApplication sharedApplication].windows lastObject] addSubview:self.standarsView];
    [UIView animateWithDuration:0.3 animations:^{
        self.view.layer.transform = [self firstTransform];
        _markView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.layer.transform = [self secondTransform];
            CGRect frame = self.standarsView.frame;
            frame.origin.y = FitHeight(300.0);
            self.standarsView.frame = frame;
        } completion:^(BOOL finished) {
            
        }];
    }];
}

-(void)closeStandarsView{
    [[UIApplication sharedApplication].keyWindow endEditing:true];
    CGRect frame = self.standarsView.frame;
    frame.origin.y = mainScreenHeight;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view.layer setTransform:[self firstTransform]];
        self.standarsView.frame = frame;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            _markView.backgroundColor = [[UIColor colorFromHex:0x484848] colorWithAlphaComponent:0.0];
            self.view.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            [self.markView removeFromSuperview];
            self.markView = nil;
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
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:_markView];
    _markView.userInteractionEnabled = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenMarkView)];
    [_markView addGestureRecognizer:tap];
    
    return _markView;
}

-(void)hiddenMarkView{//关闭弹出界面
    [self closeStandarsView];
}

//规格选择界面
-(ShopCartStandardChoiceView *)standarsView{
    if (_standarsView) {
        _standarsView.hidden = false;
        return _standarsView;
    }
    __weak typeof(self) weakSelf = self;
    _standarsView = [[ShopCartStandardChoiceView alloc]initWithFrame:CGRectMake(0, mainScreenHeight, mainScreenWidth, mainScreenHeight - FitHeight(300.0))];
    [self.view addSubview:_standarsView];
    UITapGestureRecognizer *singinVieTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(standarsViewTap)];
    [_standarsView addGestureRecognizer:singinVieTap];
    //规格点击回调
    _standarsView.indexChoiceHandle = ^(NSArray *indexArr){//选择规格 - 获取价格库存
        ShopCarModel *item = weakSelf.shopCarDataArray[weakSelf.currentIndexPath.row];
        NSString *str = [indexArr componentsJoinedByString:@":"];
        [weakSelf getProductInfoWithPropertyCollection:str andProductNum:item.productNumber];
    };
    _standarsView.closeHandle = ^(){
        [weakSelf closeStandarsView];
    };
    _standarsView.commitHandle = ^(NSArray *indexArr,NSInteger amount){//提交规格处理
        ShopCarModel *item = weakSelf.shopCarDataArray[weakSelf.currentIndexPath.row];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        NSString *str = [indexArr componentsJoinedByString:@":"];
        [params setObject:str forKey:@"properties"];
        NSString *urlStr = [NSString stringWithFormat:@"user/cart/%@/property",item.cartId];
        [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:weakSelf showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                [weakSelf refreshNewShopCarModel];
            }
        } fail:^(NSError *error) {
            //
        }];
    };
    _standarsView.productImgTapAction = ^ (UIImage * image) {
        MIPhotoBrowser *photoBrowser = [[MIPhotoBrowser alloc] init];
        photoBrowser.delegate = self;
        photoBrowser.sourceImagesContainerView = self.standarsView;
        photoBrowser.imageCount = 1;
        photoBrowser.currentImageIndex = 0;
        self.bigImage = image;
        [photoBrowser show];
    };
    /*
     MIPhotoBrowser *photoBrowser = [[MIPhotoBrowser alloc] init];
     photoBrowser.delegate = self;
     photoBrowser.sourceImagesContainerView = self.standarsView;
     photoBrowser.imageCount = 1;
     photoBrowser.currentImageIndex = 0;
     self.bigImage = image;
     [photoBrowser show];
     */
    return _standarsView;
}

-(void)refreshNewShopCarModel{
    [self getShopCarDataShowHud:true];
    [self closeStandarsView];
    [self reSetBottomViewAllPrice];
}

-(void)standarsViewTap{
    [[UIApplication sharedApplication].keyWindow endEditing:true];
    //什么都不用做，禁止事件向下传递
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

#pragma mark - footView
-(void)configFootView{
    if (self.choiceStatus == BottomViewShowStyleAmountForMoney) {
        CGFloat bottomY = _isFromPrudoctDetail ? mainScreenHeight - FitHeight(100.0) :  mainScreenHeight - FitHeight(100.0) - 50;
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.showPriceFootView.frame;
            frame.origin.y = bottomY;
            self.showPriceFootView.frame = frame;
            
            CGRect frame1 = self.editFootView.frame;
            frame1.origin.y = mainScreenHeight;
            self.editFootView.frame = frame1;
        }];
    }else{
        CGFloat bottomY = _isFromPrudoctDetail ? mainScreenHeight - FitHeight(100.0) :  mainScreenHeight - FitHeight(100.0) - 50;
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.editFootView.frame;
            frame.origin.y = bottomY;
            self.editFootView.frame = frame;
            
            CGRect frame1 = self.showPriceFootView.frame;
            frame1.origin.y = mainScreenHeight;
            self.showPriceFootView.frame = frame1;
        }];
    }
}

-(void)hiddenFootView{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.editFootView.frame;
        frame.origin.y = mainScreenHeight;
        self.editFootView.frame = frame;
        
        CGRect frame1 = self.showPriceFootView.frame;
        frame1.origin.y = mainScreenHeight;
        self.showPriceFootView.frame = frame1;
    }];
}

-(ShopCartShowPriceFootView *)showPriceFootView{
    if (_showPriceFootView) {
        return _showPriceFootView;
    }
    CGFloat bottomY = _isFromPrudoctDetail ? mainScreenHeight - FitHeight(100.0) :  mainScreenHeight - FitHeight(100.0) - 50;
    _showPriceFootView = [[ShopCartShowPriceFootView alloc]initWithFrame:CGRectMake(0,bottomY, mainScreenWidth, FitHeight(100.0))];
    __weak typeof(self) weakSelf = self;
    _showPriceFootView.gotoPayHandle = ^(){
        [weakSelf sureAction];
    };
    _showPriceFootView.priceAllHandle = ^(UIButton *btn){
        btn.selected = !btn.selected;
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[NSNumber numberWithInteger:0] forKey:@"selectType"];
        [params setObject:[NSNumber numberWithBool:btn.selected] forKey:@"cartSelect"];
        [RequestManager requestWithMethod:POST WithUrlPath:@"user/cart/optCart" params:params from:weakSelf showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                for (ShopCarModel *item in weakSelf.shopCarDataArray) {//非编辑状态
                    item.cartSelect = btn.selected;
                }
                [weakSelf.shoppingCartTableView reloadData];
                [weakSelf reSetBottomViewAllPrice];
            }
        } fail:^(NSError *error) {
            //
        }];
    };
    [self.view addSubview:_showPriceFootView];
    
    return _showPriceFootView;
}

-(ShopCartEditFootView *)editFootView{
    if (_editFootView) {
        [_editFootView setupSeletcedShopCartDataWithCount:0];
        return _editFootView;
    }
    CGFloat bottomY = mainScreenHeight;
    _editFootView = [[ShopCartEditFootView alloc]initWithFrame:CGRectMake(0,bottomY, mainScreenWidth, FitHeight(100.0))];
    __weak typeof(self) weakSelf = self;
    _editFootView.editAllBtnHandle = ^(UIButton *btn){
        btn.selected = !btn.selected;
        for (ShopCarModel *item in weakSelf.shopCarDataArray) {
            item.isSelected = btn.selected;
        }
        [weakSelf.shoppingCartTableView reloadData];
        if (btn.selected) {
            [weakSelf.editFootView setupSeletcedShopCartDataWithCount:weakSelf.shopCarDataArray.count];
        }else{
            [weakSelf.editFootView setupSeletcedShopCartDataWithCount:0];
        }
    };
    _editFootView.collectBtnHandle = ^(){
        NSMutableArray *collectArr = [NSMutableArray array];
        for (ShopCarModel *item in weakSelf.shopCarDataArray) {
            if (item.isSelected) {
                [collectArr addObject:item.propertyCollection];
            }
        }
        if (collectArr.count == 0) {
            [MQToast showToast:@"请先选择您要收藏的商品" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
            return ;
        }
        if (collectArr.count > 0) {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:collectArr forKey:@"propertyCollections"];
            [RequestManager requestWithMethod:POST WithUrlPath:@"product/collect/multi/sku" params:params from:weakSelf showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
                NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
                if ([resultCode isEqualToString:@"ok"]) {
                    [MQToast showToast:@"收藏成功" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
                }
            } fail:^(NSError *error) {
                //
            }];
        }
    };
    _editFootView.deleteBtnHandle = ^(){
        NSMutableArray *deletedArr = [NSMutableArray array];
        for (ShopCarModel *item in weakSelf.shopCarDataArray) {
            if (item.isSelected) {
                [deletedArr addObject:[NSNumber numberWithInteger:item.cartId.integerValue]];
            }
        }
        if (deletedArr.count == 0) {
            [MQToast showToast:@"请先选择您要删除的商品" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
            return ;
        }
        if (deletedArr.count > 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定要删除购物车的商品吗？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *delete = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                [params setObject:deletedArr forKey:@"cartIds"];
                [RequestManager requestWithMethod:POST WithUrlPath:@"user/cart?remove" params:params from:weakSelf showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
                    NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
                    if ([resultCode isEqualToString:@"ok"]) {
                        [weakSelf getShopCarDataShowHud:false];
                        [weakSelf reSetBottomViewAllPrice];
                    }
                } fail:^(NSError *error) {
                    //
                }];
            }];
            [alert addAction:cancel];
            [alert addAction:delete];
            [weakSelf presentViewController:alert animated:true completion:nil];
        }
    };
    [self.view addSubview:_editFootView];
    
    return _editFootView;
}

-(void)hiddenToolBarAndKeyBord{
    self.clearMarkView.hidden = true;
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    [manager resignFirstResponder];
    ShopCarModel *item = self.shopCarDataArray[self.currentEditIndex];
    ShoppingCartCell * cell = [self.shoppingCartTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentEditIndex inSection:0]];
    [cell.itemModifyView setupInfoWithCurrentCount:item.count];
}

#pragma mark - 购物车结算包括全球购 选择操作
-(void)showSureChoiceView{
    _sureChoiceMarkView = self.sureChoiceMarkView;
    _sureChoiceView = self.sureChoiceView;
    CGRect frame = self.sureChoiceView.frame;
    frame.size.width = FitWith(600.0);
    frame.size.height = FitHeight(370.0);
    CGPoint center = self.sureChoiceView.center;
    center.x = mainScreenWidth * 0.5;
    center.y = mainScreenHeight * 0.5;
    [UIView animateWithDuration:0.25 animations:^{
        self.sureChoiceView.frame = frame;
        self.sureChoiceView.center = center;
    }];
}

-(void)closeSureChoiceView{
    CGRect frame =  self.sureChoiceView.frame;
    frame.size.width = 0;
    frame.size.height = 0;
    CGPoint center = self.sureChoiceView.center;
    center.x = mainScreenWidth * 0.5;
    center.y = mainScreenHeight * 0.5;
    [UIView animateWithDuration:0.25 animations:^{
        self.sureChoiceView.frame = frame;
        self.sureChoiceView.center = center;
    } completion:^(BOOL finished) {
        [_sureChoiceView removeFromSuperview];
        _sureChoiceView = nil;
        _sureChoiceMarkView.hidden = true;
    }];
}

-(ShopCartSurebuyChoiceView *)sureChoiceView{
    if (_sureChoiceView) {
        _sureChoiceView.hidden = false;
        return _sureChoiceView;
    }
    _sureChoiceView = [[ShopCartSurebuyChoiceView alloc]initWithFrame:CGRectMake(mainScreenWidth * 0.5, mainScreenHeight * 0.5,0,0)];
    _sureChoiceView.userInteractionEnabled = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sureChoiceViewTap)];
    [_sureChoiceView addGestureRecognizer:tap];
    [self.sureChoiceMarkView addSubview:_sureChoiceView];
    return _sureChoiceView;
}

-(UIView *)sureChoiceMarkView{
    if (_sureChoiceMarkView) {
        _sureChoiceMarkView.hidden = false;
        return _sureChoiceMarkView;
    }
    _sureChoiceMarkView = [[UIView alloc]initWithFrame:CGRectMake(0,0, mainScreenWidth, mainScreenHeight)];
    _sureChoiceMarkView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    _sureChoiceMarkView.userInteractionEnabled = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sureChoiceMarkViewTap)];
    [_sureChoiceMarkView addGestureRecognizer:tap];
    [[[UIApplication sharedApplication].windows lastObject] addSubview:self.sureChoiceMarkView];
    return _sureChoiceMarkView;
}

-(void)sureChoiceMarkViewTap{
    [self closeSureChoiceView];
}

-(void)sureChoiceViewTap{
    //什么都不用做
}

#pragma mark - 确认/去结算
- (void)sureAction{
    if (_shopCarDataArray != nil) {
        NSMutableArray *seletedArr = [NSMutableArray array];
        for (ShopCarModel *item in _shopCarDataArray) {
            if (item.cartSelect && item.canSelect) {
                [seletedArr addObject:item];
            }
        }
        NSMutableArray *cartIdArr = [NSMutableArray array];
        if (seletedArr.count > 0) {
            for (ShopCarModel *item in seletedArr) {
                [cartIdArr addObject:item.cartId];
            }
        }
        if (cartIdArr.count == 0) {
            return;
        }
        //拆分全球购和普通商品
        NSMutableArray *globalArr = [NSMutableArray array];
        NSInteger globalProductConut = 0;
        NSMutableArray *otherArr = [NSMutableArray array];
        NSInteger otherProductConut = 0;
        for (ShopCarModel *item in seletedArr) {
            if (item.isGlobal) {//是全球购
                [globalArr addObject:item.cartId];
                globalProductConut += item.count.integerValue;
            }else{
                [otherArr addObject:item.cartId];
                otherProductConut += item.count.integerValue;
            }
        }
        if (globalArr.count > 0 && otherArr.count > 0) {
            [self showSureChoiceView];
            [_sureChoiceView setupInfoWithGlobalCount:globalProductConut andOtherCount:otherProductConut];
            __weak typeof(self) weakSelf = self;
            _sureChoiceView.chioceHandle = ^(NSInteger btnIndex, BOOL isGloble) {
                if (btnIndex == 0) {
                    [weakSelf closeSureChoiceView];
                    return ;
                }
                if (btnIndex == 1) {
                    if (isGloble) {
                        [weakSelf orderSureWithShopCartIdArr:globalArr andIsGlobal:true];
                    }else{
                        [weakSelf orderSureWithShopCartIdArr:otherArr andIsGlobal:false];
                    }
                    [weakSelf closeSureChoiceView];
                }
            };
            return;
        }else if( otherArr.count == 0){//只有全球购
            [self orderSureWithShopCartIdArr:cartIdArr andIsGlobal:true];
        }else{//只有普通商品
            [self orderSureWithShopCartIdArr:cartIdArr andIsGlobal:false];
        }
    }
}

-(void)orderSureWithShopCartIdArr:(NSMutableArray *)shopCartIdArr andIsGlobal:(BOOL)IsGlobal{
    _showPriceFootView.gotoPayBtn.userInteractionEnabled = false;
    [self orderSureWithShopCarSureData:nil andShopCartIdArr:shopCartIdArr andIsGlobal:IsGlobal];
}

-(void)orderSureWithShopCarSureData:(ShopCarSureData *)item andShopCartIdArr:(NSArray *)arr andIsGlobal:(BOOL)IsGlobal{
    OrderSureViewController *orderSureVC = [[OrderSureViewController alloc]initWithOrderSuerStatus:OrderSuerStatusByCart ShopCarSureData:item andShopCartIdArr:arr];
    orderSureVC.hidesBottomBarWhenPushed = true;
    orderSureVC.isGlobal = IsGlobal;
    [self.navigationController pushViewController:orderSureVC animated:true];
    _showPriceFootView.gotoPayBtn.userInteractionEnabled = true;
}

-(BOOL)checkRefreshToken{
    if ([Utils getUserInfo].token.length > 0) {
        UserInfo *info = [Utils getUserInfo];
        NSDate *now = [NSDate date];
        NSInteger tmp = [now timeIntervalSinceDate:info.refreshTokenDate];
        if (tmp < (info.expiresIn.integerValue)/1000) {//还没过期了
            return true;
        }
    }
    return false;
}

- (UIImage *)photoBrowser:(MIPhotoBrowser *)photoBrowser placeholderImageForIndex:(NSInteger)index{
    
    return  self.bigImage;
}

@end
