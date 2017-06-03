//
//  SQLBuider.h
//  MJSqlBuiderDemo
//
//  Created by Shengjun Hao on 2017/1/13.
//  Copyright © 2017年 spuxpu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QueryBuider.h"

@interface SQLBuider : NSObject


/**
 * 查询语句的编写
 */
+ (NSString *)mj_queryBuider:(void(^)(QueryBuider *operate))block;


/**
 * 更新语句
 */
+ (NSString *)mj_updateBuider:(void (^)(QueryBuider *operate))block;


/**
 * 插入语句
 */
+ (NSString *)mj_insertBuider:(void (^)(QueryBuider *operate))block;

@end
