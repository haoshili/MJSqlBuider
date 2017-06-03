//
//  SQLBuider.m
//
//  构建整体的查询语句
//
//  Created by Shengjun Hao on 2017/1/13.
//  Copyright © 2017年 spuxpu. All rights reserved.
//

#import "SQLBuider.h"
#import "QueryBuider.h"

@implementation SQLBuider


+ (NSString *)mj_queryBuider:(void (^)(QueryBuider *))block{

    // SELECT 列名称 FROM 表名称
    QueryBuider *operate = [[QueryBuider alloc] initWithOperateType: 0];
    block(operate);
    return operate.install;
}


+ (NSString *)mj_updateBuider:(void (^)(QueryBuider *))block{
    
    // UPDATE 表名称 SET 列名称 = 新值 WHERE 列名称 = 某值
    QueryBuider *operate = [[QueryBuider alloc] initWithOperateType:1];
    block(operate);
    return operate.install;
}

+ (NSString *)mj_insertBuider:(void (^)(QueryBuider *))block{
    
    // INSERT INTO table_name (列1, 列2,...) VALUES (值1, 值2,....)
    QueryBuider *operate = [[QueryBuider alloc] initWithOperateType:2];
    block(operate);
    return operate.install;
}

@end
