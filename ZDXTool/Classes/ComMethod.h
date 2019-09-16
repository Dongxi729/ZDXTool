//
//  ComMethod.h
//  xiamensanyuanOA
//
//  Created by Johnny on 15/11/11.
//  Copyright © 2015年 xingrong. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ComMethod : NSObject

//md5加密
+ (NSString *)md5:(NSString *)str;

//毫秒转时间
//+ (NSString *)dateWithMS:(long long)ms;
+ (NSString *)dateWithMS:(long long)ms withFormat:(NSString *)dateFormat;

+ (NSString *)dateWithMSHM:(long long)ms;

+ (NSString *)getTimeNow;

+ (NSString *)dateWithNYRSFM:(long long)ms;

+ (NSString *)getDate:(NSDate *)date;

+ (NSString *)getDateNY:(NSDate *)date;

+ (NSString *)getDateYYRSF:(NSDate *)date;

+ (NSString *)getDateYYRSFM:(NSDate *)date;

+ (NSString *)getDateSF:(NSDate *)date;

+ (NSInteger)getMonthWithDate:(NSDate *)date;

//毫秒转时间 年月日
+ (NSString *)dateWithMSNo:(long long)ms;

+ (NSDate *)dateWithDateMS:(long long)ms;

+ (NSString *)getVersion;

+ (NSInteger)getYearWithDate:(NSDate *)date;

+ (NSInteger)getWeekWithDate:(NSDate *)date;

+ (NSDate *)getLastWeekDate:(NSDate *)date;

+ (NSDate *)getNextWeekDate:(NSDate *)date;
//html字符串转换
+ (NSString *)removeHTML:(NSString *)html;

+ (NSString *)stringWithDate:(NSDate *)date;

+ (NSString *)stringByTrimming:(NSString *)string;

+ (double)getDayBetweenStartTime:(NSString *)start endTime:(NSString *)end ;

/**
 
 @return Wifi名
 
 */
+ (NSString *)getWifiName;

/**
 
 
 @return WiFiIP
 */
+ (NSString *) getWiFiIPAddress;

+ (NSDictionary *)getWifiInfo;


/**
 Dictionary转成JSONString
 
 @param dictionary 请求参数
 
 @return JSONString
 */
+ (NSString *)returnJSONStringWithDictionary:(NSDictionary *)dictionary;

/**
 计算文字高度
 
 @param str   文字
 @param font  文字字体
 @param width 文字显示宽
 
 @return 文字高度
 */
+ (CGFloat)contentLabelH:(NSString *)str andFont:(CGFloat)font andStrW:(float)width;

//获取 年
+ (NSString *)getDateYear:(NSDate *)date;

//获取 月
+ (NSString *)getDateMontn:(NSDate *)date;

+ (NSString *)getDateDay:(NSDate *)date;

+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

+ (int)compareNYRSFMOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

/**
 获取WifiBSSID
 
 @return 返回WifiBSSID
 */
+ (NSString *)getWifiBSSID;

/**
 *生成32为无序标示
 *
 *@return  32位无序标示
 */
+ (NSString *)createUuid;

/**
 JSON 转 字典
 
 @param jsonString 需要转化的JSON字符串
 @return 返回转好的字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

+ (UIViewController *)getCurrentVC;

/**
 获取当前日期
 */
+ (NSString *)getCurrentDate;

/// 去除空白和换行
+ (NSString *)removeSpaceAndNewline:(NSString *)str;

+ (UIViewController *)zdx_getCurrentViewController;

+ (BOOL)isDebug;

+ (NSString *)docPath;

/// 检测是否开启了手机代理(造成网络请求不安全)
+ (BOOL)getProxyStatus;

+ (NSString *)getUUID;

@end

