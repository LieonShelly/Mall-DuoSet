//
//  SearchViewController.m
//  DuoSet
//
//  Created by Seven-Augus on 2016/11/23.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "SearchViewController.h"
#import "ScreenProductController.h"
#import "MKJTagViewTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "SearchHistoryCell.h"
#import "SearchData.h"
#import "SearchDataDB.h"

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate>
{
    UITableView *_tableView;
    UITableView *_correlationView;
}
@property (nonatomic, strong) ScreenProductController *searchVC;
@property (nonatomic, strong) UISearchController *searchController;
//nav
@property(nonatomic,strong) UIView *navView;
@property(nonatomic,strong) UIImageView *bgImgV;
@property(nonatomic,strong) UITextField *navInputTF;
@property(nonatomic,strong) UIButton *rightCancelBtn;
@property(nonatomic,strong) UIView *line;
//data
@property(nonatomic,strong) NSMutableArray *hotWords;
@property(nonatomic,strong) NSArray *historyArr;
@property(nonatomic,strong) SearchDataDB *dataDb;
@property(nonatomic,copy) NSString *hotStr;

@property(nonatomic,strong) NSMutableArray *correlationArr;

@end

static NSString *identyfy = @"MKJTagViewTableViewCell";

@implementation SearchViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataDb = [SearchDataDB shareManager];
    _historyArr = [_dataDb allData];
    [self configUI];
    [self configNav];
    _hotWords = [NSMutableArray array];
    _correlationArr = [NSMutableArray array];
    [self configData];
    
}

-(void)configData{
    [RequestManager requestWithMethod:GET WithUrlPath:@"product/keyword" params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] &&[[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]] ) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"hot"] && [[objDic objectForKey:@"hot"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *hotDic = [objDic objectForKey:@"hot"];
                    if ([hotDic objectForKey:@"word"]) {
                        _navInputTF.placeholder = [NSString stringWithFormat:@"%@",[hotDic objectForKey:@"word"]];
                        _hotStr = [NSString stringWithFormat:@"%@",[hotDic objectForKey:@"word"]];
                    }
                }
                if ([objDic objectForKey:@"list"] && [[objDic objectForKey:@"list"] isKindOfClass:[NSArray class]]) {
                    NSArray *listArr = [objDic objectForKey:@"list"];
                    for (NSDictionary *d in listArr) {
                        if ([d objectForKey:@"word"]) {
                            [_hotWords addObject:[NSString stringWithFormat:@"%@",[d objectForKey:@"word"]]];
                        }
                        [_tableView reloadData];
                    }
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)configUI{
    self.view.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, mainScreenWidth, mainScreenHeight - 44) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableView.showsVerticalScrollIndicator = false;
    [_tableView registerNib:[UINib nibWithNibName:identyfy bundle:nil] forCellReuseIdentifier:identyfy];
    [self.view addSubview:_tableView];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(90.0))];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *hotlabel = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(24.0), 0, mainScreenWidth - FitWith(24.0), FitHeight(90.0))];
    hotlabel.text = @"热搜";
    hotlabel.textColor = [UIColor colorFromHex:0x222222];
    hotlabel.font = CUSFONT(14);
    [headerView addSubview:hotlabel];
    _tableView.tableHeaderView = headerView;
    //联想搜索
    _correlationView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, mainScreenHeight - 64) style:UITableViewStylePlain];
    _correlationView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _correlationView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _correlationView.dataSource = self;
    _correlationView.delegate = self;
    _correlationView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _correlationView.showsVerticalScrollIndicator = false;
    [self.view addSubview:_correlationView];
    
    _correlationView.hidden = true;
}

-(void)configNav{
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 64)];
    _navView.backgroundColor = [UIColor colorFromHex:0xfafafa];
    [self.view addSubview:_navView];
    
    _bgImgV = [[UIImageView alloc]initWithFrame:CGRectMake(FitWith(24.0), 27, mainScreenWidth - FitWith(24.0) - 44, 26)];
    _bgImgV.image = [UIImage imageNamed:@"common_search_bg"];
    _bgImgV.contentMode = UIViewContentModeScaleAspectFill;
    _bgImgV.userInteractionEnabled = true;
    [_navView addSubview:_bgImgV];
    
    UIImageView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(FitWith(24.0), 5, 15, 15)];
    leftView.image = [UIImage imageNamed:@"home_nav_search"];
    leftView.contentMode = UIViewContentModeScaleAspectFill;
    [_bgImgV addSubview:leftView];
    
    _navInputTF = [[UITextField alloc]initWithFrame:CGRectMake(leftView.frame.origin.x + leftView.frame.size.width + FitWith(20.0), 0, FitWith(520.0), 26)];
    _navInputTF.font = CUSFONT(13);
    _navInputTF.textColor = [UIColor colorFromHex:0x222222];
    _navInputTF.tintColor = [UIColor mainColor];
    _navInputTF.returnKeyType = UIReturnKeySearch;
    _navInputTF.delegate = self;
    [_navInputTF becomeFirstResponder];
    [_navInputTF addTarget:self action:@selector(textFieldValueChange:) forControlEvents:UIControlEventEditingChanged];
    [_bgImgV addSubview:_navInputTF];
    
    _rightCancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth -44, 20, 44, 44)];
    _rightCancelBtn.titleLabel.font = CUSFONT(13);
    [_rightCancelBtn setTitleColor:[UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
    [_rightCancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_rightCancelBtn addTarget:self action:@selector(rightClearHandle) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_rightCancelBtn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, mainScreenWidth, 0.5)];
    line.backgroundColor = [UIColor colorFromHex:0xBABABA];
    [_navView addSubview:line];
}

#pragma mark - UiTableViewDaraSource & UItableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == _correlationView) {
        return 1;
    }
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _correlationView) {
        return _correlationArr.count;
    }
    if (section == 0) {
        return _hotWords.count == 0 ? 0 : 1;
    }
    if (section == 1) {
        return _historyArr.count == 0 ? 0 : _historyArr.count + 1;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _correlationView) {
        static NSString *correlationViewCellID = @"correlationViewCellID";
        SearchHistoryCell * cell = [tableView dequeueReusableCellWithIdentifier:correlationViewCellID];
        if (cell == nil) {
            cell = [[SearchHistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:correlationViewCellID];
        }
        SearchData *item = _correlationArr[indexPath.row];
        cell.titleLable.text = item.name;
        cell.titleLable.textColor = [UIColor colorFromHex:0x222222];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 0) {
        MKJTagViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identyfy forIndexPath:indexPath];
        [self configCell:cell indexpath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 1) {
        static NSString *SearchHistoryCellID = @"SearchHistoryCellID";
        SearchHistoryCell * cell = [tableView dequeueReusableCellWithIdentifier:SearchHistoryCellID];
        if (cell == nil) {
            cell = [[SearchHistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SearchHistoryCellID];
        }
        if (indexPath.row == 0 ) {
            cell.titleLable.text = @"历史搜索";
        }else{
            SearchData *item = _historyArr[indexPath.row - 1];
            cell.titleLable.text = item.name;
        }
        cell.titleLable.textColor = indexPath.row == 0 ? [UIColor colorFromHex:0x222222] : [UIColor colorFromHex:0x808080];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

- (void)configCell:(MKJTagViewTableViewCell *)cell indexpath:(NSIndexPath *)indexpath
{
    [cell.tagView removeAllTags];
    cell.tagView.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width;
    cell.tagView.padding = UIEdgeInsetsMake(5, FitWith(20), FitHeight(20), FitWith(20));
    cell.tagView.lineSpacing = 10;
    cell.tagView.interitemSpacing = FitWith(28.0);
    cell.tagView.singleLine = NO;
    NSMutableArray *nameArr = _hotWords;
    
    [nameArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SKTag *tag = [[SKTag alloc] initWithText:nameArr[idx]];
        tag.font = [UIFont systemFontOfSize:13];
        tag.textColor = [UIColor colorFromHex:0x222222];
        tag.bgColor =[UIColor colorFromHex:0xf2f2f2];
        tag.cornerRadius = 3;
        tag.enable = true;
        tag.padding = UIEdgeInsetsMake(5, 10, 5, 10);
        [cell.tagView addTag:tag];
    }];
    
    cell.tagView.didTapTagAtIndex = ^(NSUInteger index,UIButton *btn,NSArray *tagBtns)
    {
        NSLog(@"btn.title:%@",btn.titleLabel.text);
        SearchData *itme = [[SearchData alloc]init];
        itme.obj_id = @"-1";
        itme.name = btn.titleLabel.text;
        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
        NSString *create_time = [NSString stringWithFormat:@"%f",interval];
        itme.create_time = create_time;
        [_dataDb insertDataWithModel:itme];
        _historyArr = [_dataDb allData];
        [_tableView reloadData];
        ScreenProductController *listVC = [[ScreenProductController alloc]initWithScreenProductStyle:ClassficationType andKeyWords:btn.titleLabel.text];
        listVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:listVC animated:true];
    };
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _correlationView) {
        return FitHeight(100.0);
    }
    if (indexPath.section == 0) {
        return [tableView fd_heightForCellWithIdentifier:identyfy configuration:^(id cell) {
            [self configCell:cell indexpath:indexPath];
        }];
    }
    return FitHeight(100.0);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _correlationView) {//联想搜索
        SearchData *item = _correlationArr[indexPath.row];
        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
        NSString *create_time = [NSString stringWithFormat:@"%f",interval];
        item.create_time = create_time;
        [_dataDb insertDataWithModel:item];
        _historyArr = [_dataDb allData];
        [_tableView reloadData];
        ScreenProductController *listVC = [[ScreenProductController alloc]initWithScreenProductStyle:ClassficationType andItemId:item.obj_id];
        listVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:listVC animated:true];
    }
    if (tableView == _tableView) {//历史记录
        if (indexPath.section == 1 && indexPath.row != 0) {
            SearchData *item = _historyArr[indexPath.row - 1];
            if (item.obj_id.integerValue > 0) {//有ID传id
                ScreenProductController *listVC = [[ScreenProductController alloc]initWithScreenProductStyle:ClassficationType andItemId:item.obj_id];
                listVC.hidesBottomBarWhenPushed = true;
                [self.navigationController pushViewController:listVC animated:true];
            }else{//没ID传关键字
                ScreenProductController *listVC = [[ScreenProductController alloc]initWithScreenProductStyle:ClassficationType andKeyWords:item.name];
                listVC.hidesBottomBarWhenPushed = true;
                [self.navigationController pushViewController:listVC animated:true];
            }
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (tableView == _tableView) {
        if (section == 1) {
            if (_historyArr.count == 0) {
                return [[UIView alloc]initWithFrame:CGRectZero];
            }else{
                UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(210.0))];
                sectionView.backgroundColor = [UIColor whiteColor];
                UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(24.0), FitHeight(60.0), mainScreenWidth - FitWith(48.0), FitHeight(90.0))];
                deleteBtn.titleLabel.font = CUSFONT(12);
                deleteBtn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
                deleteBtn.layer.borderWidth = 0.5;
                deleteBtn.layer.cornerRadius = 3;
                deleteBtn.layer.masksToBounds = true;
                [deleteBtn setTitle:@"清空历史搜索" forState:UIControlStateNormal];
                [deleteBtn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
                [deleteBtn addTarget:self action:@selector(deleteAllHistoryData) forControlEvents:UIControlEventTouchUpInside];
                [sectionView addSubview:deleteBtn];
                return sectionView;
            }
        }
    }
    return [[UIView alloc]initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        if (_historyArr.count == 0) {
            return 0.1;
        }
        return FitHeight(210.0);
    }
    return 0.1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView == _tableView && indexPath.section == 1 && indexPath.row >= 1;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath {
    return @"删除";
}

//左滑点击事件
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        SearchData *item = _historyArr[indexPath.row - 1];
        [_dataDb deleteDataWithModel:item];
        _historyArr = [_dataDb allData];
        [_tableView reloadData];
    }
}

-(void)deleteAllHistoryData{
    [_dataDb deleteAllData];
    _historyArr = [_dataDb allData];
    [_tableView reloadData];
}

#pragma mark - textFiledDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    NSString *keyWords = textField.text.length > 0 ? textField.text : _hotStr;
        NSString *urlStr = [NSString stringWithFormat:@"product?page=0&limit=10&sortType=default&keywords=%@",keyWords];
        NSString *encodedString = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [RequestManager requestWithMethod:GET WithUrlPath:encodedString params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSArray class]]) {
                NSArray *objArr = [responseDic objectForKey:@"object"];
                if (objArr.count > 0) {
                    SearchData *itme = [[SearchData alloc]init];
                    itme.obj_id = @"-1";
                    itme.name = keyWords;
                    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
                    NSString *create_time = [NSString stringWithFormat:@"%f",interval];
                    itme.create_time = create_time;
                    [_dataDb insertDataWithModel:itme];
                    _historyArr = [_dataDb allData];
                    [_tableView reloadData];
                    //用关键字搜索
                }
            }
            ScreenProductController *listVC = [[ScreenProductController alloc]initWithScreenProductStyle:ClassficationType andKeyWords:keyWords];
            listVC.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:listVC animated:true];
        }
    } fail:^(NSError *error) {
        //
    }];
    return true;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return true;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return true;
}

-(void)textFieldValueChange:(UITextField *)textField{
    UITextRange *selectedRange = [textField markedTextRange];
    NSString * newText = [textField textInRange:selectedRange];
    if(newText.length<=0){
        [self dynmicSearchWithKeyWords:textField.text];
    }
}

#pragma mark - right Cancle
-(void)rightClearHandle{
    [self.navigationController popViewControllerAnimated:true];
}

-(void)dynmicSearchWithKeyWords:(NSString *)keyWords{
    if (keyWords.length >= 1) {
        NSString *str = @"product/related";
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:keyWords forKey:@"keywords"];
        [RequestManager requestWithMethod:POST WithUrlPath:str params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                _correlationArr = [NSMutableArray array];
                if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *objDic = [responseDic objectForKey:@"object"];
                    if ([objDic objectForKey:@"list"] && [[objDic objectForKey:@"list"] isKindOfClass:[NSArray class]] ) {
                        NSArray *listArr = [objDic objectForKey:@"list"];
                        for (NSDictionary *d in listArr) {
                            SearchData *item = [SearchData dataForDictionary:d];
                            [_correlationArr addObject:item];
                        }
                        if (_correlationArr.count > 0) {
                            _correlationView.hidden = false;
                        }else{
                            _correlationView.hidden = true;
                        }
                        [_correlationView reloadData];
                    }
                }
            }
        } fail:^(NSError *error) {
            //
        }];
    }else{
        _correlationArr = [NSMutableArray array];
        [_correlationView reloadData];
        _correlationView.hidden = true;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:true];
}

@end
