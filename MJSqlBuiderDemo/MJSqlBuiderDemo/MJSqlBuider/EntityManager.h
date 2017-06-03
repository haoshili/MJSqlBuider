//
//  TransToEntity.h
//  MJSqlBuiderDemo
//
//  将查询返回的结果集合转换成为实体类。

//  Created by Shengjun Hao on 2017/1/13.
//  Copyright © 2017年 spuxpu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface EntityManager : NSObject

+ (NSMutableArray *) getTypeEntityByResultSet:(FMResultSet *) rs :(Class)modelClass;

+ (NSMutableArray *)getInsertRowData:(NSObject *)type;

@end
