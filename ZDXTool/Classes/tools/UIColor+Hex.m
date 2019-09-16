//
//  UIColor+Hex.m
//  ZLToolsDemo
//
//  Created by irisZL on 2017/9/15.
//  Copyright © 2017年 irisZL. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)UIColorFromHex:(NSUInteger)rgb alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0
                           green:((float)((rgb & 0xFF00) >> 8))/255.0
                            blue:((float)(rgb & 0xFF))/255.0
                           alpha:alpha];
}

+ (UIColor *)UIColorFromHex:(NSUInteger)rgb
{
    return [UIColor UIColorFromHex:rgb alpha:1.0];
}


+ (NSString *)HexFromUIColor:(UIColor *)color
{
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    
    
    
    
    return [NSString stringWithFormat:@"#%X%X%X",(int)((CGColorGetComponents(color.CGColor))[0] *255.0),
            (int)((CGColorGetComponents(color.CGColor))[1]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[2]*255.0)];
}

/*
 字符串的16进制转换成字符串
 **/
+ (UIColor *)UIColorFormHexString:(NSString *)hexString
{
    // 将字符串所表示的16进制转换为数字
    return [self UIColorFromHex:[self hexStringChangeToInteger:hexString]];
}


+ (NSUInteger)hexStringChangeToInteger:(NSString *)hexString
{
    NSString *changeHexString = hexString;
    if ([hexString rangeOfString:@"#"].location != NSNotFound) {
        
        changeHexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@"0x"];
        
    }
    unsigned long color = strtoul([changeHexString UTF8String], 0, 16);
    NSUInteger integer = (NSUInteger)color;
    return integer;
}

+ (NSString *)getRColorFromHex:(NSString *)hexString
{
    NSUInteger rgb = [self hexStringChangeToInteger:hexString];
    return [NSString stringWithFormat:@"%f", ((float)((rgb & 0xFF0000) >> 16))];
}

/*
 获取16进制中的G色
 **/
+ (NSString *)getGColorFromHex:(NSString *)hexString
{
    
    NSUInteger rgb = [self hexStringChangeToInteger:hexString];
    
    return [NSString stringWithFormat:@"%f",((float)((rgb & 0xFF00) >> 8))];
    
}

/*
 获取16进制中的B色
 **/
+ (NSString *)getBColorFromHex:(NSString *)hexString
{
    NSUInteger rgb = [self hexStringChangeToInteger:hexString];
    return [NSString stringWithFormat:@"%f", ((float)(rgb & 0xFF))];
    
}


@end
