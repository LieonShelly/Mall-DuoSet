//
//  SeckillListTableView.m
//  DuoSet
//
//  Created by fanfans on 2017/5/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SeckillListTableView.h"
#import "SeckillTableHeaderView.h"
#import "SeckillProductCell.h"

@interface SeckillListTableView()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic,strong) SeckillTableHeaderView *headerView;
@property(nonatomic,strong) NSMutableArray *itemArr;
@property(nonatomic,assign) NSInteger lastRequsetCount;
@property(nonatomic,strong) NSMutableArray *items;
@property(nonatomic,retain) dispatch_source_t timer;
@property(nonatomic,strong) RobSessionData *robSession;

@end

@implementation SeckillListTableView

+ (SeckillListTableView *)contentTableViewWithFrame:(CGRect)frame AndHeaderRefreshBlock:(void (^)())headerBlock footRefreshBlock:(void (^)())footBlock{
    SeckillListTableView *contentTV = [[SeckillListTableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    contentTV.backgroundColor = [UIColor clearColor];
    contentTV.dataSource = contentTV;
    contentTV.delegate = contentTV;
    contentTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTV.showsVerticalScrollIndicator = false;
    SeckillTableHeaderView *headerView = [[SeckillTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(370.0))];
    contentTV.tableHeaderView = headerView;
    contentTV.mj_header= [FFGifHeader headerWithRefreshingBlock:^{
        headerBlock();
    }];
    contentTV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        footBlock();
    }];
    return contentTV;
}

-(void)setupInfoWithTopBannerArr:(NSMutableArray *)topBannerArr{
    SeckillTableHeaderView *headerView = (SeckillTableHeaderView *)self.tableHeaderView;
    NSMutableArray *bannerPicArr = [NSMutableArray array];
    for (int i = 0 ; i < topBannerArr.count ; i++) {
        HomeTopBanner *banner = topBannerArr[i];
        [bannerPicArr addObject:banner.picture];
    }
    [headerView setupInfoWithImgVArr:bannerPicArr];
}

-(void)setupInfoWithRobSessionData:(RobSessionData *)robSession{
    _robSession = robSession;
    SeckillTableHeaderView *headerView = (SeckillTableHeaderView *)self.tableHeaderView;
    headerView.bannerHandle = ^(NSInteger index) {
        TableViewHeaderViewBannerBlock block = _bannerTapHandle;
        if (block) {
            block(index);
        }
    };
    [headerView setupInfoWithRobSessionData:robSession];
    if (robSession.countDown.length == 0) {
        return;
    }
    [self countDownWithFinishTimeStamp:robSession.countDown.longLongValue completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        if (day == 0 && hour == 0 && minute == 0 && second == 0) {
        }
        NSString *hourStr = @"";
        NSString *minuteStr = @"";
        NSString *secondStr = @"";
        if (hour<10) {
            hourStr = [NSString stringWithFormat:@"0%ld",(long)hour];
        }else{
            hourStr = [NSString stringWithFormat:@"%ld",(long)hour];
        }
        if (minute<10) {
            minuteStr = [NSString stringWithFormat:@"0%ld",(long)minute];
        }else{
            minuteStr = [NSString stringWithFormat:@"%ld",(long)minute];
        }
        if (second<10) {
            secondStr= [NSString stringWithFormat:@"0%ld",(long)second];
        }else{
            secondStr= [NSString stringWithFormat:@"%ld",(long)second];
        }
        if (day > 0) {
            hourStr = [NSString stringWithFormat:@"%ld",(long)hour + 24*day];
        }
        
        [headerView setupCutDownLableShowWithHouStr:hourStr minStr:minuteStr secStr:secondStr];
    }];
}

-(void)setupInfoWithRobSessionDataArr:(NSMutableArray *)items{

}

-(void)setupInfoWithRobProductDataArr:(NSMutableArray *)items{
    _items = items;
    [self reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FitHeight(276.0);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *SeckillProductCellID = @"SeckillProductCellID";
    SeckillProductCell * cell = [tableView dequeueReusableCellWithIdentifier:SeckillProductCellID];
    if (cell == nil) {
        cell = [[SeckillProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SeckillProductCellID];
    }
    cell.cellBtnActionHandle = ^{
        [self seckillProductCellBtnActionHandleWithNSIndexPath:indexPath];
    };
    RobProductData *item = _items[indexPath.row];
    [cell setupInfoWithRobProductData:item andRobSessionData:_robSession];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCellSeletcedBlock block = _cellSeletcedHandle;
    if (block) {
        block(indexPath);
    }
}

-(void)seckillProductCellBtnActionHandleWithNSIndexPath:(NSIndexPath *)indexPath{
    CellBtnActionBlock block = _btnAction;
    if (block) {
        block(indexPath.row);
    }
}

-(void)countDownWithFinishTimeStamp:(long long)finishTimeStamp completeBlock:(void (^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock{
    if (_timer == nil) {
        NSTimeInterval timeInterval = finishTimeStamp/1000;
        __block int timeout = timeInterval; //倒计时时间
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(0,0,0,0);
                    });
                }else{
                    int days = (int)(timeout/(3600*24));
                    int hours = (int)((timeout-days*24*3600)/3600);
                    int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    int second = timeout-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(days,hours,minute,second);
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }
}


@end
