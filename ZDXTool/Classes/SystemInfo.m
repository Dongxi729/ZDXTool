//
//  SystemInfo.m
//  YTONGAPP
//
//  Created by xutong on 2017/12/13.
//  Copyright © 2017年 etong. All rights reserved.
//  系统信息

#import "SystemInfo.h"
#import <UIKit/UIDevice.h>

@implementation SystemInfo

+ (NSString *)getAppVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)getPlatformName {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"DTPlatformName"];
}

+ (NSString *)getPlatformVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"DTPlatformVersion"];
}

+ (NSString *)getSystemVersion {
    return [UIDevice currentDevice].systemVersion;
}

+ (NSString *)getUUID {
    return [[UIDevice currentDevice] identifierForVendor].UUIDString;
}


@end
