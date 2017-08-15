//
//  SingleProductCommentListView.m
//  DuoSet
//
//  Created by fanfans on 2017/5/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SingleProductCommentListView.h"
#import "CommentCell.h"
#import "CommonDefeatedView.h"

@interface SingleProductCommentListView()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong) NSMutableArray *commentArr;
@property(nonatomic,strong) CommonDefeatedView *defeatedView;

@end

@implementation SingleProductCommentListView

-(instancetype)initWithFrame:(CGRect)frame AndHeaderRefreshBlock:(void (^)())headerBlock footRefreshBlock:(void (^)())footBlock{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight - 64 - 50)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.mj_header= [FFGifHeader headerWithRefreshingBlock:^{
            headerBlock();
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            footBlock();
        }];
        _headerView = [[CommentListHeaderView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(80.0))];
        __weak typeof(self) weakSelf = self;
        _tableView.tableHeaderView = _headerView;
        
        _headerView.btnActionHandle = ^(NSInteger index){
            CommentHeaderBtnActionBlock block = weakSelf.headerBtnHandle;
            if (block) {
                block(index);
            }
        };
        _tableView.tableFooterView = [[UIView alloc]init];
        [self addSubview:_tableView];
    }
    return self;
}

-(void)setupInfoWithCommentArr:(NSMutableArray *)commentArr{
    _commentArr = commentArr;
    [_tableView reloadData];
    if (commentArr.count == 0) {
        [self showDefeatedView:true];
    }else{
        [self showDefeatedView:false];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _commentArr == nil ? 0 : _commentArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentData *item = _commentArr[indexPath.section];
    NSString *CommentCellID = [NSString stringWithFormat:@"CommentCellID-%ld",item.pics.count];
    CommentCell * cell = [_tableView dequeueReusableCellWithIdentifier:CommentCellID];
    if (cell == nil) {
        cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommentCellID];
    }
    __weak typeof(self) weakSelf = self;
    cell.imgVTapActionHandle = ^(NSInteger index){
        ImageViewTapBlock block = weakSelf.imgVTapHandle;
        if (block) {
            block(item,index);
        }
    };
    cell.lickBtnActionHandle = ^(UIButton *btn){
        LikeButtonActionBlock block = weakSelf.likeBtnHandle;
        if (block) {
            block(indexPath,item,btn);
        }
    };
    if (item != nil) {
        [cell setupInfoWithCommentData:item];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentData *item = _commentArr[indexPath.section];
    return item.cellHight;
}

-(void)showDefeatedView:(BOOL)show{
    if (show) {
        if (_defeatedView == nil) {
            _defeatedView = [[CommonDefeatedView alloc]initWithFrame:CGRectMake(0, FitHeight(80.0), mainScreenWidth, mainScreenHeight - 64 - 50 - FitHeight(80.0)) andDefeatedImageName:@"defeated_no_comment" messageName:@"亲，暂时没有任何评价哦~" backBlockBtnName:@"" backBlock:^{
            }];
            [_tableView addSubview:_defeatedView];
        }
    }else{
        _defeatedView.hidden = true;
    }
}

- (void)dealloc{
    NSLog(@"dealloc - SingleProductCommentListView");
}

@end
