//
//  ComMethod.m
//  xiamensanyuanOA
//
//  Created by Johnny on 15/11/11.
//  Copyright © 2015年 xingrong. All rights reserved.
//

#import "ComMethod.h"
#import <commoncrypto/CommonDigest.h>
#import <SystemConfiguration/CaptiveNetwork.h>
// 这写头文件是用于获取ip等系列功能的
#include <arpa/inet.h>
#include <netdb.h>
#include <net/if.h>
#include <ifaddrs.h>
#import <dlfcn.h>
//#import "wwanconnect.h"//frome apple 你可能没有哦
#import "Header.h"


#import <SystemConfiguration/SystemConfiguration.h>

@implementation ComMethod

+ (NSString *)md5:(NSString *)str {
    if (str) {
        const char *cStr = [str UTF8String];
        unsigned char result[32];
        CC_MD5( cStr, (unsigned int)strlen(cStr), result);
        return [NSString stringWithFormat:
                @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                result[0], result[1], result[2], result[3],
                result[4], result[5], result[6], result[7],
                result[8], result[9], result[10], result[11],
                result[12], result[13], result[14], result[15]
                ];
    }
    ZLOG(@"%@",str);
    
    return nil;
}

+ (NSString *)dateWithMS:(long long)ms withFormat:(NSString *)dateFormat {
    if (ms <= 0) {
        return @"";
    }
    
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:ms/1000.0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    dateFormatter.dateFormat = dateFormat;
    ZLOG(@"%@",[dateFormatter stringFromDate:date]);
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)dateWithMSHM:(long long)ms {
    if (ms <= 0) {
        return @"";
    }
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:ms/1000.0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    ZLOG(@"%@",[dateFormatter stringFromDate:date]);
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)dateWithNYRSFM:(long long)ms {
    if (ms <= 0) {
        return @"";
    }
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:ms/1000.0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    ZLOG(@"%@",[dateFormatter stringFromDate:date]);
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)getDate:(NSDate *)date {
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    //输出格式为：2010-10-27 10:22:13
    ZLOG(@"%@",currentDateStr);
    //alloc后对不使用的对象别忘了release
    
    return currentDateStr;
}

+ (NSString *)getDateNY:(NSDate *)date {
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    //输出格式为：2010-10-27 10:22:13
    ZLOG(@"%@",currentDateStr);
    //alloc后对不使用的对象别忘了release
    return currentDateStr;
}

+ (NSString *)getDateYYRSF:(NSDate *)date {
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    //输出格式为：2010-10-27 10:22:13
    ZLOG(@"%@",currentDateStr);
    //alloc后对不使用的对象别忘了release
    return currentDateStr;
}

+ (NSString *)getDateYYRSFM:(NSDate *)date {
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    //输出格式为：2010-10-27 10:22:13
    ZLOG(@"%@",currentDateStr);
    //alloc后对不使用的对象别忘了release
    return currentDateStr;
}

+ (NSString *)getDateSF:(NSDate *)date {
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"HH:mm"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    //输出格式为：2010-10-27 10:22:13
    ZLOG(@"%@",currentDateStr);
    //alloc后对不使用的对象别忘了release
    return currentDateStr;
}

+ (double)getDayBetweenStartTime:(NSString *)start endTime:(NSString *)end {
    long dayTime = 24*3600;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //用[NSDate date]可以获取系统当前时间
    NSDate *startDate = [dateFormatter dateFromString:start];
    NSDate *endDate = [dateFormatter dateFromString:end];
    double time = [endDate timeIntervalSinceDate:startDate];
    
    return time/dayTime +1;
}

+ (NSInteger)getMonthWithDate:(NSDate *)date {
    
    NSDate *currentDate = date;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday ;
    
    comps = [calendar components:unitFlags fromDate:currentDate];
    //    return [NSString stringWithFormat:@"%ld",[comps year]];
    //    month = [comps month];
    //    day = [comps day];
    return [comps month];
    
}

+ (NSString *)dateWithMSNo:(long long)ms {
    if (ms <= 0) {
        return @"";
    }
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:ms/1000.0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *)dateWithDateMS:(long long)ms {
    if (ms <= 0) {
        return nil;
    }
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:ms/1000.0];
    return date;
}

+ (NSString *)getTimeNow {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMddHHmmss";
    return [dateFormatter stringFromDate:[NSDate date]];
}

+ (NSString *)getVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

+ (NSInteger)getYearWithDate:(NSDate *)date {
    
    NSDate *currentDate = date;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitWeekday ;
    
    comps = [calendar components:unitFlags fromDate:currentDate];
    //    return [NSString stringWithFormat:@"%ld",[comps year]];
    //    month = [comps month];
    //    day = [comps day];
    return [comps year];
    
}

+ (NSInteger)getWeekWithDate:(NSDate *)date {
    
    NSDate *currentDate = date;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitWeekOfYear ;
    
    comps = [calendar components:unitFlags fromDate:currentDate];
    //    return [NSString stringWithFormat:@"%ld",[comps weekOfYear]];
    return [comps weekOfYear];
}

+ (NSDate *)getLastWeekDate:(NSDate *)date {
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *lastDate = [date dateByAddingTimeInterval:-7*secondsPerDay];
    return lastDate;
}

+ (NSDate *)getNextWeekDate:(NSDate *)date {
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *nextDate = [date dateByAddingTimeInterval:7*secondsPerDay];
    return nextDate;
}

+ (NSString *)removeHTML:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = @"";
    
    theScanner = [NSScanner scannerWithString:html];
    
    
    while ([theScanner isAtEnd] == NO) {
        
        // find start of tag
        
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        
        // find end of tag
        
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        // replace the found tag with a space
        
        //(you can filter multi-spaces out later if you wish)
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@" "];
        
        html = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
        
    }
    return html;
    
}

+ (NSString *)stringWithDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)stringByTrimming:(NSString *)string {
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}


+ (NSString *)getWifiName
{
    NSString *wifiName = nil;
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
    if (!wifiInterfaces) {
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            NSLog(@"network info -> %@", networkInfo);
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    return wifiName;
}

//获取WiFi 信息，返回的字典中包含了WiFi的名称、路由器的Mac地址、还有一个Data(转换成字符串打印出来是wifi名称)
+ (NSDictionary *)getWifiInfo {
    NSArray *ifs = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
    if (!ifs) {
        return nil;
    }
    
    NSDictionary *info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) { break; }
    }
    return info;
}


//这是获取本地wifi的ip地址

// Matt Brown's get WiFi IP addy solution
// Author gave permission to use in Cookbook under cookbook license
// http://mattbsoftware.blogspot.com/2009/04/how-to-get-ip-address-of-iphone-os-v221.html
+ (NSString *) getWiFiIPAddress
{
    BOOL success;
    struct ifaddrs * addrs;
    const struct ifaddrs * cursor;
    
    success = getifaddrs(&addrs) == 0;
    if (success) {
        cursor = addrs;
        while (cursor != NULL) {
            // the second test keeps from picking up the loopback address
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                if ([name isEqualToString:@"en0"])  // Wi-Fi adapter
                    return [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return nil;
}


#pragma mark Dictionary转成JSONString
+ (NSString *)returnJSONStringWithDictionary:(NSDictionary *)dictionary{
    
    NSString *jsonStr = @"{";
    if (dictionary.count) {
        NSArray * keys = [dictionary allKeys];
        for (NSString * key in keys) {
            jsonStr = [NSString stringWithFormat:@"%@\"%@\":\"%@\",",jsonStr,key,[dictionary objectForKey:key]];
        }
        jsonStr = [NSString stringWithFormat:@"%@%@",[jsonStr substringWithRange:NSMakeRange(0, jsonStr.length-1)],@"}"];
    }
    else{
        jsonStr = @"{}";
    }
    
    return jsonStr;
}

#pragma mark 计算文字高度
+ (CGFloat)contentLabelH:(NSString *)str andFont:(CGFloat)font andStrW:(float)width
{
    CGFloat contentLabelH;
    CGFloat h=[str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size.height;
    
    contentLabelH = h;
    return contentLabelH;
}

//获取 年月
+ (NSString *)getDateYear:(NSDate *)date {
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    //输出格式为：2010-10-27 10:22:13
    ZLOG(@"%@",currentDateStr);
    //alloc后对不使用的对象别忘了release
    return currentDateStr;
}

//获取 年月
+ (NSString *)getDateMontn:(NSDate *)date {
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    //输出格式为：2010-10-27 10:22:13
    ZLOG(@"%@",currentDateStr);
    //alloc后对不使用的对象别忘了release
    return currentDateStr;
}

//获取 年月
+ (NSString *)getDateDay:(NSDate *)date {
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"dd"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    //输出格式为：2010-10-27 10:22:13
    ZLOG(@"%@",currentDateStr);
    //alloc后对不使用的对象别忘了release
    return currentDateStr;
}

+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    ZLOG(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}

+ (int)compareNYRSFMOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}

+ (NSString *)getWifiBSSID {
    NSArray *ifs = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
    if (!ifs) {
        return nil;
    }
    
    NSDictionary *info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) { break; }
    }
    NSString *bssid = info[@"BSSID"];
    NSArray * subStr = [bssid componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@":-"]];
    NSMutableArray * subStr_M = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSString * str in subStr) {
        if (1 == str.length) {
            NSString * tmpStr = [NSString stringWithFormat:@"0%@", str];
            [subStr_M addObject:tmpStr];
        } else {
            [subStr_M addObject:str];
        }
    }
    NSString * formateMAC = [subStr_M componentsJoinedByString:@":"];
    ZLOG(@"%@",formateMAC);
    return formateMAC;
}

/**
 *生成32为无序标示
 *
 *@return  32位无序标示
 */
+(NSString*)createUuid
{
    char data[32];
    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    ZLOG(@"%@",[[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding]);
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
    
}

/**
 JSON 转 字典
 
 @param jsonString 需要转化的JSON字符串
 @return 返回转好的字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        ZLOG(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]){
        result = nextResponder;
    }else {
        result = window.rootViewController;
    }
    return result;
}

/**
 获取当前日期
 */
+ (NSString *)getCurrentDate {
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMddhhmmss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    ZLOG(@"%@",dateString);
    return dateString;
}

+ (NSString *)removeSpaceAndNewline:(NSString *)str {
    NSString *temp = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *text = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
    ZLOG(@"%@",text);
    return text;
}

+ (UIViewController *)zdx_getCurrentViewController {
    
    UIViewController* currentViewController = [self zdx_getRootViewController];
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
            
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                
                currentViewController = currentViewController.childViewControllers.lastObject;
                
                return currentViewController;
            } else {
                
                return currentViewController;
            }
        }
        
    }
    return currentViewController;
}

+ (UIViewController *)zdx_getRootViewController{
    
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    ZLOG(@"%@",window);
    return window.rootViewController;
}


+ (BOOL)isDebug {
#if DEBUG
    return YES;
#else
    return NO;
#endif
}

+ (NSString *)docPath {
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [paths lastObject];
    ZLOG(@"%@",docPath);
    return docPath;
}


+ (BOOL)getProxyStatus {
    NSDictionary *proxySettings =  (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"http://www.baidu.com"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    NSDictionary *settings = [proxies objectAtIndex:0];
    
    NSLog(@"host=%@", [settings objectForKey:(NSString *)kCFProxyHostNameKey]);
    NSLog(@"port=%@", [settings objectForKey:(NSString *)kCFProxyPortNumberKey]);
    NSLog(@"type=%@", [settings objectForKey:(NSString *)kCFProxyTypeKey]);
    
    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"]){
        //没有设置代理
        return NO;
    }else{
        //设置代理了
        return YES;
    }
}

+ (NSString *)getUUID {
    ZLOG(@"%@",[UIDevice currentDevice].identifierForVendor.UUIDString);
    //    NSLog(@"%@",[UIDevice currentDevice].identifierForVendor.UUIDString);
    return [UIDevice currentDevice].identifierForVendor.UUIDString;
}


@end

