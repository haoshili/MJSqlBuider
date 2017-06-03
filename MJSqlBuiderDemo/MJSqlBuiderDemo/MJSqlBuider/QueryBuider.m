//
//  QueryBuider.m
//
//  查询语句构建 核心方法
//
//  Created by Shengjun Hao on 2017/1/13.
//  Copyright © 2017年 spuxpu. All rights reserved.
//

#import "QueryBuider.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface QueryBuider()

// 查询表单
@property (nonatomic, strong) NSArray *queryRowsData;

// 查询表单
@property (nonatomic, strong) NSString *queryTable;

// 查询数目
@property (nonatomic, strong) NSMutableString *countNumberQuery;

// 查询语句
@property (nonatomic, strong) NSString *queryName;
@property (nonatomic, strong) NSString *queryData;

// 查询语句集合
@property (nonatomic,strong) NSMutableArray *queryConditions;

// 更新字段集合
@property (nonatomic,strong) NSMutableArray *updateConditions;

// 插入的实体
@property (nonatomic,strong) NSArray *insertData;

// 插入内连接的表,及其字段
@property (nonatomic, strong) NSMutableString *innerJoinTable;

// 排序条件
@property (nonatomic, strong) NSString *orderCondition;

// 后边的字段 limit,offset.
@property (nonatomic, strong) NSMutableString *lastCondition;

@end

@implementation QueryBuider

int mOperateType;

- (id)initWithOperateType:(int)operateType {
    
    self = [super init];
    if (!self) return nil;
    mOperateType = operateType;
    self.queryConditions =NSMutableArray.new;
    self.updateConditions = NSMutableArray.new;
    self.innerJoinTable = [[NSMutableString alloc] init];
    self.lastCondition = [[NSMutableString alloc] init];
    return self;
}

- (NSString *)install{
    
    NSString * sql = [self joinSQl];
    return  sql;
}

/* 添加查询列 */
- (QueryBuider * (^)(NSArray *))queryRows {
    return ^id(NSArray *fromTable){
        
        self.queryRowsData = fromTable;
        return self;
    };
}

/* 添加表单 */
- (QueryBuider * (^)(NSString *))fromTable {
    return ^id(NSString *fromTable){
        
        self.queryTable = fromTable;
        return self;
    };
}

/* 插入数据 */
- (QueryBuider *(^)(NSArray *))insertDatas{
    return ^id(NSArray *datas){
        
        self.insertData = datas;
        return self;
    };
}

/* 查询数据条目 */
- (QueryBuider *(^)(NSString *))countNumber{
    return ^id(NSString *count){
        
        self.countNumberQuery = [[NSMutableString alloc]initWithString:@"order"];
        return self;
    };
}

/* 更新字段 */
- (QueryBuider * (^)(NSString *row,NSString *data))setUpdataRowAndData {
    return ^id(NSString *row,NSString *data){
        
        NSString * u = [[[row stringByAppendingString:@" = '"] stringByAppendingString:data] stringByAppendingString:@"'"];
        [self.updateConditions addObject: u ];
        return self;
    };
}


/* 查询标志 */
- (QueryBuider * (^)(NSString *))tagProperty {
    return ^id(NSString *tagProperty){
        
        self.queryName = tagProperty;
        return self;
    };
}

- (QueryBuider * (^)(NSString *))eq {
    return ^id(NSString *eq){
        
        self.queryData = [[@" = '" stringByAppendingString:eq] stringByAppendingString:@"'"];
        [self joinQueryData];
        return self;
    };
}

- (QueryBuider * (^)(NSString *))neq {
    return ^id(NSString *eq){
        
        self.queryData = [[@" != '" stringByAppendingString:eq] stringByAppendingString:@"'"];
        [self joinQueryData];
        return self;
    };
}

- (QueryBuider * (^)(NSString *))gt {
    return ^id(NSString *eq){
        
        self.queryData = [[@" > '" stringByAppendingString:eq] stringByAppendingString:@"'"];
        [self joinQueryData];
        return self;
    };
}

- (QueryBuider *(^)(NSString *))gte{
    return ^id(NSString *eq){
        
        self.queryData = [[@" >= '" stringByAppendingString:eq] stringByAppendingString:@"'"];
        [self joinQueryData];
        return self;
    };
}

- (QueryBuider *(^)(NSString *))lt{
    return ^id(NSString *eq){
        
        self.queryData = [[@" < '" stringByAppendingString:eq] stringByAppendingString:@"'"];
        [self joinQueryData];
        return self;
    };
}

- (QueryBuider *(^)(NSString *))lte{
    return ^id(NSString *eq){
        
        self.queryData = [[@" <= '" stringByAppendingString:eq] stringByAppendingString:@"'"];
        [self joinQueryData];
        return self;
    };
}

/* 限制查询数目 */
- (QueryBuider *(^)(NSString *))limit{
    return ^id(NSString *limit){
        
        [self.lastCondition appendString:@" limit "] ;
        [self.lastCondition appendString : limit];
        return self;
    };
}

/* 跳过条目 */
- (QueryBuider *(^)(NSString *))offset{
    return ^id(NSString *offset){
        
        [self.lastCondition appendString:@" offset "] ;
        [self.lastCondition appendString : offset];
        return self;
    };
}


//------------------------------------------条件查询--------------------------------------------------//

/* 插入内连接的表单 */
- (QueryBuider *(^)(NSString *))innerJoin{

    return ^id(NSString *innerJoinTableName){
        [ self.innerJoinTable appendString:@" inner join "];
        [self.innerJoinTable appendString:innerJoinTableName];
        [self.innerJoinTable appendString:@" "];
        return self;
    };
}

/* 连接字段 */
- (QueryBuider *(^)(NSString *rowOne, NSString *rowTwo))on{

    return ^id(NSString *rowOne,NSString *rowTwo){
        
        [self.innerJoinTable appendString:@" on "];
        NSString * u = [[[rowOne stringByAppendingString:@" = "] stringByAppendingString:rowTwo] stringByAppendingString:@""];
        [self.innerJoinTable appendString:u];
        return self;
    };
}

- (QueryBuider *(^)(NSString *))orderBy{

    return ^id(NSString *rowOne){
        self.orderCondition = [@" order by " stringByAppendingString:rowOne];
        return self;
    };
}

- (QueryBuider *(^)(NSString *))desOrderBy{

    return ^id(NSString *rowOne){
        self.orderCondition = [[@" order by " stringByAppendingString:rowOne] stringByAppendingString:@" desc"];
        return self;
    };
}


#pragma mark 使用的方法

/*  连接查询数据 */
- (void) joinQueryData{
    
    NSString * sql =  [self.queryName stringByAppendingString:self.queryData];
    if(_queryConditions.count != 0){
        [_queryConditions addObject:@" and "];
    }else{
        [_queryConditions addObject:@""];
    }
    [_queryConditions addObject:sql];
}

/* 连接查询语句 */
- (NSString *)joinSQl{
    
    NSString *sqlHead = [self getSqlHead];
    NSMutableString * sqlBody = [[NSMutableString alloc] init];
  
    // 存在查询字段
    if(_queryConditions.count != 0){
        [sqlBody appendString:@" where "];
        for (NSString  *mydictionary in _queryConditions) {
            [sqlBody appendString:mydictionary];
        }
    }
    
    // 不存在排序字段,
    if(self.orderCondition.length == 0){
        self.orderCondition = @"";
    }
    
    return [[[sqlHead stringByAppendingString:sqlBody] stringByAppendingString:self.orderCondition] stringByAppendingString:self.lastCondition];
}

/* 获取查询头语句 */
- (NSString *)getSqlHead{
    
    NSMutableString *sqlHead = [[NSMutableString alloc] init];
    if(mOperateType == 0){ // 查询
        
        return [self getQueryHead];
    }else if(mOperateType == 1){ // 更新
        
        [sqlHead appendString: [@"update " stringByAppendingString:_queryTable]];
        [sqlHead appendString: @" set "];
        
        for(int i = 0; i<_updateConditions.count;i++){
            [sqlHead appendString: _updateConditions[i]];
            if(i != _updateConditions.count-1){
                [sqlHead appendString:@", "];
            }
        }
    }else { // 插入
        
        [sqlHead appendString: [@"insert into " stringByAppendingString:_queryTable]];
        [sqlHead appendString:@" values ("];
        for(int i = 0; i<_insertData.count;i++){
        
            [sqlHead appendString:@" "];
            [sqlHead appendString:_insertData[i]];
            if(i != _insertData.count-1){
                [sqlHead appendString:@", "];
            }
        }
        [sqlHead appendString:@")"];
    }
    return sqlHead;
}

// 获取查询的头
- (NSString *) getQueryHead{

    NSMutableString *sqlHead = [[NSMutableString alloc] init];
    // 构建查询头的头
    
    if(self.countNumberQuery.length != 0){
        
        [sqlHead appendString:@"select count(*) as countNumber from "];
 
    }else if(_queryRowsData.count == 0){
        
         [sqlHead appendString: @"select * from "];
        
    }else{
        
        [sqlHead appendString:@"select "];
        for(int i = 0;i<_queryRowsData.count;i++){
            [sqlHead appendString:_queryRowsData[i]];
            if(i!= _queryRowsData.count-1){
                [sqlHead appendString:@", "];
            }
        }
        [sqlHead appendString:@" from "];
    }
    // 链表查询
    if(_innerJoinTable.length>0){
        [sqlHead appendString: _queryTable];
        [sqlHead appendString:_innerJoinTable];
        return sqlHead;
    }else{
        // 普通非链表查询
        [sqlHead appendString:_queryTable];
        return sqlHead;
    }
    return sqlHead;
}

@end
