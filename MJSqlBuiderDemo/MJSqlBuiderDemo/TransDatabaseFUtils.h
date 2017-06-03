//
//  TransDatabaseFUtils.h
//  MJSqlBuiderDemo
//
//  Created by Shengjun Hao on 2017/3/22.
//  Copyright © 2017年 spuxpu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransDatabaseFUtils : NSObject

/* 迁移数据库 */
+ (void)transDatabase;

/* 重命名文件 */
+ (void)renameFileWithName:(NSString *)srcName toName:(NSString *)dstName;

/* 重命名文件 */
+ (void)renameFileWithNameAndDeleteOrigin:(NSString *)srcName toName:(NSString *)dstName;

/* 检查是否含有该文件 */
+ (Boolean) checkHasFile:(NSString *)fileName;

// 删除文件
+ (void) deleteFile:(NSString *)fileNmae;


@end
