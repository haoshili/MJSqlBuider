//
//  TransToEntity.m

//  将查询返回的结果集合转换成为实体类。
//  核心方法使用runtime技术
//
//  Created by Shengjun Hao on 2017/1/13.
//  Copyright © 2017年 spuxpu. All rights reserved.
//

#import "EntityManager.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import <Foundation/Foundation.h>
#import "objc/runtime.h"


@implementation EntityManager

+ (NSMutableArray *) getTypeEntityByResultSet:(FMResultSet *) rs :(Class)modelClass {
    
    NSMutableArray *tabel = [[NSMutableArray alloc] init];
    while ([rs next]) {
        [tabel addObject:[self getEntity:rs:modelClass]];
    }
    return tabel;
}

+ (id ) getEntity:(FMResultSet *) rs :(Class)modelClass{
    
    unsigned int outCount, i;
    objc_property_t *properties =class_copyPropertyList(modelClass, &outCount);
    id object = [[modelClass class] new];
    for (i = 0; i<outCount; i++){
        
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        
        const char* char_type =property_getAttributes(property);
        NSString *propertyType = [NSString stringWithUTF8String:char_type];
        
        if(![propertyType hasPrefix:@"Tq"]){// true is string
            NSString *value = [rs stringForColumn:propertyName];
            if(value != nil){
                [object setValue:value forKey:propertyName];
            }else{
                
                [object setValue:value forKey:propertyName];
            }
        }else{
            id values = [rs objectForColumnName:propertyName];
            if(values){
                if (![values isKindOfClass:[NSNull class]]) {
                    [object setValue:values forKey:propertyName];
                }
            }
        }
    }
    return object;
}

+ (NSMutableArray *)getInsertRowData:(NSObject *)typeModel{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    unsigned int outCount, i;
    objc_property_t *properties =class_copyPropertyList([typeModel class ], &outCount);
    for (i = 0; i<outCount; i++){
        
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [typeModel valueForKey:(NSString *)propertyName];
        if( [propertyValue isKindOfClass:[NSString class]]){
            [array addObject:[self getStringPatternByString:propertyValue]];
        }else{
            NSString *d = [NSString stringWithFormat:@"%ld",[propertyValue longValue]];
            [array addObject:d];
        }
    }
    free(properties);
    return array;
}

+ (NSString *)getStringPatternByString:(NSString *)str{
    return [[@"'" stringByAppendingString:str] stringByAppendingString:@"'"];
}

@end
