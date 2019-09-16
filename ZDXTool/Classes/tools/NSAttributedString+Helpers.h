//
//  NSAttributedString+Helpers.h
//  ZLToolsDemo
//
//  Created by irisZL on 2017/9/18.
//  Copyright © 2017年 irisZL. All rights reserved.
//

/*
 
 NSAttributeString:   富文本处理类
 （1）计算富文本字符串的大小
 1.1 计算富文本字符串宽度
 1.2 计算富文本字符串高度
 （2）字符串转换成富文本（带入不同的转换参数）
 2.1 改变指定字体的大小
 2.2 改变指定字体的颜色
 2.3 改变行间距
 2.4 改变多个指定字的颜色 (备注：暂时不支持)
 2.5 改变多个指定字体的大小 （备注：暂时不支持，考虑到使用面积小，而且可扩展和可延伸的需求过多）
 2.6 给目标字符串增加下划线
 2.7 设置字符串的首行缩进
 2.8 对目标字符串进行多属性的设置
 
 
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString (Helpers)

#pragma mark - 设置类
/**
 改变指定字的大小
 originString -> 原字符串
 targetString -> 目标字符串
 font -> 目标大小
 */
+ (NSAttributedString *)changeFontWithOriginString:(NSString *)originString
                                         orginFont:(UIFont *)originFont
                                      targetString:(NSString *)targetString
                                        targetFont:(UIFont *)targetFont;

/**
 改变指定字的颜色
 originString -> 原字符串
 targetString -> 目标字符串
 color -> 目标颜色
 */
+ (NSAttributedString *)changeColorWithOriginString:(NSString *)originString
                                        originColor:(UIColor *)originColor
                                       targetString:(NSString *)targetString
                                        targetColor:(UIColor *)targetColor;

/**
 改变行间距
 */
+ (NSAttributedString *)changeSpaceWithString:(NSString *)string
                                        space:(CGFloat)space;

/**
 给目标字符串增加下划线 颜色自定义
 */
+ (NSAttributedString *)addUnderLineWithOriginString:(NSString *)originString
                                        targetString:(NSString *)targetString
                                      underLineColor:(UIColor *)underLineColor;

/**
 给目标字符串增加下划线 颜色跟随字体
 */
+ (NSAttributedString *)addUnderLineWithOriginString:(NSString *)originString
                                        targetString:(NSString *)targetString;

/**
 设置字符串的首行缩进
 */
+ (NSAttributedString *)firstLineHeaderIndent:(CGFloat)headerIndent
                                       string:(NSString *)string;



/**
 对目标字符串进行多属性的设置
 */
+ (NSAttributedString *)changeAttributeWithOriginString:(NSString *)originString
                                       originAttributes:(NSDictionary<NSString *, id> *)originAttributes
                                           targetString:(NSString *)targetString
                                       targetattributes:(NSDictionary<NSString *, id> *)targetattributes;


#pragma mark - 计算类
/**
 计算当前富文本字符串的大小
 */
- (CGSize)calculateSize;

/**
 计算富文本字符串的大小
 */
+ (CGSize)calculateSizeWithAttributeString:(NSAttributedString *)attributeString;


/**
 计算当前富文本字符串宽度
 */
- (CGFloat)calculateWidthWithMaxHeight:(CGFloat)height;

/**
 计算富文本字符串宽度
 */
+ (CGFloat)calculateWidthWithAttributeString:(NSAttributedString *)attriString
                                   maxHeight:(CGFloat)height;


/**
 计算当前富文本字符串高度
 */
- (CGFloat)calculateHeightWithMaxWidth:(CGFloat)width;


/**
 计算富文本字符串高度
 */
- (CGFloat)calculateWidthWithAttributeString:(NSAttributedString *)attriString
                                    maxWidth:(CGFloat)width;



@end


@interface NSMutableAttributedString (Helpers)

/**
 设置颜色字体
 */
- (void)setAttributeStringColor:(NSString *)string
                          color:(UIColor *)color;

/**
 设置大小
 */
- (void)setAttributeStringFont:(NSString *)string
                          font:(UIFont *)font;

/**
 设置行间距
 */
- (void)setLineSpace:(CGFloat)lineSpace;


/**
 设置下划线
 */
- (void)setUnderLineWithString:(NSString *)targetString;


/**
 设置下划线颜色
 */
- (void)setUnderLineColorWithString:(NSString *)targetString
                              color:(UIColor *)targetColor;


/**
 设置页面风格：比如行间距，首行缩进，断行模式
 */
- (void)setParagraphStyle:(NSParagraphStyle *)style;


@end


