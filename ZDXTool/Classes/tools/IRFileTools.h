//
//  IRFileTools.h
//  ZLToolsDemo
//
//  Created by irisZL on 2017/9/27.
//  Copyright © 2017年 irisZL. All rights reserved.
//

/*
 文件管理类
 （1）获取Tmp文件夹的路径
 （2）获取Cache文件夹的路径
 （3）获取Documents文件夹的路径
 (4) 判断文件是否存在
 （5）根据文件路径删除文件
 
 */

#import <Foundation/Foundation.h>

@interface IRFileTools : NSObject

/**
 获取Tmp文件夹的路径
 */
+ (NSString *)getTmpFilePath;

/**
 获取Cache文件夹的路径
 */
+ (NSString *)getCacheFilePath;

/**
 获取Documents文件夹的路径
 */
+ (NSString *)getDocumentsFailePath;

/**
 判断文件是否存在
 */
+ (BOOL)isExistWithFile:(NSString *)filePath;

/**
 根据文件路径删除文件
 */
+ (BOOL)deleteTheFileWithFilePath:(NSString *)filepath;


@end
