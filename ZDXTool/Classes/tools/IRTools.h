//
//  IRTools.h
//  ZLToolsDemo
//
//  Created by irisZL on 2017/9/27.
//  Copyright © 2017年 irisZL. All rights reserved.
//

/*
 （1）MD5加密
 （2）base64转换
 (3) 判断字符串是否为手机号
 （4）判断字符串是否为邮箱
 （5）身份证号码的匹配
 （6）URL匹配
 （7）银行卡号的匹配
 (8) 判断一个对象是否为空(NSNull)  备注：这个做的必要性貌似没有，也可能是这种说法有问题
 (9) 根据身份证号识别性别
 (10) 获取当前屏幕的宽度
 （11）获取当前屏幕的高度
 （12）对URL进行Encode
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, IRGender) {
    IRGenderFemale, // 女性
    IRGenderMale,   // 男性
    IRGenderNone,   // 未知
};



@interface IRTools : NSObject

/**
 MD5加密
 加密某一个字符串
 */
+ (NSString *)MD5WithString:(NSString *)string;

/**
 base64编码 数据
 */
+ (NSString *)stringByEncodeData:(NSData *)data;

/**
 base64解码 数据
 */
+ (NSData *)decodeString:(NSString *)string;

/**
 判断字符串是否为手机号
 */
+ (BOOL)isAvailablePhone:(NSString *)phone;

/**
 判断字符串是否为邮箱
 */
+ (BOOL)isAvailableEmail:(NSString *)email;

/**
 判断字符串是否为标准URL
 */
+ (BOOL)isAvailableURL:(NSString *)URL;

/**
 银行卡号的匹配
 */
+ (BOOL)isAvailableBankcard:(NSString *)bankcard;

/**
 身份证号码的匹配
 */
+ (BOOL)isAvailableIDCard:(NSString *)idcard;

/**
 根据身份证号识别性别
 */
+ (IRGender)identifyGenderWithIDCard:(NSString *)idcard;

/**
 获取当前屏幕的宽度
 */
+ (CGFloat)getScreenWidth;

/**
 获取当前屏幕的高度
 */
+ (CGFloat)getScreenHeight;


/**
 对URL进行Encode
 */
+ (NSString *)encoderURLWithURLString:(NSString *)urlString;

@end
