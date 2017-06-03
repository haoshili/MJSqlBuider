//
//  TransDatabaseFUtils.m
//  MJSqlBuiderDemo
//
//  Created by Shengjun Hao on 2017/3/22.
//  Copyright © 2017年 spuxpu. All rights reserved.
//

#import "TransDatabaseFUtils.h"


@implementation TransDatabaseFUtils

// 登陆成功之后，进行的数据库迁移
+ (void) transDatabase{
    
    NSLog (@"initializeDB");
    
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFolderPath = [searchPaths objectAtIndex: 0];
    
    //查看文件目录
    NSString *dbFilePath = [documentFolderPath stringByAppendingPathComponent:@"ss.db"]; // 当前是否存在这个数据库
    
     NSLog(@"%@",dbFilePath);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath: dbFilePath]) {
        [self backupDatabase:dbFilePath];
    }else{
        
        NSLog(@"The database exist");
 
    }
}

// 将工程里面文件迁移过去
+ (void) backupDatabase:(NSString *)dbFilePath{
    
    NSString *backupDbPath = [[NSBundle mainBundle] pathForResource:@"ss" ofType:@"db"];
    if (backupDbPath == nil) {
        NSLog(@"copy failed --- coun't find the origin copy");
    } else {
        BOOL copiedBackupDb = [[NSFileManager defaultManager] copyItemAtPath:backupDbPath toPath:dbFilePath error:nil];
        if (! copiedBackupDb) {
            NSLog(@"copy failed");
        }else{
            NSLog(@"copy to the database success");
            
        }
    }
}

// 对某一个文件重命名
+ (void) renameFileWithName:(NSString *)srcName toName:(NSString *)dstName{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *filePathSrc = [documentsDirectory stringByAppendingPathComponent:srcName];
    NSString *filePathDst = [documentsDirectory stringByAppendingPathComponent:dstName];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePathSrc]) {
        NSError *error = nil;
        [manager copyItemAtPath:filePathSrc toPath:filePathDst error:&error];
        if (error) {
            NSLog(@"There is an Error: %@", error);
        }else{
            NSLog(@"Success");
        }
    } else {
        NSLog(@"File origin %@ doesn't exists", srcName);
    }
}

+ (void) renameFileWithNameAndDeleteOrigin:(NSString *)srcName toName:(NSString *)dstName{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePathSrc = [documentsDirectory stringByAppendingPathComponent:srcName];
    NSString *filePathDst = [documentsDirectory stringByAppendingPathComponent:dstName];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePathSrc]) {
        NSError *error = nil;
        [manager moveItemAtPath:filePathSrc toPath:filePathDst error:&error];
        if (error) {
            NSLog(@"There is an Error: %@", error);
        }else{
            [self deleteFile:srcName];
        }
    } else {
        NSLog(@"File origin %@ doesn't exists", srcName);
    }
}

+ (Boolean) checkHasFile:(NSString *)fileName{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePathSrc = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager fileExistsAtPath:filePathSrc];
}

+ (void) deleteFile:(NSString *)fileNmae{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileNmae];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:filePath error:&error];
    if (success) {
        NSLog(@"Delete file success");
    }
    else{
        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
    }
}

@end
