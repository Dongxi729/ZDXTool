//
//  IRFileTools.m
//  ZLToolsDemo
//
//  Created by irisZL on 2017/9/27.
//  Copyright © 2017年 irisZL. All rights reserved.
//


#import "IRFileTools.h"

@implementation IRFileTools

/**
 获取Tmp文件夹的路径
 */
+ (NSString *)getTmpFilePath
{
    return NSTemporaryDirectory();
}

/**
 获取Cache文件夹的路径
 */
+ (NSString *)getCacheFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths firstObject];
}

/**
 获取Documents文件夹的路径
 */
+ (NSString *)getDocumentsFailePath
{
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths firstObject];
}

/**
 判断文件是否存在
 */
+ (BOOL)isExistWithFile:(NSString *)filePath
{
    if (filePath && filePath.length > 0) {
        
      return   [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    }
    else
    {
        return NO;
    }
}

/**
 根据文件路径删除文件
 */
+ (BOOL)deleteTheFileWithFilePath:(NSString *)filepath
{
    if (filepath && filepath.length > 0) {
        return [[NSFileManager defaultManager] removeItemAtPath:filepath error:nil];
    }
    else
    {   // 文件不存在的情况下不需要删除
        return YES;
    }
}

@end
