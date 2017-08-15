//
//  UserMessageTableViewController.m
//  DuoSet
//
//  Created by Seven-Augus on 2016/11/25.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "UserMessageTableViewController.h"

@interface UserMessageTableViewController ()
{
    NSArray *_userMessageTableViewDataSourceArray;
}

@end

@implementation UserMessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化数据
    [self initDataSource];
}

/**初始化数据*/
- (void)initDataSource
{
    _userMessageTableViewDataSourceArray = [[NSArray alloc] initWithObjects:@"头像", @"昵称", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 静态变量定义标识符
    NSString *cellID = [@"ClassificationViewControllerCellID" stringByAppendingString:[NSString stringWithFormat:@"%ld", indexPath.row]];
    
    // 通过标识符在队列中寻找可被重用的单元格
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        // 单元格右侧箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    // 文本标签
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.text = _userMessageTableViewDataSourceArray[indexPath.row];
    
    if (indexPath.row == 0) { // 用户头像
        UIImageView *userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(mainScreenWidth - 70 *AdapterWidth(), 6 *AdapterHeight(), 30 *AdapterWidth(), 30 *AdapterHeight())];
        userImageView.backgroundColor = [UIColor redColor];
        [cell.contentView addSubview:userImageView];
    } else if (indexPath.row == 1) { // 用户昵称
        UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(mainScreenWidth - 100 *AdapterWidth(), 6 *AdapterHeight(), 70 *AdapterWidth(), 30 *AdapterHeight())];
        userLabel.backgroundColor = [UIColor redColor];
        [cell.contentView addSubview:userLabel];
    }
    
    return cell;
}

@end
