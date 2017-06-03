//
//  QueryBuider.h
//  MJSqlBuiderDemo
//
//  Created by Shengjun Hao on 2017/1/13.
//  Copyright © 2017年 spuxpu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QueryBuider : NSObject

- (id)initWithOperateType:( int)operateType;

- (NSString *)install;

- (QueryBuider * (^)(NSArray *))queryRows;

/* 查询数目 */
- (QueryBuider *(^)(NSString *))countNumber;

/* insert into table value 'a =123' */
- (QueryBuider * (^)(NSArray *))insertDatas;

/* select * from 'table' */
- (QueryBuider * (^)(NSString *))fromTable;

/* update 'set numberRow = '123'*/
- (QueryBuider * (^)(NSString *row,NSString *data))setUpdataRowAndData;

/* where 'xiaomi = || > || < 123' */
- (QueryBuider * (^)(NSString *))tagProperty;
- (QueryBuider * (^)(NSString *))eq;
- (QueryBuider * (^)(NSString *))neq;
- (QueryBuider * (^)(NSString *))gt;
- (QueryBuider * (^)(NSString *))lt;
- (QueryBuider * (^)(NSString *))lte;
- (QueryBuider * (^)(NSString *))gte;

/* inner join */
- (QueryBuider * (^)(NSString *))innerJoin;

/* on 'a = b' */
- (QueryBuider * (^)(NSString *rowOne,NSString *rowTwo))on;

/* orderBy */
- (QueryBuider * (^)(NSString *))orderBy;

/* orderBy desc */
- (QueryBuider * (^)(NSString *))desOrderBy;

/* limit 50 */
- (QueryBuider *(^)(NSString *))limit;

/* offset 50 */
- (QueryBuider *(^)(NSString *))offset;
@end
