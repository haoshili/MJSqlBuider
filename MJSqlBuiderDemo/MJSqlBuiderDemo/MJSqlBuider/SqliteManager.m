//
//  SqliteManager.m
//  MJSqlBuiderDemo
//
//  Created by Shengjun Hao on 2017/1/12.
//  Copyright © 2017年 spuxpu. All rights reserved.
//

#import "SqliteManager.h"
#import "FMDatabase.h"

@interface SqliteManager()

@property (nonatomic, strong) FMDatabase *db;

@end

@implementation SqliteManager

static id _instance;

+ (instancetype)shareIntance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (BOOL) openDB{
    
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    
    filePath = [filePath stringByAppendingPathComponent: @"ss.db"];
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath] == NO) {
        
        _db = [FMDatabase databaseWithPath:filePath];
        if ([_db open]) {
            NSLog(@"the database open success, enjoy it!");
        } else {
            NSLog(@"failed open the database!");
        }
    }else{
        NSLog(@"the database no found!");
    }
    
    return TRUE;
}

- (BOOL) closeDB{
    
    if([_db close]){
        NSLog(@"the database close success!");
        
    }else{
        NSLog(@"the database close error!");
    }
    return TRUE;
}

// update delete insert use this method
- (BOOL) updataSQL:(NSString *)updatasSQL{
    
    return [_db executeUpdate:updatasSQL];
}

// only use query
- (FMResultSet *) querySQL:(NSString *)querySQL{
    
    return [_db executeQuery:querySQL];
}

@end
