//
//  SqliteManager.h
//  MJSqlBuiderDemo
//
//  Created by Shengjun Hao on 2017/1/12.
//  Copyright © 2017年 spuxpu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface SqliteManager : NSObject

+ (instancetype)shareIntance;

- (BOOL)openDB;

- (BOOL)updataSQL:(NSString *)updatasSQL;

- (FMResultSet *)querySQL:(NSString *)querySQL;

- (BOOL)closeDB;

@end
