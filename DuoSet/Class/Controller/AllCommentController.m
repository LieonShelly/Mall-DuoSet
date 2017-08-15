//
//  AllCommentController.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/21.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "AllCommentController.h"
#import "CommentCell.h"

@interface AllCommentController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *bgTableView;
@property (nonatomic, copy) NSMutableArray *commentDataArray;
@end

@implementation AllCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    [self getAllCommentList];
}
- (void) getAllCommentList{
    _productId = 1;
    NSString *str = [NSString stringWithFormat:@"{\"productId\": %ld}", _productId];
    NSDictionary *dict = @{@"data":str};
    [WebRequest webRequestWithURLGetMethod:AllComment_Url params:dict success:^(id result) {
        NSLog(@"%@", result);
        if (!_commentDataArray) {
            _commentDataArray = [[NSMutableArray alloc] init];
        }
        [_commentDataArray removeAllObjects];
        [_commentDataArray addObjectsFromArray:result[@"discuss"]];
        [_bgTableView reloadData];
    } fail:^(NSString *result) {
        NSLog(@"%@", result);
    }];
    
}

- (void) creatUI{
    _bgTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStylePlain];
    
    [self.view addSubview:_bgTableView];
    [_bgTableView registerClass:[CommentCell class] forCellReuseIdentifier:@"cell"];
    
    _bgTableView.delegate = self;
    _bgTableView.dataSource = self;
    _bgTableView.rowHeight = 180;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _commentDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString *str = [NSString stringWithFormat:@"%@%@", Base_Img_Url, _commentDataArray[indexPath.row][@"customerHeadImg"]];
    NSString *imgStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [cell.iconImgView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:IMAGE_NAME(@"数据加载失败") options:0];
    
    cell.nameLabel.text = _commentDataArray[indexPath.row][@"customerNickname"];
    cell.commentLabel.text = _commentDataArray[indexPath.row][@"content"];
    cell.timeLabel.text = _commentDataArray[indexPath.row][@"discussDate"];
   
    NSArray *strArray = [_commentDataArray[indexPath.row][@"img"] componentsSeparatedByString:@","];
    NSString *str1 = [NSString stringWithFormat:@"%@%@", Base_Img_Url, strArray[0]];
    NSString *imgStr2 = [str1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [cell.coverImgView sd_setImageWithURL:[NSURL URLWithString:imgStr2] placeholderImage:IMAGE_NAME(@"数据加载失败") options:0];
    
    cell.gradeLabel1.text = [NSString stringWithFormat:@"产品评分: %@", _commentDataArray[indexPath.row][@"productScore"]];
    cell.gradeLabel2.text = [NSString stringWithFormat:@"物流评分: %@", _commentDataArray[indexPath.row][@"sendSpeedScore"]];
    
    
    
    
    
    
    
    return cell;
    
}

@end
