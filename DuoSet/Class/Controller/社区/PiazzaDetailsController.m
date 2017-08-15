//
//  PiazzaDetailsController.m
//  DuoSet
//
//  Created by fanfans on 2017/5/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaDetailsController.h"
#import "PiazzaWebViewCell.h"
#import "PiazzaDetailsLikeAndClloctionCell.h"
#import "PiazzaDetailsUserCell.h"
#import "PiazzaDetailsCommentCell.h"
#import "PiazzaCommonTipsCell.h"
#import "ProductShowAllCommentCell.h"
#import "PiazzaDetailsCollectionViewCell.h"
#import "PiazzaCommentNewListController.h"
#import "PiazzaDetailsFootView.h"
#import "PiazzaInputView.h"
#import "LoginViewController.h"
#import "CustomNavController.h"
#import "PiazzaAllCommentListController.h"
#import "DetailWebCell.h"
#import "NavMoreActionView.h"
#import "PiazzaPublishController.h"
#import "ShareView.h"
#import "NewProductDetailsHeaderView.h"
#import "SingleProductNewController.h"
#import "UserPiazzaDetailsController.h"
//data
#import "PiazzaItemCollectAndLikeData.h"
#import "PiazzaItemCommentData.h"
#import "PiazzaItemData.h"

@interface PiazzaDetailsController ()<UITableViewDataSource,UITableViewDelegate,webHeightDelegate,DetailWebCellHeightDelegate>
//nav
@property(nonatomic,strong) UIImageView *navView;
@property(nonatomic,strong) UILabel *navLable;
@property(nonatomic,strong) UIButton *leftBtn;
@property(nonatomic,strong) UIView *navline;
@property(nonatomic,strong) UIButton *rightBtn;
//View
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,assign) CGFloat webCellHight;
@property(nonatomic,assign) CGFloat collectionViewHight;
@property(nonatomic,strong) PiazzaDetailsFootView *footView;
@property(nonatomic,strong) UIView *markView;
@property(nonatomic,strong) PiazzaInputView *inputView;
@property(nonatomic,strong) UIView *markMoreView;
@property(nonatomic,strong) NavMoreActionView *moreView;
@property(nonatomic,strong) UIView *markshareView;
@property(nonatomic,strong) ShareView *shareView;
@property(nonatomic,strong) NewProductDetailsHeaderView *headerView;
//Data
@property(nonatomic,copy)   NSString *communityId;
@property(nonatomic,strong) PiazzaItemCollectAndLikeData *collectAndLikeData;
@property(nonatomic,assign) NSInteger page;
@property(nonatomic,assign) NSInteger lastRequsetCount;
@property(nonatomic,strong) NSMutableArray<PiazzaItemCommentData *> *commentArr;
@property(nonatomic,strong) NSTimer *likeTimer;
@property(nonatomic,strong) NSMutableArray<PiazzaItemData *> *dataArr;

@end

@implementation PiazzaDetailsController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = false;
    [self getCommentData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = true;
}

-(instancetype)initWithCommunityId:(NSString *)communityId{
    self = [super init];
    if (self) {
        _communityId = communityId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _webCellHight = 0.0;
    _collectionViewHight = 1000.0;
    [self configUI];
    [self configNav];
    _page = 0;
    _lastRequsetCount = 0;
    [self configCollectAndLikeData];
    [self getOtherItem:true showHud:true];
}

-(void)dealloc{
    NSLog(@"dealloc");
}

#pragma mark - configDatas
-(void)configCollectAndLikeData{
    [RequestManager requestWithMethod:GET WithUrlPath:[NSString stringWithFormat:@"community/communityInfo/%@",_communityId] params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                _collectAndLikeData = [PiazzaItemCollectAndLikeData dataForDictionary:objDic];
                [_headerView setupinfoWithImgArr:_collectAndLikeData.communityPictureArr];
                [_footView setupInfoWithPiazzaItemCollectAndLikeData:_collectAndLikeData];
                [_tableView reloadData];
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

//相关帖子
-(void)getOtherItem:(BOOL)clear showHud:(BOOL)showHud{
    NSString *urlStr = [NSString stringWithFormat:@"community?page=%ld&limit=10&communityId=%@",(long)_page,_communityId];
    NSString *encodedString = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [RequestManager requestWithMethod:GET WithUrlPath:encodedString params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if (clear) {
                _dataArr = [NSMutableArray array];
            }
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objectDic = [responseDic objectForKey:@"object"];
                if ([objectDic objectForKey:@"newCommunitys"] && [[objectDic objectForKey:@"newCommunitys"] isKindOfClass:[NSArray class]]) {
                    NSArray *arr = [objectDic objectForKey:@"newCommunitys"];
                    _lastRequsetCount = arr.count;
                    for (NSDictionary *d in arr) {
                        PiazzaItemData *item = [PiazzaItemData dataForDictionary:d];
                        [_dataArr addObject:item];
                    }
                    [_tableView reloadData];
                }
            }
        }
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
    }];
}

//评论
-(void)getCommentData{
    _commentArr = [NSMutableArray array];
    [RequestManager requestWithMethod:GET WithUrlPath:[NSString stringWithFormat:@"community/%@/new-comment?page=0&limit=2",_communityId] params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"commentResponses"] && [[objDic objectForKey:@"commentResponses"] isKindOfClass:[NSArray class]]) {
                    NSArray *arr = [objDic objectForKey:@"commentResponses"];
                    for (NSDictionary *d in arr) {
                        PiazzaItemCommentData *item = [PiazzaItemCommentData dataForDictionary:d];
                        [_commentArr addObject:item];
                    }
                }
                [_tableView reloadData];
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

#pragma mark - configUI & configNav
-(void)configUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, mainScreenWidth, mainScreenHeight + 20 - 50) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableView.mj_header= [FFGifHeader headerWithRefreshingBlock:^{
        _page = 0;
        [self getOtherItem:true showHud:false];
    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (_lastRequsetCount < 10) {
            [_tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        _page += 1;
        [self getOtherItem:false showHud:false];
    }];
    [self.view addSubview:_tableView];
    
    _headerView = [[NewProductDetailsHeaderView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(750.0))];
    __weak typeof(self) weakSelf = self;
    _headerView.imgTapHandle = ^(NSInteger index) {
        [weakSelf scanPictures:weakSelf.collectAndLikeData.communityfullPictureArr andIndex:index];
    };
    _tableView.tableHeaderView = _headerView;
    
    _footView = [[PiazzaDetailsFootView alloc]initWithFrame:CGRectMake(0, mainScreenHeight - 50, mainScreenWidth, 50)];
    _footView.btnActionHandle = ^(UIButton *btn) {
        [weakSelf footViewButtonActionWithButton:btn];
    };
    [self.view addSubview:_footView];
}

-(void)configNav{
    _navView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 64)];
    _navView.image = [UIImage imageNamed:@"piazza_nav_bgImg"];
    _navView.userInteractionEnabled = true;
    _navView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    [self.view addSubview:_navView];
    
    _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    [_leftBtn setImage:[UIImage imageNamed:@"new_nav_arrow_white"] forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(progressLeftSignInButton) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_leftBtn];
    
    _navLable = [[UILabel alloc]initWithFrame:CGRectMake(44, 20, mainScreenWidth - 88, 44)];
    _navLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    _navLable.textColor = [UIColor whiteColor];
    _navLable.textAlignment = NSTextAlignmentCenter;
    _navLable.text = @"笔记详情";
    [_navView addSubview:_navLable];
    
    _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - 44, 20, 44, 44)];
    [_rightBtn setImage:[UIImage imageNamed:@"piazza_nav_more_whith"] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(progressRightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_rightBtn];
    
    _navline = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, mainScreenWidth, 0.5)];
    _navline.backgroundColor = [[UIColor colorFromHex:0xe4e4e4] colorWithAlphaComponent:0];
    [_navView addSubview:_navline];
    
    [self.view bringSubviewToFront:_navView];
}

#pragma marrk - UITableViewDataSource & UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_dataArr.count > 0) {
        return 3;
    }else{
        return 2;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    if (section == 1) {
        if (_commentArr.count == 1) {
            return 3;
        }
        if (_commentArr.count >= 2) {
            return 4;
        }
        return 0;
    }
    if (section == 2) {
        return 2;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *PiazzaWebViewCellID = @"PiazzaWebViewCellID";
            PiazzaWebViewCell * cell = [tableView dequeueReusableCellWithIdentifier:PiazzaWebViewCellID];
            if (cell == nil) {
                NSString *urlStr = [NSString stringWithFormat:@"%@community/%@/html",BaseUrl,_communityId];
                cell = [[PiazzaWebViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PiazzaWebViewCellID andwebUrl:urlStr];
            }
            NSString *urlStr = [NSString stringWithFormat:@"%@community/%@/html",BaseUrl,_communityId];
            [cell setupInfoWithUrlStr:urlStr];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor randomColor];
            return cell;
        }
        if (indexPath.row == 1) {
            static NSString *PiazzaDetailsLikeAndClloctionCellID = @"PiazzaDetailsLikeAndClloctionCellID";
            PiazzaDetailsLikeAndClloctionCell * cell = [tableView dequeueReusableCellWithIdentifier:PiazzaDetailsLikeAndClloctionCellID];
            if (cell == nil) {
                cell = [[PiazzaDetailsLikeAndClloctionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PiazzaDetailsLikeAndClloctionCellID];
            }
            if (_collectAndLikeData) {
                [cell setupInfoWithPiazzaItemCollectAndLikeData:_collectAndLikeData];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row == 2) {
            static NSString *PiazzaDetailsUserCellID = @"PiazzaDetailsUserCellID";
            PiazzaDetailsUserCell * cell = [tableView dequeueReusableCellWithIdentifier:PiazzaDetailsUserCellID];
            if (cell == nil) {
                cell = [[PiazzaDetailsUserCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PiazzaDetailsUserCellID];
            }
            if (_collectAndLikeData) {
                [cell setupInfoWithPiazzaItemCollectAndLikeData:_collectAndLikeData];
            }
            __weak typeof(self) weakSelf = self;
            cell.collectHandle = ^(UIButton *btn) {
                [weakSelf collectUserWithCollectBtn:btn];
            };
            cell.avatarHandle = ^{
                UserPiazzaDetailsController *userDetailsVC = [[UserPiazzaDetailsController alloc]initWithUserid:weakSelf.collectAndLikeData.userId];
                userDetailsVC.hidesBottomBarWhenPushed = true;
                userDetailsVC.likeHandle = ^(BOOL isLike) {
                    weakSelf.collectAndLikeData.concerns = isLike;
                    [cell setupInfoWithPiazzaItemCollectAndLikeData:weakSelf.collectAndLikeData];
                };
                [weakSelf.navigationController pushViewController:userDetailsVC animated:true];
            };
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            static NSString *PiazzaCommonTipsCellID = @"PiazzaCommonTipsCellID";
            PiazzaCommonTipsCell * cell = [tableView dequeueReusableCellWithIdentifier:PiazzaCommonTipsCellID];
            if (cell == nil) {
                cell = [[PiazzaCommonTipsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PiazzaCommonTipsCellID];
            }
            cell.tipsLable.text = @"评论";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row == _commentArr.count + 1) {
            static NSString *ProductShowAllCommentCellID = @"ProductShowAllCommentCellID";
            ProductShowAllCommentCell * cell = [_tableView dequeueReusableCellWithIdentifier:ProductShowAllCommentCellID];
            if (cell == nil) {
                cell = [[ProductShowAllCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ProductShowAllCommentCellID];
            }
            cell.showAllLable.text = @"查看全部评价";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        static NSString *PiazzaDetailsCommentCellID = @"PiazzaDetailsCommentCellID";
        PiazzaDetailsCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:PiazzaDetailsCommentCellID];
        if (cell == nil) {
            cell = [[PiazzaDetailsCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PiazzaDetailsCommentCellID];
        }
        PiazzaItemCommentData *item = _commentArr[indexPath.row - 1];
        [cell setUpInfoWithPiazzaItemCommentData:item];
        cell.replyBtnHandle = ^{
            [self replyCommentWithIndex:indexPath.row - 1];
        };
        cell.likeBtnHandle = ^(UIButton *btn) {
            [self handleLikeCommentWithIndex:indexPath andButton:btn];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            static NSString *PiazzaCommonTipsCellID = @"PiazzaCommonTipsCellID";
            PiazzaCommonTipsCell * cell = [tableView dequeueReusableCellWithIdentifier:PiazzaCommonTipsCellID];
            if (cell == nil) {
                cell = [[PiazzaCommonTipsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PiazzaCommonTipsCellID];
            }
            cell.tipsLable.text = @"相关笔记";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row == 1) {
            static NSString *PiazzaDetailsCollectionViewCellID = @"PiazzaDetailsCollectionViewCellID";
            PiazzaDetailsCollectionViewCell * cell = [tableView dequeueReusableCellWithIdentifier:PiazzaDetailsCollectionViewCellID];
            if (cell == nil) {
                cell = [[PiazzaDetailsCollectionViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PiazzaDetailsCollectionViewCellID];
            }
            cell.sizeBlock = ^(CGSize size) {
                _collectionViewHight = size.height;
                [_tableView reloadData];
            };
            cell.cellBlock = ^(NSInteger index) {
                [self handlePiazzaDataWithIndex:index];
            };
            cell.cellLikeBlock = ^(UIButton *btn, NSIndexPath *indexPath) {
                [self likeBtnActionHandleWithButton:btn andInexPath:indexPath];
            };
            [cell setupInfoWithPiazzaItemDataArr:_dataArr];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

-(void)handlePiazzaDataWithIndex:(NSInteger)index{
    PiazzaItemData *item = _dataArr[index];
    PiazzaDetailsController *detailsVc = [[PiazzaDetailsController alloc]initWithCommunityId:item.communityId];
    detailsVc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:detailsVc animated:true];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            return  _webCellHight;
        }
        if (indexPath.row == 1) {
            return  FitHeight(98.0);
        }
        if (indexPath.row == 2) {
            return  FitHeight(156.0);
        }
    }
    if (indexPath.section == 1) {
        if (_commentArr.count == 1) {
            if (indexPath.row == 0 || indexPath.row == 2) {
                return  FitHeight(80.0);
            }
            PiazzaItemCommentData *item = _commentArr[indexPath.row - 1];
            return item.cellHight;
        }
        if (_commentArr.count >= 2) {
            if (indexPath.row == 0 || indexPath.row == 3) {
                return  FitHeight(80.0);
            }
            PiazzaItemCommentData *item = _commentArr[indexPath.row - 1];
            return item.cellHight;
        }
        return 0;
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            return  FitHeight(80.0);
        }
        if (indexPath.row == 1) {
            return _collectionViewHight;
        }
    }
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == _commentArr.count + 1) {
        PiazzaAllCommentListController *listVC = [[PiazzaAllCommentListController alloc]initWithCommunityId:_communityId];
        listVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:listVC animated:true];
    }
}


#pragma marrk - web Hight back
-(void)countWebViewHeight:(CGFloat)height{
    _webCellHight = height;
    [_tableView reloadData];
}

-(void)tapWebViewImageProductNum:(NSString *)productNum{
    SingleProductNewController *singleVc = [[SingleProductNewController alloc]initWithProductId:productNum];
    singleVc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:singleVc animated:true];
}

#pragma mark - buttonAction
-(void)progressLeftSignInButton{
    [_markView removeFromSuperview];
    [_inputView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:true];
}

-(void)progressRightButtonAction{
    UserInfo *info = [Utils getUserInfo];
    if (![_collectAndLikeData.userId isEqualToString:info.userId]) {//别人
        [self shareThisItem];
    }else{//自己
        if (_markMoreView != nil) {
            _markMoreView.hidden = false;
        }else{
            _markMoreView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight)];
            _markMoreView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
            _markMoreView.userInteractionEnabled = true;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenMoreView)];
            [_markMoreView addGestureRecognizer:tap];
            [self.view addSubview:_markMoreView];
            _moreView = [[NavMoreActionView alloc]initWithFrame:CGRectMake(mainScreenWidth - FitWith(20) - FitWith(186.0), FitHeight(110.0), FitWith(186.0),FitHeight(320.0))];
            __weak typeof(self) weakSelf = self;
            _moreView.moreActionHanlde = ^(NSInteger index) {
                [weakSelf hiddenMoreView];
                if (index == 0) {
                    [weakSelf shareThisItem];
                    return ;
                }
                if (index == 1) {
                    [weakSelf editThisItem];
                    return ;
                }
                if (index == 2) {
                    [weakSelf deleteThisItem];
                    return ;
                }
            };
            [_markMoreView addSubview:_moreView];
        }
    }
}

-(void)hiddenMoreView{
    _markMoreView.hidden = true;
}

-(void)shareThisItem{
    if ( _markshareView != nil) {
        _markshareView.hidden = false;
    }else{
        self.view.userInteractionEnabled = true;
        _markshareView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight)];
        _markshareView.backgroundColor = [[UIColor colorFromHex:0x484848] colorWithAlphaComponent:0.45];
        [self.view addSubview:_markshareView];
        
        _markshareView.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenShareMarkView)];
        [_markshareView addGestureRecognizer:tap];
        
        [self.view bringSubviewToFront:_markshareView];
    }
    
    if (_shareView != nil) {
        _shareView.hidden = false;
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = _shareView.frame;
            frame.origin.y -= FitHeight(600.0);
            _shareView.frame = frame;
        }];
    }else{
        _shareView = [[ShareView alloc]initWithFrame:CGRectMake(0, mainScreenHeight, mainScreenWidth, FitHeight(600.0))];
        __weak typeof(self) weakSelf = self;
        _shareView.cancelHandle = ^(){
            [weakSelf hiddenShareMarkView];
        };
        _shareView.shareHandle = ^(NSInteger index){
            [weakSelf shareCotentWithIndex:index];
        };
        [self.view addSubview:_shareView];
        UITapGestureRecognizer *singinVieTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareViewTap)];
        [_shareView addGestureRecognizer:singinVieTap];
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = _shareView.frame;
            frame.origin.y -= FitHeight(600.0);
            _shareView.frame = frame;
        }];
    }
}

-(void)hiddenShareMarkView{
    _markshareView.hidden = true;
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _shareView.frame;
        frame.origin.y = mainScreenHeight;
        _shareView.frame = frame;
    }];
}

-(void)shareCotentWithIndex:(NSInteger)index{
    NSArray *imgArr = [NSArray arrayWithObjects:_collectAndLikeData.coverPic, nil];
    NSString *urlStr = [NSString stringWithFormat:@"%@community/%@/html?isShare=true",BaseUrl,_communityId];
    if (index == 5) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = urlStr;
        [self.view makeToast:@"已复制到剪贴板,快去分享给您的朋友吧"];
        return;
    }
    NSString *title =_collectAndLikeData.title;
    NSString *contenText = _collectAndLikeData.content;
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
    if (PlatformType == SSDKPlatformTypeSinaWeibo) {
        contenText = [NSString stringWithFormat:@"%@\n%@",title,urlStr];
    }
    [Utils sharePlateType:PlatformType ImageArray:imgArr contentText:contenText shareURL:urlStr shareTitle:title andViewController:self success:^(SSDKPlatformType plateType) {
    }];
}

-(void)shareViewTap{
    
}

//编辑
-(void)editThisItem{
    PiazzaPublishController *editVc = [[PiazzaPublishController alloc]initWithPiazzaItemId:_collectAndLikeData.communityId];
    editVc.hidesBottomBarWhenPushed = true;
    editVc.uploadSuccessHandle = ^{
        //
    };
    [self.navigationController pushViewController:editVc animated:true];
}

//删除
-(void)deleteThisItem{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定删除该笔记吗？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [RequestManager requestWithMethod:POST WithUrlPath:[NSString stringWithFormat:@"community/%@/delete",_collectAndLikeData.communityId] params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {//删除成功
                PiazzaDetailsDeletedBlock block = _deletedHandle;
                if (block) {
                    block(_collectAndLikeData.communityId);
                }
                [self.navigationController popViewControllerAnimated:true];
            }
        } fail:^(NSError *error) {
            //
        }];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:delete];
    [alert addAction:cancel];
    [self.navigationController presentViewController:alert animated:true completion:nil];
}


#pragma mark - scrollViewDidScroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    PiazzaWebViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.webView setNeedsLayout];
    UIColor *color = [[UIColor whiteColor] colorWithAlphaComponent:1];
    UIColor *textColor = [[UIColor colorFromHex:0x222222] colorWithAlphaComponent:1];
    CGFloat offset = scrollView.contentOffset.y;
    UIColor *lineColor = [[UIColor colorFromHex:0xe4e4e4] colorWithAlphaComponent:1];
    if (offset <= 0) {
        _navView.image = [UIImage imageNamed:@"home_nav_bgImage"];
        _navView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        _navLable.textColor = [UIColor clearColor];
        _navline.backgroundColor = [[UIColor colorFromHex:0xe4e4e4] colorWithAlphaComponent:0];
        [_leftBtn setImage:[UIImage imageNamed:@"new_nav_arrow_white"] forState:UIControlStateNormal];
        [_rightBtn setImage:[UIImage imageNamed:@"piazza_nav_more_whith"] forState:UIControlStateNormal];
    }else{
        _navView.image = nil;
        CGFloat alpha = 1 - ((100 - offset)/100);
        _navView.backgroundColor = [color colorWithAlphaComponent:alpha];
        _navline.backgroundColor = [[UIColor colorFromHex:0xe4e4e4] colorWithAlphaComponent:alpha];
        _navLable.textColor = [textColor colorWithAlphaComponent:alpha];
        _navline.backgroundColor = [lineColor colorWithAlphaComponent:alpha];
        [_leftBtn setImage:[UIImage imageNamed:@"new_nav_arrow_black"] forState:UIControlStateNormal];
        [_rightBtn setImage:[UIImage imageNamed:@"piazza_nav_more_black"] forState:UIControlStateNormal];
    }
}

#pragma mark - footViewButtonActionWithIndex
-(void)footViewButtonActionWithButton:(UIButton *)btn{
    if (![self checkLogin]) {
        [self userlogin];
        return;
    }
    if (btn.tag == 0) {
        [self handleLikeThisItemWithButton:btn];
        return;
    }
    if (btn.tag == 1) {
        [self commentTapAction];
        return;
    }
    if (btn.tag == 2) {
        [self handleCollectThisItemWithButton:btn];
        return;
    }
}

#pragma mark - 评论相关
-(void)commentTapAction{
    if (_markView != nil) {
        _markView.hidden = false;
    }else{
        _markView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight)];
        _markView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        _markView.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenInputView)];
        [_markView addGestureRecognizer:tap];
        [self.view addSubview:_markView];
    }
    if (_inputView != nil) {
        [UIView animateWithDuration:0.25 animations:^{
            [_inputView.inputTexeView becomeFirstResponder];
            CGRect frame = _inputView.frame;
            frame.origin.y = mainScreenHeight - 258 - FitHeight(340.0);
            _inputView.frame = frame;
        } completion:nil];
    }else{
        __weak typeof(self) weakSelf = self;
        _inputView = [[PiazzaInputView alloc]initWithFrame:CGRectMake(0, mainScreenHeight, mainScreenWidth, FitHeight(340.0))];
//        _inputView.inputTexeView.placeholder = @"点赞的都是套路，评论才是真爱";
        _inputView.btnActionHandle = ^(NSInteger index){
            [weakSelf inptViewBtnActionWithIndex:index];
        };
        [_markView addSubview:_inputView];
        [UIView animateWithDuration:0.25 animations:^{
            [_inputView.inputTexeView becomeFirstResponder];
            CGRect frame = _inputView.frame;
            frame.origin.y = mainScreenHeight - 258 - FitHeight(340.0);
            _inputView.frame = frame;
        } completion:nil];
    }
}

-(void)inptViewBtnActionWithIndex:(NSInteger)index{
    if (index == 0) {
        [self hiddenInputView];
    }
    if (index == 1) {//提交评论
        if (_inputView.inputTexeView.text == 0) {
            [[UIApplication sharedApplication].keyWindow makeToast:@"请输入评论内容"];
        }
        NSString *urlStr = @"";
        urlStr = [NSString stringWithFormat:@"community/%@/comment",_communityId];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:_inputView.inputTexeView.text forKey:@"content"];
        [params setObject:[NSNumber numberWithBool:false] forKey:@"isChildReply"];
        [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                _inputView.inputTexeView.text = @"";
                [self hiddenInputView];
                [self getCommentData];
                [self configCollectAndLikeData];
            }
        } fail:^(NSError *error) {
            //
        }];
    }
}

-(void)hiddenInputView{
    _markView.hidden = true;
    [UIView animateWithDuration:0.25 animations:^{
        [_inputView.inputTexeView resignFirstResponder];
        CGRect frame = _inputView.frame;
        frame.origin.y = mainScreenHeight;
        _inputView.frame = frame;
    } completion:nil];
}

#pragma mark - 帖子评论点赞
-(void)handleLikeCommentWithIndex:(NSIndexPath *)indexPath andButton:(UIButton *)btn{
    PiazzaItemCommentData *item = _commentArr[indexPath.row - 1];
    if (btn.selected) {
        btn.selected = false;
        NSString *newStr = [NSString stringWithFormat:@"%ld",item.likeCount.integerValue - 1];
        item.likeCount = newStr;
    }else{
        btn.selected = true;
        NSString *newStr = [NSString stringWithFormat:@"%ld",item.likeCount.integerValue + 1];
        item.likeCount = newStr;
    }
    item.liked = btn.selected;
    [self reloadCellWithIndexPath:indexPath];
    if (_likeTimer == nil) {
        _likeTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:false block:^(NSTimer * _Nonnull timer) {
            [self delayTimeWithHandleLikeThisCommentWithIndexPath:indexPath andButton:btn];
            [_likeTimer invalidate];
            _likeTimer = nil;
        }];
    }else{
        [_likeTimer invalidate];
        _likeTimer = nil;
        _likeTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:false block:^(NSTimer * _Nonnull timer) {
            [self delayTimeWithHandleLikeThisCommentWithIndexPath:indexPath andButton:btn];
            [_likeTimer invalidate];
            _likeTimer = nil;
        }];
    }
}

-(void)delayTimeWithHandleLikeThisCommentWithIndexPath:(NSIndexPath *)indexPath andButton:(UIButton *)btn{
    PiazzaItemCommentData *item = _commentArr[indexPath.row - 1];
    NSString *urlStr = @"";
    urlStr = [NSString stringWithFormat:@"community/comment/%@/like",item.communityCommentId];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithBool:btn.selected] forKey:@"likeComment"];
    [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            NSLog(@"操作成功");
        }
    } fail:^(NSError *error) {
        //
    }];
}

//刷新cell
-(void)reloadCellWithIndexPath:(NSIndexPath *)indexPath{
    PiazzaItemCommentData *item = _commentArr[indexPath.row - 1];
    PiazzaDetailsCommentCell * cell = [_tableView cellForRowAtIndexPath:indexPath];
    if (cell) {
        [cell setUpInfoWithPiazzaItemCommentData:item];
    }
}

#pragma mark - 推荐列表点赞 延迟操作
-(void)likeBtnActionHandleWithButton:(UIButton *)btn andInexPath:(NSIndexPath *)indexPath{
    if (![self checkLogin]) {
        [self userlogin];
        return;
    }
    PiazzaItemData *item = _dataArr[indexPath.row];
    item.isLike = true;
    NSString *urlStr = @"";
    urlStr = [NSString stringWithFormat:@"community/%@/like",item.communityId];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithBool:true] forKey:@"likeCommunity"];
    [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            NSLog(@"操作成功");
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)delayTimeWithLikeBtn:(UIButton *)btn AndIndexPath:(NSIndexPath *)indexPath{
    PiazzaItemData *item = _dataArr[indexPath.row];
    NSString *urlStr = @"";
    urlStr = [NSString stringWithFormat:@"community/%@/like",item.communityId];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithBool:btn.selected] forKey:@"likeCommunity"];
    [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            NSLog(@"操作成功");
        }
    } fail:^(NSError *error) {
        //
    }];
}


#pragma mark - 点赞帖子
-(void)handleLikeThisItemWithButton:(UIButton *)btn{
    if (btn.selected) {
        [MQToast showToast:@"您已经点过赞了" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
        return;
    }
    NSString *urlStr = @"";
    urlStr = [NSString stringWithFormat:@"community/%@/like",_communityId];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithBool:true] forKey:@"likeCommunity"];
    [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            NSLog(@"操作成功");
        }
    } fail:^(NSError *error) {
        //
    }];
    _collectAndLikeData.isLike = btn.selected;
    btn.selected = true;
    NSString *newStr = [NSString stringWithFormat:@"%ld",_collectAndLikeData.likeCount.integerValue + 1];
    _collectAndLikeData.likeCount = newStr;
    [btn setTitle:newStr forState:UIControlStateNormal];
    [self reloadCell];
    likeActionBlock block = _likeHandle;
    if (block) {
        block(true);
    }
}

-(void)reloadCell{
    PiazzaDetailsLikeAndClloctionCell * cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if (cell) {
        [cell setupInfoWithPiazzaItemCollectAndLikeData:_collectAndLikeData];
    }
}

-(void)delayTimeWithHandleLikeThisItemWithButton:(UIButton *)btn{
    NSString *urlStr = @"";
    urlStr = [NSString stringWithFormat:@"community/%@/like",_communityId];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithBool:btn.selected] forKey:@"likeCommunity"];
    [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            NSLog(@"操作成功");
        }
    } fail:^(NSError *error) {
        //
    }];
}

#pragma mark - 收藏帖子
-(void)handleCollectThisItemWithButton:(UIButton *)btn{
    if (btn.selected) {
        btn.selected = false;
        NSString *newStr = [NSString stringWithFormat:@"%ld",_collectAndLikeData.collectCount.integerValue - 1];
        [btn setTitle:newStr forState:UIControlStateNormal];
        _collectAndLikeData.collectCount = newStr;
        [self reloadCell];
    }else{
        btn.selected = true;
        NSString *newStr = [NSString stringWithFormat:@"%ld",_collectAndLikeData.collectCount.integerValue + 1];
        [btn setTitle:newStr forState:UIControlStateNormal];
        _collectAndLikeData.collectCount = newStr;
        [self reloadCell];
    }
    _collectAndLikeData.isCollect = btn.selected;
    if (underiOS10) {
        [self delayTimeWithHandleCollectThisItemWithButton:btn];
        return;
    }
    if (_likeTimer == nil) {
        _likeTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:false block:^(NSTimer * _Nonnull timer) {
            [self delayTimeWithHandleCollectThisItemWithButton:btn];
            [_likeTimer invalidate];
            _likeTimer = nil;
        }];
    }else{
        [_likeTimer invalidate];
        _likeTimer = nil;
        _likeTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:false block:^(NSTimer * _Nonnull timer) {
            [self delayTimeWithHandleCollectThisItemWithButton:btn];
            [_likeTimer invalidate];
            _likeTimer = nil;
        }];
    }
}

-(void)delayTimeWithHandleCollectThisItemWithButton:(UIButton *)btn{
    NSString *urlStr = @"";
    if (btn.selected) {
        urlStr = [NSString stringWithFormat:@"community/%@/collect/add",_communityId];
    }else{
        urlStr = [NSString stringWithFormat:@"community/%@/collect/remove",_communityId];
    }
    [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            NSLog(@"操作成功");
        }
    } fail:^(NSError *error) {
        //
    }];
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

#pragma mark - 回复单条评论
-(void)replyCommentWithIndex:(NSInteger)index{
    PiazzaItemCommentData *item = _commentArr[index];
    PiazzaCommentNewListController *listVc = [[PiazzaCommentNewListController alloc]initWithPiazzaItemCommentData:item];
    listVc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:listVc animated:true];
}

#pragma mark - 关注该帖子作者 延迟操作
-(void)collectUserWithCollectBtn:(UIButton *)btn{
    if (![self checkLogin]) {
        [self userlogin];
        return;
    }
    UserInfo *info = [Utils getUserInfo];
    if ([_collectAndLikeData.userId isEqualToString:info.userId]) {//是自己
        [MQToast showToast:@"自己不能关注自己哦~" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
        return;
    }
    btn.selected = !btn.selected;
    if (btn.selected) {
        btn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
    }else{
        btn.layer.borderColor = [UIColor mainColor].CGColor;
    }
    _collectAndLikeData.concerns = btn.selected;
    if (underiOS10) {
        [self delayTimeWithLikeBtn:btn];
        return;
    }
    if (_likeTimer == nil) {
        _likeTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:false block:^(NSTimer * _Nonnull timer) {
            [self delayTimeWithLikeBtn:btn];
            [_likeTimer invalidate];
            _likeTimer = nil;
        }];
    }else{
        [_likeTimer invalidate];
        _likeTimer = nil;
        _likeTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:false block:^(NSTimer * _Nonnull timer) {
            [self delayTimeWithLikeBtn:btn];
            [_likeTimer invalidate];
            _likeTimer = nil;
        }];
    }
}

-(void)delayTimeWithLikeBtn:(UIButton *)btn{
    NSString *urlStr = @"";
    if (btn.selected) {
        urlStr = [NSString stringWithFormat:@"community/%@/concerns/add",_collectAndLikeData.userId];
    }else{
        urlStr = [NSString stringWithFormat:@"community/%@/concerns/remove",_collectAndLikeData.userId];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            NSLog(@"操作成功");
        }
    } fail:^(NSError *error) {
        //
    }];
}

#pragma mark - 图片放大
-(void)scanPictures:(NSArray *)imgArr andIndex:(NSInteger)index{
    ScanPictureViewController *picVC = [[ScanPictureViewController alloc]initWithPhotosUrl:imgArr WithCurrentIndex:index];
    [self presentViewController:picVC animated:true completion:nil];
}

@end
