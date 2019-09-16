//
//  NSAttributedString+Helpers.m
//  ZLToolsDemo
//
//  Created by irisZL on 2017/9/18.
//  Copyright © 2017年 irisZL. All rights reserved.
//

#import "NSAttributedString+Helpers.h"

@implementation NSAttributedString (Helpers)


#pragma mark - 设置类

/**
 改变指定字体的大小
 originString -> 原字符串
 targetString -> 目标字符串
 font -> 目标大小
 */
+ (NSAttributedString *)changeFontWithOriginString:(NSString *)originString
                                         orginFont:(UIFont *)originFont
                                      targetString:(NSString *)targetString
                                        targetFont:(UIFont *)targetFont
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:originString];
    [attributeString setAttributeStringFont:originString font:originFont];
    [attributeString setAttributeStringFont:targetString font:targetFont];
    return [attributeString copy];
}


/**
 改变指定字体的颜色
 originString -> 原字符串
 targetString -> 目标字符串
 color -> 目标颜色
 */
+ (NSAttributedString *)changeColorWithOriginString:(NSString *)originString
                                        originColor:(UIColor *)originColor
                                       targetString:(NSString *)targetString
                                        targetColor:(UIColor *)targetColor
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:originString];
    [attributeString setAttributeStringColor:originString color:originColor];
    [attributeString setAttributeStringColor:targetString color:targetColor];
    return [attributeString copy];
}



/**
 改变行间距
 */
+ (NSAttributedString *)changeSpaceWithString:(NSString *)string
                                        space:(CGFloat)space
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributeString setLineSpace:space];
    return [attributeString copy];
}

/**
 给目标字符串增加下划线 并设置下划线的颜色
 */
+ (NSAttributedString *)addUnderLineWithOriginString:(NSString *)originString
                                        targetString:(NSString *)targetString
                                      underLineColor:(UIColor *)underLineColor
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:originString];
    [attributeString setUnderLineWithString:targetString];
    [attributeString setUnderLineColorWithString:targetString color:underLineColor];
    return [attributeString copy];
}

/**
 给目标字符串增加下划线 颜色跟随字体
 */
+ (NSAttributedString *)addUnderLineWithOriginString:(NSString *)originString
                                        targetString:(NSString *)targetString
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:originString];
    [attributeString setUnderLineWithString:targetString];
    return [attributeString copy];
}

/**
 设置字符串的首行缩进
 */
+ (NSAttributedString *)firstLineHeaderIndent:(CGFloat)headerIndent
                                      string:(NSString *)string
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.firstLineHeadIndent = headerIndent;
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributeString setParagraphStyle:[style copy]];
    return [attributeString copy];
}


/**
 对目标字符串进行多属性的设置
 */
+ (NSAttributedString *)changeAttributeWithOriginString:(NSString *)originString
                                       originAttributes:(NSDictionary<NSString *, id> *)originAttributes
                                           targetString:(NSString *)targetString
                                       targetattributes:(NSDictionary<NSString *, id> *)targetattributes
{
    NSMutableAttributedString *mutableAttributeString = [[NSMutableAttributedString alloc] initWithString:originString];
    if ([originString rangeOfString:targetString].location == NSNotFound) {
        [mutableAttributeString setAttributes:originAttributes range:NSMakeRange(0, originString.length)];
    }
    else
    {
        NSRange targetRange = [originString rangeOfString:targetString];
        [mutableAttributeString setAttributes:originAttributes range:NSMakeRange(0, originString.length)];
        [mutableAttributeString setAttributes:targetattributes range:targetRange];
    }
    
    return [mutableAttributeString copy];
}


#pragma mark - 计算类
/**
 获取当前富文本字符串的大小
 */
- (CGSize)calculateSize
{
    return [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
}


/**
 获取富文本字符串的大小
 */
+ (CGSize)calculateSizeWithAttributeString:(NSAttributedString *)attributeString
{
    return [attributeString calculateSize];
}

/**
 计算当前富文本字符串宽度
 */
- (CGFloat)calculateWidthWithMaxHeight:(CGFloat)height
{
    return [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.width;
}


/**
 计算富文本字符串宽度
 */
+ (CGFloat)calculateWidthWithAttributeString:(NSAttributedString *)attriString
                                   maxHeight:(CGFloat)height
{
    return [attriString calculateWidthWithMaxHeight:height];
}

/**
 计算当前富文本字符串高度
 */
- (CGFloat)calculateHeightWithMaxWidth:(CGFloat)width
{
    return [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
}


/**
 计算富文本字符串高度
 */
- (CGFloat)calculateWidthWithAttributeString:(NSAttributedString *)attriString
                                    maxWidth:(CGFloat)width
{
    return [attriString calculateHeightWithMaxWidth:width];
}


@end


@implementation NSMutableAttributedString (Helpers)

/**
 设置颜色字体
 */
- (void)setAttributeStringColor:(NSString *)string
                          color:(UIColor *)color
{
    [self addAttribute:NSForegroundColorAttributeName value:color range:[self getRangeWithTargetString:string]];
}


/**
 设置颜色大小
 */
- (void)setAttributeStringFont:(NSString *)string
                          font:(UIFont *)font
{
    [self addAttribute:NSFontAttributeName value:font range:[self getRangeWithTargetString:string]];
}


/**
 设置行间距
 */
- (void)setLineSpace:(CGFloat)lineSpace
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpace;
    [self addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.mutableString.length)];
}

/**
 设置下划线
 */
- (void)setUnderLineWithString:(NSString *)targetString
{
    [self addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:[self getRangeWithTargetString:targetString]];
}

/**
 设置下划线颜色
 */
- (void)setUnderLineColorWithString:(NSString *)targetString
                              color:(UIColor *)targetColor
{
    [self addAttribute:NSUnderlineColorAttributeName value:targetColor range:[self getRangeWithTargetString:targetString]];
}



/**
 设置页面风格：比如行间距，首行缩进，断行模式
 */
- (void)setParagraphStyle:(NSParagraphStyle *)style
{
    [self addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.mutableString.length)];
}


- (NSRange)getRangeWithTargetString:(NSString *)targetstring
{
    NSRange range = NSMakeRange(0, 0);
    NSString *originString = [self.mutableString copy];
    if ([originString rangeOfString:targetstring].location != NSNotFound) {
        range = [originString rangeOfString:targetstring];
    }
    return range;
}





@end


