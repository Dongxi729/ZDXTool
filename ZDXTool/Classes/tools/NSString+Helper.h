//
//  NSString+Helper.h
//  ZLToolsDemo
//
//  Created by irisZL on 2017/9/15.
//  Copyright © 2017年 irisZL. All rights reserved.
//

/*
 （1） 判断当前字符串是否为纯数字
 （2） 判断当前字符串是否为纯字母
 （3） 判断当前字符串是否符合某种规则
 （4） 判断当前字符串是否为空
 （5） 判断当前字符串是否有空格
 （6） 计算当前字符串的宽度
 （7） 删除字符串中的某些字符（比如空字符）(备注：单个字符可采用替换的方式进行，本方法针需要替换多个字符的情况)
 （8） 获取字符串的长度（区分中英文）N （备注：这个暂时觉得没有什么必要做）
 （9） 判断两个字符串的大小 N (备注：这个原本就有方法，所以不需要使用分类的方式进行重新写入)
 （10）判断两个纯数字字符串的大小
  (11) 校验字符串是否满足某个规则下的某个位数（大于，小于，等于）
 （12）将字符串反转
  (13) 字符串替换 (备注：字符串的替换系统有提供对应的方法，不需要再进行一次转调)
 （14）16进制转换成2进制
 （15）2进制转换成16进制
 （16）计算当前字符串的高度
 （17）计算当前字符串的宽高
 
 
 (18) 复制字符串
 
 */



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ComparSize) {
    ComparSizeMore, // 大于
    ComparSizeEqual, // 等于
    ComparSizeLess,  // 小于
};

@interface NSString (Helper)

#pragma mark - judgment 判断类
/**
 判断当前的字符串是否为纯数字
 */
- (BOOL)isDigital;

/**
 判断字符串是否为纯数字
 */
+ (BOOL)isDigtalWithString:(NSString *)string;

/**
 判断当前的字符串是否为纯字母
 */
- (BOOL)isLetter;

/**
 判断字符串是否为纯字母
 */
+ (BOOL)isLetterWithString:(NSString *)string;


/**
 判断当前字符串是否符合某种规则，规则必须使用正则表达式
 */
- (BOOL)isMeetTheRules:(NSString *)rules;

/**
 判断字符串是否符合某种规则，规则必须使用正则表达式
 */
+ (BOOL)isMeetTheRules:(NSString *)rules String:(NSString *)string;

/**
 判断当前字符串是否为空
 */
- (BOOL)isEmpty;

/**
 判断字符串是否为空
 */
+ (BOOL)isEmptyWithString:(NSString *)string;


/**
 判断当前字符串是否有空格
 */
- (BOOL)isContainsSpaces;

/**
 判断字符串是否有空格
 */
+ (BOOL)isContainsSpacesWithString:(NSString *)string;


/**
 比较当前纯数字字符串和另一个数字字符串的大小 (备注：这个地方必须保证两个字符串均为纯数字，若不为纯数字，则按照正常的比对方式进行比对即可)
 */
- (NSComparisonResult)compareWithOtherNumberString:(NSString *)numberString;

/**
 比较两个数字字符串的大小 (备注：这个地方必须保证两个字符串均为纯数字，若不为纯数字，则按照正常的比对方式进行比对即可)
 */
- (NSComparisonResult)compareNumberString:(NSString *)oneString  OtherNumberString:(NSString *)twoString;

/**
 校验当前字符串是否满足某个规则下的某个位数 (返回大于，小于，等于)
 */
- (BOOL)stringLength:(NSUInteger)length compare:(ComparSize)compareRule;

/**
 校验字符串是否满足某个规则下的某个位数 (返回大于，小于，等于)
 */
+ (BOOL)string:(NSString *)string
        length:(NSUInteger)length
       compare:(ComparSize)compareRule;


#pragma mark - change  转换类
/**
 删除当前字符串中的某些字符（比如空格）
 */
- (NSString *)deleteCharacters:(NSArray <NSString *>*)characters;

/**
 删除字符串中的某些字符（比如空格）
 */
+ (NSString *)deleteCharacters:(NSArray <NSString *>*)characters String:(NSString *)string;


/**
 将当前字符串反转
 */
- (NSString *)reversal;

/**
 将字符串反转
 */
+ (NSString *)stringReversalWithString:(NSString *)string;


/**
 将当前字符串由16进制转换成2进制
 */
- (NSData *)hexConversionToBinary;

/**
 将字符串由16进制转换成2进制
 */
+ (NSData *)hexConversionToBinaryWithString:(NSString *)string;


/**
 将当前字符串由2进制转换成16进制
 */
+ (NSString *)binaryConversionToHexWithData:(NSData *)data;




#pragma mark - calculation  计算类
/**
 计算当前字符串的宽度
 */
- (CGFloat)calculateWidthWithMaxHeight:(CGFloat)height font:(UIFont *)font;

/**
 计算字符串的高度
 */
+ (CGFloat)calculateWidthWithString:(NSString *)string
                          maxHeight:(CGFloat)height
                               font:(UIFont *)font;

/**
 计算当前字符串的高度
 */
- (CGFloat)calculateHeightWithMaxWidth:(CGFloat)width font:(UIFont *)font;

/**
 计算字符串的高度
 */
+ (CGFloat)calculateHeightWithString:(NSString *)string
                            maxWidth:(CGFloat)width
                                font:(UIFont *)font;


/**
 计算当前字符串的宽高
 */
- (CGSize)calculateSizeWithFont:(UIFont *)font;


/**
 计算字符串的宽高
 */
+ (CGSize)calculateSizeWithString:(NSString *)string
                             font:(UIFont *)font;

/**
 复制当前字符串
 */
- (void)paster;

/**
 复制字符串
 */
+ (void)pasterString:(NSString *)string;




@end
