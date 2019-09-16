//
//  SystemInfo.h
//  YTONGAPP
//
//  Created by xutong on 2017/12/13.
//  Copyright © 2017年 etong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemInfo : NSObject

+ (NSString *)getAppVersion;

+ (NSString *)getPlatformName;

+ (NSString *)getPlatformVersion;

+ (NSString *)getSystemVersion;

+ (NSString *)getUUID;

@end
