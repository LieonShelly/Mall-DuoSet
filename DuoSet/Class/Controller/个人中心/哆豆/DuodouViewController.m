//
//  DuodouViewController.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/2.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "DuodouViewController.h"
#import "DuoDouData.h"

@interface DuodouViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UITableView *bgTableView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *tipsLable;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, copy) NSMutableArray *duodouDataArray;
@property (nonatomic, copy) NSString *douCount;


@end

@implementation DuodouViewController

-(instancetype)initWithDuoDouCount:(NSString *)douCount{
    self = [super init];
    if (self) {
        _douCount = douCount;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIImageView * navBackImgView = self.navigationController.navigationBar.subviews.firstObject;
    navBackImgView.alpha = 0;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    UIImageView * navBackImgView = self.navigationController.navigationBar.subviews.firstObject;
    navBackImgView.alpha = 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"哆豆";
    _headerView.backgroundColor = [UIColor colorFromHex:0xF98FB5];
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:_headerView.frame];
    imgV.image = [UIImage imageNamed:@"duodou_headerBg"];
    [_headerView addSubview:imgV];
    
    _bgTableView.tableFooterView = [UIView new];
    _bgTableView.rowHeight = 55;
    [self getDuodouData];
    [self initDataArray];
    
    [_headerView bringSubviewToFront:_countLabel];
    [_headerView bringSubviewToFront:_tipsLable];
}

- (void) initDataArray{
    _dataArray = [NSArray array];
    _duodouDataArray = [NSMutableArray array];
}
- (void) getDuodouData{
    NSUInteger customerId = 1;
    NSString *str = [NSString stringWithFormat:@"{\"customerId\":%ld}", customerId];
    NSDictionary *dict = @{@"data":str};
    [WebRequest webRequestWithURLGetMethod:DuoDou_List_Url params:dict success:^(id result) {
        NSLog(@"%@", result);
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSDictionary *jsonDic = result;
            if ([jsonDic objectForKey:@"records"] && [[jsonDic objectForKey:@"records"] isKindOfClass:[NSArray class]]) {
                NSArray *records = [jsonDic objectForKey:@"records"];
                _duodouDataArray = [NSMutableArray array];
                for (NSDictionary *d in records) {
                    DuoDouData *item = [DuoDouData dataForDictionary:d];
                    [_duodouDataArray addObject:item];
                }
                [_bgTableView reloadData];
            }
        }
        _countLabel.text = _douCount;
    } fail:^(NSString *result) {
        NSLog(@"%@", result);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return _duodouDataArray.count;
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0){
        cell.textLabel.font = [UIFont systemFontOfSize:13*AdapterWidth()];
        cell.textLabel.text = @"收支明细";
        return cell;
    }
//    DuoDouData *item = _duodouDataArray[indexPath.row];
//    cell.textLabel.font = [UIFont systemFontOfSize:13*AdapterWidth()];
//    cell.detailTextLabel.font = [UIFont systemFontOfSize:13*AdapterWidth()];
//    cell.textLabel.text = item.content;
//    cell.detailTextLabel.text = item.recordDate;
    cell.textLabel.font = [UIFont systemFontOfSize:13*AdapterWidth()];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13*AdapterWidth()];
    cell.textLabel.text = @"连续签到获得10哆豆";
    cell.detailTextLabel.text = @"2016-12-21";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
