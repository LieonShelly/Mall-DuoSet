//
//  DesignerDetailsController.m
//  DuoSet
//
//  Created by fanfans on 2017/3/21.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DesignerDetailsController.h"
#import "DesignerDetailsHeaderView.h"
#import "DesignerDetailsTipsCell.h"
#import "NoPassProductCell.h"
#import "DesignerProductListCell.h"
#import "DesignerProductData.h"
#import "NoPassProductData.h"
#import "DesignerData.h"
#import "DesignerUploadController.h"
#import "DesignerNoWorkCell.h"

@interface DesignerDetailsController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong) DesignerDetailsHeaderView *headerView;
@property(nonatomic,copy) NSString *designerid;
@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,assign) NSInteger page;
@property(nonatomic,assign) NSInteger limit;
@property(nonatomic,assign) NSInteger lastRequsetCount;
@property(nonatomic,strong) NSMutableArray *productArr;
@property(nonatomic,strong) NSMutableArray *noPassArr;
@property(nonatomic,strong) DesignerData *designerInfo;

@end

@implementation DesignerDetailsController

-(instancetype)initWithDesignerId:(NSString *)designerid{
    self = [super init];
    if (self) {
        _designerid = designerid;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设计师详情";
    _productArr = [NSMutableArray array];
    [self configUI];
    [self configData];
    _page = 0;
    _lastRequsetCount = 0;
    _limit = 10;
    [self configProductDatal:true showHud:true];
}

-(void)configData{
    [RequestManager requestWithMethod:GET WithUrlPath:[NSString stringWithFormat:@"designer/designer/%@",_designerid] params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"]isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"designer"] && [[objDic objectForKey:@"designer"]isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *designerDic = [objDic objectForKey:@"designer"];
                    _designerInfo = [DesignerData dataForDictionary:designerDic];
                    [_headerView setupInfoWithDesignerData:_designerInfo];
                }
                if ([objDic objectForKey:@"noPass"] && [[objDic objectForKey:@"noPass"]isKindOfClass:[NSArray class]]) {
                    _noPassArr = [NSMutableArray array];
                    NSArray *noPassArr = [objDic objectForKey:@"noPass"];
                    for (NSDictionary *d in noPassArr) {
                        NoPassProductData *item = [NoPassProductData dataForDictionary:d];
                        [_noPassArr addObject:item];
                    }
                    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)configProductDatal:(BOOL)clear showHud:(BOOL)showHud{
    NSString *urlStr = [NSString stringWithFormat:@"designer/works?page=%ld&lmiti=%ld&designerId=%ld",(long)_page,_limit,_designerid.integerValue];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if (clear) {
                _productArr = [NSMutableArray array];
            }
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSArray class]]) {
                NSArray *objectArr = [responseDic objectForKey:@"object"];
                for (NSDictionary *d in objectArr) {
                    DesignerProductData *item = [DesignerProductData dataForDictionary:d];
                    [_productArr addObject:item];
                }
                [_tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        //
    }];
}

-(void)configUI{
    self.view.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableView.showsVerticalScrollIndicator = false;
    [self.view addSubview:_tableView];
    _tableView.mj_header= [FFGifHeader headerWithRefreshingBlock:^{
        _page += 0;
        [self configProductDatal:true showHud:false];
    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (_lastRequsetCount < _limit) {
            [_tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        _page += 1;
        [self configProductDatal:false showHud:false];
    }];
    
    _headerView = [[DesignerDetailsHeaderView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(560.0))];
    __weak typeof(self) weakSelf = self;
    _headerView.likehandle = ^(UIButton *btn){
        [weakSelf topDesignerLikeWithBtn:btn];
    };
    _tableView.tableHeaderView = _headerView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _noPassArr.count == 0 ? 0 : _noPassArr.count + 1;
    }
    if (section == 1) {
        return 2;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *DesignerDetailsTipsCellID = @"DesignerDetailsTipsCellID";
            DesignerDetailsTipsCell * cell = [_tableView dequeueReusableCellWithIdentifier:DesignerDetailsTipsCellID];
            if (cell == nil) {
                cell = [[DesignerDetailsTipsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DesignerDetailsTipsCellID];
            }
            cell.tipsLable.text = @"未通过作品";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            static NSString *NoPassProductCellID = @"NoPassProductCellID";
            NoPassProductCell * cell = [_tableView dequeueReusableCellWithIdentifier:NoPassProductCellID];
            if (cell == nil) {
                cell = [[NoPassProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NoPassProductCellID];
            }
            NoPassProductData *item = _noPassArr[indexPath.row - 1];
            [cell setupInfoWithNoPassProductData:item];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            static NSString *DesignerDetailsTipsCellID = @"DesignerDetailsTipsCellID";
            DesignerDetailsTipsCell * cell = [_tableView dequeueReusableCellWithIdentifier:DesignerDetailsTipsCellID];
            if (cell == nil) {
                cell = [[DesignerDetailsTipsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DesignerDetailsTipsCellID];
            }
            cell.tipsLable.text = @"作品展示";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{//DesignerNoWorkCell
            if (_productArr.count == 0) {
                static NSString *DesignerNoWorkCellID = @"DesignerNoWorkCellID";
                DesignerNoWorkCell * cell = [_tableView dequeueReusableCellWithIdentifier:DesignerNoWorkCellID];
                if (cell == nil) {
                    cell = [[DesignerNoWorkCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DesignerNoWorkCellID];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            static NSString *DesignerProductListCellID = @"DesignerProductListCellID";
            DesignerProductListCell * cell = [_tableView dequeueReusableCellWithIdentifier:DesignerProductListCellID];
            if (cell == nil) {
                cell = [[DesignerProductListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DesignerProductListCellID];
            }
            [cell setupInfoWithDesignerProductDataArr:_productArr];
            __weak typeof(self) weakSelf = self;
            cell.detailsHandle = ^(NSInteger index){
                DesignerProductData *item = weakSelf.productArr[index];
                WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@designer/works/%@",BaseUrl,item.obj_id] NavTitle:@"" ShowRightBtn:true];
                webVC.hidesBottomBarWhenPushed = true;
                webVC.isFromDesignerDetails = true;
                webVC.designerProductData = item;
                [self.navigationController pushViewController:webVC animated:true];
                
            };
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return indexPath.row == 0 ? FitHeight(80.0) : FitHeight(190.0);
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return FitHeight(80.0);
        }else{
            if (_productArr.count > 0) {
                return FitHeight(430.0) * ((_productArr.count + 1) / 2) + FitHeight(90.0);
            }else{
                return FitHeight(400.0);
            }
        }
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row != 0) {
        NoPassProductData *item = _noPassArr[indexPath.row - 1];
        [RequestManager requestWithMethod:GET WithUrlPath:[NSString stringWithFormat:@"designer/works/%ld/detail",(long)item.objId.integerValue] params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *objDic = [responseDic objectForKey:@"object"];
                    NoPassProductData *noPassData = [NoPassProductData dataForDictionary:objDic];
                    DesignerUploadController *editProductVC = [[DesignerUploadController alloc]init];
                    editProductVC.hidesBottomBarWhenPushed = true;
                    editProductVC.isEdit = true;
                    editProductVC.objId = item.objId;
                    editProductVC.noPassData = noPassData;
                    editProductVC.editHanlde = ^(){
                        [self configData];
                    };
                    [self.navigationController pushViewController:editProductVC animated:true];
                }
            }
        } fail:^(NSError *error) {
            //
        }];
    }
}

-(void)topDesignerLikeWithBtn:(UIButton *)btn{
    if (btn.selected) {//取消点赞
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:_designerid forKey:@"id"];
        btn.userInteractionEnabled = false;
        [RequestManager requestWithMethod:POST WithUrlPath:@"designer/designer/collectCancel" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                btn.selected = false;
                btn.userInteractionEnabled = true;
                if ([responseDic objectForKey:@"object"]) {
                    NSString *str = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"object"]];
                    [btn setTitle:str forState:UIControlStateNormal];
                }
            }
        } fail:^(NSError *error) {
            //
        }];
    }else{//点赞
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:_designerid forKey:@"id"];
        btn.userInteractionEnabled = false;
        [RequestManager requestWithMethod:POST WithUrlPath:@"designer/designer/collect" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                btn.selected = true;
                btn.userInteractionEnabled = true;
                if ([responseDic objectForKey:@"object"]) {
                    NSString *str = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"object"]];
                    [btn setTitle:str forState:UIControlStateNormal];
                }
            }
        } fail:^(NSError *error) {
            //
        }];
    }
}

@end
