//
//  IRDateTools.m
//  ZLToolsDemo
//
//  Created by irisZL on 2017/9/18.
//  Copyright © 2017年 irisZL. All rights reserved.
//

#import "IRDateTools.h"

// 因为创建NSDateFormatter开销大 所以创建为一个静态变量的形式
static NSDateFormatter *cachedDateFormatter = nil;

@implementation IRDateTools

/**
 获取系统当前时间，返回一个字符串
 
 @param type  字符串样式类型
 @return 相应所需要的日期字符串
 */
+ (NSString *)getNowDateWithFormatterType:(IRDateFormatterType)type
{
    NSDate *date = [NSDate date];
    return  [self getDateWithDate:date formatterType:type];
}


/**
 时间转换成字符串的各类形式
 
 @param date 传入的时间
 @param type 字符串样式类型
 @return 相应所需要的日期字符串
 */
+ (NSString *)getDateWithDate:(NSDate *)date formatterType:(IRDateFormatterType)type
{
    NSDateFormatter *fomatter = [self createDateFormatterForType:type];
    return date ? [fomatter stringFromDate:date] : @"";
    
}


/**
 传字符串转换成时间的各类形式
 
 @param dateString 日期的String
 @param type 这个string的类别
 @return 对应时间的NSDate
 */
+ (NSDate *)getDateWithString:(NSString *)dateString formatterType:(IRDateFormatterType)type
{
    NSDateFormatter *formatter = [self createDateFormatterForType:type];
    return [formatter dateFromString:dateString];
}


/**
 时间格式的相互转换
 
 @param dateString 原始时间类型的string
 @param type 原始类型
 @param newTpye 新类型
 @return 返回新的时间类型的字符串
 */
+ (NSString *)transformDate:(NSString *)dateString
        begainFormatterType:(IRDateFormatterType)type
            toFormatterType:(IRDateFormatterType)newTpye
{
    if (type != newTpye) {
        NSDate *date = [self getDateWithString:dateString formatterType:type];
        return [self getDateWithDate:date formatterType:newTpye];
    }
    else
    {
        return dateString;
    }
}


/**
 日期有效期判断
 
 @param string 日期
 @param stringType 类型
 @return bool 值类型
 */
+ (BOOL)checkDateValid:(NSString *)string
            stringType:(IRDateFormatterType)stringType
{
    NSString *newString = [self transformDate:string begainFormatterType:stringType toFormatterType:IRDateFormatterYearMonthDay];
    BOOL valid = NO;
    if (newString && newString.length > 0)
    {
        if ([newString hasPrefix:@"19"] || [newString hasPrefix:@"20"])
        {
            NSDateFormatter *dateFormatter = [self createDateFormatterForType:IRDateFormatterYearMonthDay];
            dateFormatter.locale = [NSLocale systemLocale];
            dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
            NSDate *date= [dateFormatter dateFromString:newString];
            if (date)
            {
                valid = YES;
            }
        }
    }
    return valid;
    
    
}


/**
 比较日期(跟当前日期进行比较)
 
 @param date 传入日期
 @param dateType date的日期类型
 @return 返回结果
 */
+ (NSComparisonResult)compareDate:(NSString *)date
                         dateType:(IRDateFormatterType)dateType
{
    NSString *newString = [self transformDate:date begainFormatterType:dateType toFormatterType:IRDateFormatterYearMonthDay];
    
    NSDateFormatter *dateFormatter = [self createDateFormatterForType:IRDateFormatterYearMonthDay];
    dateFormatter.locale = [NSLocale systemLocale];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    NSDate *start= [dateFormatter dateFromString:newString];
    NSDate *now = [NSDate date];
    return [start compare:now];
    
    
}

/**
 比较两个日期
 
 @param beginDate 开始日期
 @param endDate 结束日期
 @return 返回结果
 
 */
+ (NSComparisonResult)compareDate:(NSString *)beginDate
                   beiginDateType:(IRDateFormatterType)beiginDateType
                          endDate:(NSString *)endDate
                      endDateType:(IRDateFormatterType)endDateType
{
    NSString *beginString = [self transformDate:beginDate begainFormatterType:beiginDateType toFormatterType:IRDateFormatterYearMonthDay];
    NSString *endString = [self transformDate:endDate begainFormatterType:endDateType toFormatterType:IRDateFormatterYearMonthDay];
    
    
    NSDateFormatter *dateFormatter = [self createDateFormatterForType:IRDateFormatterYearMonthDay];
    dateFormatter.locale = [NSLocale systemLocale];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    NSDate *start= [dateFormatter dateFromString:beginString];
    NSDate *end = [dateFormatter dateFromString:endString];
    return [start compare:end];
    
}



/**
 计算两个日期之间的天数 YYYY-MM-dd格式
 
 @param beginDate 开始日期
 @param endDate 结束日期
 @return 返回天数
 */
+ (NSInteger)calculateIntervalFromBeginDate:(NSString *)beginDate
                             beiginDateType:(IRDateFormatterType)beiginDateType
                                     toDate:(NSString *)endDate
                                endDateType:(IRDateFormatterType)endDateType
{
    NSString *beiginString = [self transformDate:beginDate begainFormatterType:beiginDateType toFormatterType:IRDateFormatterBarStyle];
    NSString *endString = [self transformDate:endDate begainFormatterType:endDateType toFormatterType:IRDateFormatterBarStyle];
    
    NSInteger intervals = 0;
    if (beiginString && beiginString.length > 0 && endString && endString.length > 0)
    {
        //format日期
        NSDateFormatter *dateFormatter = [self createDateFormatterForType:IRDateFormatterBarStyle];
        dateFormatter.locale = [NSLocale systemLocale];
        NSDate *beginD = [dateFormatter dateFromString:beiginString];
        NSDate *endD = [dateFormatter dateFromString:endString];
        
        //用于记录两个日期的时间间隔（以秒为单位）
        NSInteger intervalInSecond = [endD timeIntervalSince1970] - [beginD timeIntervalSince1970];
        
        //当前日期大于规定的审核日期
        if (intervalInSecond > 0)
        {
            intervals = intervalInSecond/(60*60*24);
        }
        //当前日期小于规定的审核日期
        else
        {
            intervals = 0;
        }
    }
    else
    {
        intervals = 0;
    }
    return intervals;
    
}


#pragma mark - 私有方法
/**
 根据不同的类别创建NSDateFormatter
 
 @param type 传入的类别
 @return 返回的NSDateFormatter
 */
+ (NSDateFormatter *)createDateFormatterForType:(IRDateFormatterType)type
{
    if (!cachedDateFormatter) {
        cachedDateFormatter = [[NSDateFormatter alloc]init];
    }
    // 设置中国地区
    cachedDateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    // 设置默认系统时区
    cachedDateFormatter.timeZone = [NSTimeZone systemTimeZone];
    
    switch (type) {
        case IRDateFormatterYearMonth:
            cachedDateFormatter.dateFormat = @"yyyyMM";
            break;
        case IRDateFormatterYearMonthDay:
            cachedDateFormatter.dateFormat = @"yyyyMMdd";
            break;
        case IRDateFormatterBarStyle:
            cachedDateFormatter.dateFormat = @"yyyy-MM-dd";
            break;
        case IRDateFormatterBarHourStyle:
            cachedDateFormatter.dateFormat = @"yy-MM-dd HH";
            break;
            
        default:
            break;
    }
    return cachedDateFormatter;
}




@end
