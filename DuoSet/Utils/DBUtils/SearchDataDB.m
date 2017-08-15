//
//  SearchDataDB.m
//  DuoSet
//
//  Created by fanfans on 2017/3/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SearchDataDB.h"
#import "FMDB.h"

@implementation SearchDataDB{
    FMDatabase *_fmdb;
}

+ (SearchDataDB *)shareManager{
    static SearchDataDB *_dB = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_dB == nil) {
            _dB = [[SearchDataDB alloc] init];
        }
    });
    return _dB;
}

- (id)init{
    self = [super init];
    if (self) {
        NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/SearchData.db"];
        NSLog(@"打印数据库路径:%@",path);
        _fmdb = [[FMDatabase alloc] initWithPath:path];
        if ([_fmdb open]) {
            NSLog(@"打开数据库成功");
            NSString *sqlStr = @"CREATE TABLE IF NOT EXISTS t_SearchData (name text PRIMARY KEY, obj_id text, create_time text);";
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

- (NSArray *)allData{
    [_fmdb open];
    NSString *sql = @"select * from t_SearchData order by create_time desc limit 0, 10";
    FMResultSet *set = [_fmdb executeQuery:sql];
    //装数据模型
    NSMutableArray *array = [NSMutableArray array];
    while ([set next]) {
        SearchData *model = [[SearchData alloc] init];
        model.obj_id = [set stringForColumn:@"obj_id"];
        model.name = [set stringForColumn:@"name"];
        [array addObject:model];
    }
    [_fmdb close];
    return array;
}


- (BOOL)insertDataWithModel:(SearchData *)model{
    [_fmdb open];
    NSString *sql = @"insert into t_SearchData (obj_id,name,create_time) values (?,?,?)";
    BOOL isSuccess = [_fmdb executeUpdate:sql,model.obj_id,model.name,model.create_time];
    if (isSuccess) {
        NSLog(@"insert Success");
        [_fmdb close];
    }else{
        NSLog(@"insert Fail:%@",_fmdb.lastErrorMessage);
        [_fmdb close];
    }
    return isSuccess;
}

-(BOOL)deleteAllData{
    [_fmdb open];
    NSString *sqlstr = [NSString stringWithFormat:@"DELETE FROM t_SearchData"];
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

- (BOOL)deleteDataWithModel:(SearchData *)model{
    [_fmdb open];
    NSString *sql = @"delete from t_SearchData where name = ?";
    BOOL isSuccess = [_fmdb executeUpdate:sql,model.name];
    if (isSuccess) {
        NSLog(@"delete Success");
        [_fmdb close];
    }else{
        NSLog(@"delete Fail%@",_fmdb.lastErrorMessage);
        [_fmdb close];
    }
    return isSuccess;
}


@end
