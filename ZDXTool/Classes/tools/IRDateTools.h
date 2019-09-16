//
//  IRDateTools.h
//  ZLToolsDemo
//
//  Created by irisZL on 2017/9/18.
//  Copyright © 2017年 irisZL. All rights reserved.
//

/*
 
 dateFormatter: 日期转换  
 (1)时间转换成字符串的各类形式
 (2)字符串转换成时间的各类形式
 (3)判断两个时间之间的间隔
 (6）获取今天的日期，根据格式
 (7)时间格式的相互转换
 (8) 判断输入日期的有效性
 */


#import <Foundation/Foundation.h>

/**
 时间格式展示的类型，如果不满足可以自行增加,增加时需要在私有方法createDateFormatterForType中添加对应的实现
 */
typedef NS_ENUM(NSInteger , IRDateFormatterType) {
    
    //201611
    IRDateFormatterYearMonth= 0,
    
    //20161112
    IRDateFormatterYearMonthDay= 1,
    
    // 2016-11-13
    IRDateFormatterBarStyle = 2,
    
    // 16-11-12 12
    IRDateFormatterBarHourStyle = 3,
    
};


@interface IRDateTools : NSString

/**
 获取系统当前时间，返回一个字符串
 
 @param type  字符串样式类型
 @return 相应所需要的日期字符串
 */
+ (NSString *)getNowDateWithFormatterType:(IRDateFormatterType)type;

/**
 时间转换成字符串的各类形式
 
 @param date 传入的时间
 @param type 字符串样式类型
 @return 相应所需要的日期字符串
 */
+ (NSString *)getDateWithDate:(NSDate *)date formatterType:(IRDateFormatterType)type;


/**
 传字符串转换成时间的各类形式
 
 @param dateString 日期的String
 @param type 这个string的类别
 @return 对应时间的NSDate
 */
+ (NSDate *)getDateWithString:(NSString *)dateString formatterType:(IRDateFormatterType)type;


/**
 时间格式的相互转换
 
 @param dateString 原始时间类型的string
 @param type 原始类型
 @param newTpye 新类型
 @return 返回新的时间类型的字符串
 */
+ (NSString *)transformDate:(NSString *)dateString
        begainFormatterType:(IRDateFormatterType)type
            toFormatterType:(IRDateFormatterType)newTpye;



/**
 日期有效期判断
 
 @param string 日期
 @param stringType string的日期类型
 @return bool 值类型
 */
+ (BOOL)checkDateValid:(NSString *)string
                stringType:(IRDateFormatterType)stringType;


/**
 比较日期(跟当前日期进行比较)
 
 @param date 传入日期
 @param dateType date的日期类型
 @return 返回结果
 */
+ (NSComparisonResult)compareDate:(NSString *)date
                         dateType:(IRDateFormatterType)dateType;


/**
 比较两个日期
 
 @param beginDate 开始日期
 @param endDate 结束日期
 @return 返回结果
 
 */
+ (NSComparisonResult)compareDate:(NSString *)beginDate
                   beiginDateType:(IRDateFormatterType)beiginDateType
                          endDate:(NSString *)endDate
                      endDateType:(IRDateFormatterType)endDateType;


/**
 计算两个日期之间的天数 YYYY-MM-dd格式
 
 @param beginDate 开始日期
 @param endDate 结束日期
 @return 返回天数
 */
+ (NSInteger)calculateIntervalFromBeginDate:(NSString *)beginDate
                             beiginDateType:(IRDateFormatterType)beiginDateType
                                     toDate:(NSString *)endDate
                                endDateType:(IRDateFormatterType)endDateType;



@end
