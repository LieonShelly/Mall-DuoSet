//
//  SearchPiazzaDataDB.m
//  DuoSet
//
//  Created by fanfans on 2017/5/26.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SearchPiazzaDataDB.h"
#import "FMDB.h"

@implementation SearchPiazzaDataDB{
    FMDatabase *_fmdb;
}

+ (SearchPiazzaDataDB *)shareManager{
    static SearchPiazzaDataDB *_dB = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_dB == nil) {
            _dB = [[SearchPiazzaDataDB alloc] init];
        }
    });
    return _dB;
}

- (id)init{
    self = [super init];
    if (self) {
        NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/SearchPiazzaData.db"];
        NSLog(@"打印数据库路径:%@",path);
        _fmdb = [[FMDatabase alloc] initWithPath:path];
        if ([_fmdb open]) {
            NSLog(@"打开数据库成功");
            NSString *sqlStr = @"CREATE TABLE IF NOT EXISTS t_SearchPiazzaData (name text PRIMARY KEY, obj_id text, create_time text);";
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
    NSString *sql = @"select * from t_SearchPiazzaData order by create_time desc limit 0, 10";
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
    NSString *sql = @"insert into t_SearchPiazzaData (obj_id,name,create_time) values (?,?,?)";
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

- (BOOL)deleteDataWithModel:(SearchData *)model{
    [_fmdb open];
    NSString *sql = @"delete from t_SearchPiazzaData where name = ?";
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

-(BOOL)deleteAllData{
    [_fmdb open];
    NSString *sqlstr = [NSString stringWithFormat:@"DELETE FROM t_SearchPiazzaData"];
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


@end
