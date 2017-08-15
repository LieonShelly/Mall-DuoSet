//
//  DBUtils.m
//  DuoSet
//
//  Created by fanfans on 2017/2/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ShopCartDB.h"
#import "FMDB.h"

@implementation ShopCartDB{
    FMDatabase *_fmdb;
}

#pragma mark - 单利、
/*
 
 ShopCartDB *dbManager = [ShopCartDB shareManager];
 ShopCarModel *item = [[ShopCarModel alloc]init];
 item.shopCartId = @"31";
 item.productId = @"300";
 item.smallImg = @"sududhksdjdjdjieidjdj.jpg";
 item.amount = @"2";
 item.price = @"99.8";
 item.productName = @"哈哈哈哈";
 //    [dbManager deleteDataWithModel:item];
 //    [dbManager deleteAll];
 
 NSArray *beforitems = [dbManager allData];
 NSLog(@"beforitems:%@",beforitems);
 
 
 //    [dbManager deleteAll];
 //
 //
 NSMutableArray *items = [NSMutableArray array];
 for (int i = 0; i < 5; i++) {
 ShopCarModel *item = [[ShopCarModel alloc]init];
 item.productId = [NSString stringWithFormat:@"%d",i + 10];
 item.smallImg = @"sududhksdjdjdjieidjdj.jpg";
 item.amount = @"2";
 item.price = @"99.8";
 item.productName = @"哈哈哈哈";
 [items addObject:item];
 [dbManager insertDataWithModel:item];
 }
 
 //    [dbManager deleteDataWithModels:items];
 
 
 //    [dbManager changeDataWithModel:item newStr:@"11"];
 
 
 NSArray *enditems = [dbManager allData];
 NSLog(@"enditems:%@",enditems);
 
 */



+ (ShopCartDB *)shareManager{
    static ShopCartDB *_dB = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_dB == nil) {
            _dB = [[ShopCartDB alloc] init];
        }
    });
    return _dB;
}

- (id)init{
    self = [super init];
    if (self) {
        NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/ShopCart.db"];
        NSLog(@"打印数据库路径:%@",path);
        _fmdb = [[FMDatabase alloc] initWithPath:path];
        if ([_fmdb open]) {
            NSLog(@"打开数据库成功");
            NSString *sqlStr = @"CREATE TABLE IF NOT EXISTS t_ShopCart (id integer PRIMARY KEY AUTOINCREMENT, productId text NOT NULL, smallImg text NOT NULL,price text NOT NULL,amount text NOT NULL,productName text NOT NULL);";
            BOOL isSuccess = [_fmdb executeUpdate:sqlStr];
            if (isSuccess) {
                NSLog(@"create Tabel Success");
            }else{
                NSLog(@"create Tabel Fail:%@",_fmdb.lastErrorMessage);
            }
            
        }else{
            NSLog(@"open Sqlite File");
        }
        
    }
    return self;
}

#pragma mark - 查询数据
- (BOOL)isExistsDataWithModel:(ShopCarModel *)model{
    NSString *sql = @"select productId from t_ShopCart where productId = ?";
    FMResultSet *set = [_fmdb executeQuery:sql,model.productId];
    return [set next];
}

#pragma mark - 插入数据
- (BOOL)insertDataWithModel:(ShopCarModel *)model{
    [_fmdb open];
    NSString *sql = @"insert into t_ShopCart (number,cover,price,count,productName) values (?,?,?,?,?)";
    BOOL isSuccess = [_fmdb executeUpdate:sql,model.productNumber,model.cover,model.price,model.count,model.productName];
    if (isSuccess) {
        NSLog(@"insert Success");
        [_fmdb close];
    }else{
        NSLog(@"insert Fail:%@",_fmdb.lastErrorMessage);
        [_fmdb close];
    }
    return isSuccess;
}

-(BOOL)insertDataWithShopCarModelItems:(NSArray *)items{
    [_fmdb open];
    [_fmdb beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for (ShopCarModel *item in items) {
            NSString *sql = @"insert into t_ShopCart (number,cover,price,count,productName) values (?,?,?,?,?)";
            BOOL isSuccess = [_fmdb executeUpdate:sql,item.productNumber,item.cover,item.price,item.count,item.productName];
            if (isSuccess) {
                NSLog(@"insert Success");
            }
        }
    } @catch (NSException *exception) {
        isRollBack = true;
        [_fmdb rollback];
        NSLog(@"insert Fail，rollback");
        return false;
    } @finally {
        [_fmdb commit];
        NSLog(@"insert Success，commit done");
        return true;
    }
}

#pragma mark - 删除数据
- (BOOL)deleteDataWithModel:(ShopCarModel *)model{
    [_fmdb open];
    NSString *sql = @"delete from t_ShopCart where productId = ?";
    BOOL isSuccess = [_fmdb executeUpdate:sql,model.productId];
    if (isSuccess) {
        NSLog(@"delete Success");
        [_fmdb close];
    }else{
        NSLog(@"delete Fail%@",_fmdb.lastErrorMessage);
        [_fmdb close];
    }
    return isSuccess;
}

-(BOOL)deleteDataWithModels:(NSArray *)items{
    [_fmdb open];
    [_fmdb beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for (ShopCarModel *item in items) {
            NSString *sql = @"delete from t_ShopCart where productId = ?";
            BOOL isSuccess = [_fmdb executeUpdate:sql,item.productId];
            if (isSuccess) {
                NSLog(@"delete Success");
            }
        }
    } @catch (NSException *exception) {
        isRollBack = true;
        [_fmdb rollback];
        NSLog(@"delete Fail，rollback");
        return false;
    } @finally {
        if (!isRollBack) {
            [_fmdb commit];
            NSLog(@"delete Success，commit done");
            return true;
        }
    }
}

- (BOOL)deleteAll{
    [_fmdb open];
    NSString *sqlstr = [NSString stringWithFormat:@"DELETE FROM t_ShopCart"];
    if (![_fmdb executeUpdate:sqlstr])
    {
        [_fmdb close];
        NSLog(@"delete table error!");
        return NO;
    }
    NSLog(@"delete table success!");
    [_fmdb close];
    return YES;
}

#pragma mark - 获取所有数据
- (NSArray *)allData{
    [_fmdb open];
    NSString *sql = @"select * from t_ShopCart";
    FMResultSet *set = [_fmdb executeQuery:sql];
    //装数据模型
    NSMutableArray *array = [NSMutableArray array];
    while ([set next]) {
        ShopCarModel *model = [[ShopCarModel alloc] init];
        model.cartId = [set stringForColumn:@"id"];
        model.productId = [set stringForColumn:@"productId"];
        model.cover = [set stringForColumn:@"smallImg"];
        model.price = [set stringForColumn:@"price"];
        model.count = [set stringForColumn:@"count"];
        model.productName = [set stringForColumn:@"productName"];
        [array addObject:model];
    }
    [_fmdb close];
    return array;
}

#pragma mark - 修改数据 修改库存
- (BOOL)changeDataWithModel:(ShopCarModel *)model newStr:(NSString *)str{
    [_fmdb open];
    NSString *sql = @"update t_ShopCart set amount = ? where id = ? ";
    BOOL isSuccess = [_fmdb executeUpdate:sql,str,model.cartId];
    if (isSuccess) {
        NSLog(@"modify Success");
    }else{
        NSLog(@"modify Fail:%@",_fmdb.lastErrorMessage);
    }
    [_fmdb close];
    return isSuccess;
}

@end
