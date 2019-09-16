//
//  NSString+Helper.m
//  ZLToolsDemo
//
//  Created by irisZL on 2017/9/15.
//  Copyright © 2017年 irisZL. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)

#pragma mark - judgment 判断类
/**
 判断当前的字符串是否为纯数字
 */
- (BOOL)isDigital
{
    // 原理：去除字符串中的数字，如果去除之后还有其他的话，那这个字符串就不是一个纯数字的字符串
     NSString *string = [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if (string.length > 0) {
        return NO;
    }
    else
    {
        return YES;
    }
}


/**
 判断字符串是否为纯数字
 */
+ (BOOL)isDigtalWithString:(NSString *)string
{
    return [string isDigital];
}


/**
 判断当前的字符串是否为字母
 */
- (BOOL)isLetter
{
    // 原理：去除字符串中的字母，如果去除之后还有其他的话，那这个字符串就不是一个纯字母的字符串
    NSString *string = [self stringByTrimmingCharactersInSet:[NSCharacterSet letterCharacterSet]];
    if (string.length > 0) {
        return NO;
    }
    else
    {
        return YES;
    }
}


/**
 判断字符串是否为纯数字
 */
+ (BOOL)isLetterWithString:(NSString *)string
{
    return [string isLetter];
}


/**
 判断当前字符串是否符合某种规则，规则必须使用正则表达式
 */
- (BOOL)isMeetTheRules:(NSString *)rules
{
    if (rules && rules.length > 0) {
        
        NSPredicate *numbertest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",rules];
        return [numbertest evaluateWithObject:self];
    }
    return NO;
}

/**
 判断字符串是否符合某种规则，规则必须使用正则表达式
 */
+ (BOOL)isMeetTheRules:(NSString *)rules String:(NSString *)string
{
    return [string isMeetTheRules:rules];
}

/**
 判断当前字符串是否为nil
 */
- (BOOL)isEmpty
{
    // 原理：本身是nil，或者根本不是NSString类型，或者仅含有空格符或转折符号的
    if(self == nil)
    {
        return YES;
    }
    if([self isKindOfClass:[NSString class]] == NO)
    {
        return YES;
    }
    
    return [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""];
}

/**
 判断字符串是否为nil
 */
+ (BOOL)isEmptyWithString:(NSString *)string
{
    return [string isEmpty];
}


/**
 判断当前字符串是否有空格
 */
- (BOOL)isContainsSpaces
{
    if ([self rangeOfString:@" "].location != NSNotFound) {
        return YES;
    }
    return NO;
}

/**
 判断字符串是否有空格
 */
+ (BOOL)isContainsSpacesWithString:(NSString *)string
{
    return [string isContainsSpaces];
}

/**
 比较当前纯数字字符串和另一个数字字符串的大小 (备注：这个地方必须保证两个字符串均为纯数字，若不为纯数字，则按照正常的比对方式进行比对即可)
 */
- (NSComparisonResult)compareWithOtherNumberString:(NSString *)numberString
{
    if (![self isDigital] || ![numberString isDigital]) {
        return [self compare:numberString];
    }
    
    
    NSUInteger number1 = [self integerValue];
    NSUInteger number2 = [numberString integerValue];
    if (number1 > number2) {
        return NSOrderedDescending;
    }
    else if (number1 == number2)
    {
        return NSOrderedSame;
    }
    else
    {
        return NSOrderedAscending;
    }
}

/**
 比较两个数字字符串的大小 (备注：这个地方必须保证两个字符串均为纯数字，若不为纯数字，则按照正常的比对方式进行比对即可)
 */
- (NSComparisonResult)compareNumberString:(NSString *)oneString  OtherNumberString:(NSString *)twoString
{
    return [oneString compareWithOtherNumberString:twoString];
}

/**
 校验当前字符串是否满足某个规则下的某个位数 (返回大于，小于，等于)
 */
- (BOOL)stringLength:(NSUInteger)length compare:(ComparSize)compareRule
{
    NSUInteger stringLength = self.length;
    switch (compareRule) {
        case ComparSizeMore: // 大于
            return stringLength > length;
        case ComparSizeEqual:
            return stringLength == length;
        case ComparSizeLess:
            return stringLength < length;
    }
}


/**
 校验字符串是否满足某个规则下的某个位数 (返回大于，小于，等于)
 */
+ (BOOL)string:(NSString *)string
        length:(NSUInteger)length
       compare:(ComparSize)compareRule
{
    return [string stringLength:length compare:compareRule];
}



#pragma mark - change  转换类
/**
 删除当前字符串中的某些字符（比如空字符）
 */
- (NSString *)deleteCharacters:(NSArray <NSString *>*)characters
{
    NSString *string = self;
    for (NSString *character in characters) {
        string = [string stringByReplacingOccurrencesOfString:character withString:@""];
    }
    
    return string;
}

/**
 删除字符串中的某些字符（比如空格）
 */
+ (NSString *)deleteCharacters:(NSArray <NSString *>*)characters String:(NSString *)string
{
    return [string deleteCharacters:characters];
}

/**
 将当前字符串反转
 */
- (NSString *)reversal
{
    // 取出字符串中的每一个字符，然后再从前往后的拼装
    NSUInteger length = self.length;
    NSMutableString *mutableString = [NSMutableString stringWithCapacity:length];
    
    for (long i = length - 1; i >= 0; i--) {
        
        UniChar c = [self characterAtIndex:i];
        NSString *cString = [NSString stringWithFormat:@"%c", c];
        [mutableString appendString:cString];
        
    }
    
    return [mutableString copy];
}

/**
 将字符串反转
 */
+ (NSString *)stringReversalWithString:(NSString *)string
{
    return [string reversal];
}


/**
 将当前字符串由16进制转换成2进制
 */
- (NSData *)hexConversionToBinary
{
    if (!self || self.length == 0) {
        return nil;
    }
    
    NSMutableData *binaryData = [[NSMutableData alloc] initWithCapacity:8];
    
    NSRange range;
    
    if ([self length] % 2 == 0) {
        range  = NSMakeRange(0, 2);
    }
    else
    {
        range = NSMakeRange(0, 1);
    }
    
    for (NSInteger i = range.location; i < self.length; i += 2) {
        
        unsigned int anInt;
        NSString *hexCharStr = [self substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        
        [binaryData appendData:entity];
        range.location += range.length;
        range.length = 2;
    }
    return binaryData;
}

/**
 将字符串由16进制转换成2进制
 */
+ (NSData *)hexConversionToBinaryWithString:(NSString *)string
{
    return [string hexConversionToBinary];
}



/**
 将当前字符串由2进制转换成16进制
 */
+ (NSString *)binaryConversionToHexWithData:(NSData *)data
{
    if (!data || [data length] == 0) {
        
        return @"";
    }
    
    NSMutableString *hexString = [[NSMutableString alloc] initWithCapacity:[data length]];
    [data enumerateByteRangesUsingBlock:^(const void * _Nonnull bytes, NSRange byteRange, BOOL * _Nonnull stop) {
        
        unsigned char *dataBytes = (unsigned char*)bytes;
        
        for (NSInteger i = 0; i < byteRange.length; i++) {
            
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]&0xff)];
            
            if ([hexStr length] == 2) {
                [hexString appendString:hexStr];
            }
            else
            {
                [hexString appendFormat:@"0%@", hexStr];
            }
        }
    }];
    return hexString;
}


/**
 复制当前字符串
 */
- (void)paster
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self];
}


/**
 复制字符串
 */
+ (void)pasterString:(NSString *)string
{
    [string paster];
}


#pragma mark - calculation  计算类
/**
 计算当前字符串的宽度
 */
- (CGFloat)calculateWidthWithMaxHeight:(CGFloat)height font:(UIFont *)font
{
    return [self calculateSizeWithFont:font maxSize:CGSizeMake(MAXFLOAT, height)].width;
}

/**
 计算字符串的高度
 */
+ (CGFloat)calculateWidthWithString:(NSString *)string
                          maxHeight:(CGFloat)height
                               font:(UIFont *)font
{
    return [string calculateWidthWithMaxHeight:height font:font];
}

/**
 计算当前字符串的高度
 */
- (CGFloat)calculateHeightWithMaxWidth:(CGFloat)width font:(UIFont *)font
{
    return [self calculateSizeWithFont:font maxSize:CGSizeMake(width, MAXFLOAT)].height;
}

/**
 计算字符串的高度
 */
+ (CGFloat)calculateHeightWithString:(NSString *)string
                            maxWidth:(CGFloat)width
                                font:(UIFont *)font
{
    return [string calculateHeightWithMaxWidth:width font:font];
}

/**
 计算当前字符串的宽高
 */
- (CGSize)calculateSizeWithFont:(UIFont *)font
{
    return [self calculateSizeWithFont:font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
}


/**
 计算字符串的宽高
 */
+ (CGSize)calculateSizeWithString:(NSString *)string
                             font:(UIFont *)font
{
    return [string calculateSizeWithFont:font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
}


- (CGSize)calculateSizeWithFont:(UIFont *)font maxSize:(CGSize)size
{
    CGSize expectedLabelSize = CGSizeZero;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    expectedLabelSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return CGSizeMake(ceil(expectedLabelSize.width), ceil(expectedLabelSize.height));
}




@end
