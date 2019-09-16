//
//  IRTools.m
//  ZLToolsDemo
//
//  Created by irisZL on 2017/9/27.
//  Copyright © 2017年 irisZL. All rights reserved.
//

#import "IRTools.h"
#import <CommonCrypto/CommonDigest.h>
#import <Security/Security.h>
#import <CommonCrypto/CommonDigest.h>

@implementation IRTools

/**
 MD5加密
 加密某一个字符串
 */
+ (NSString *)MD5WithString:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
            ];
}

/**
 base64编码 数据
 */
+ (NSString *)stringByEncodeData:(NSData *)data
{
    return [data base64EncodedStringWithOptions:0];
}

/**
 base64解码 数据
 */
+ (NSData *)decodeString:(NSString *)string
{
   return [[NSData alloc] initWithBase64EncodedString:string options:0];
}

/**
 判断字符串是否为手机号
 */
+ (BOOL)isAvailablePhone:(NSString *)phone
{
    NSString *regexnumber = @"^1[0-9]{10}$";
    NSPredicate *numbertest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",regexnumber];
    return [numbertest evaluateWithObject:phone];
}

/**
 判断字符串是否为邮箱
 */
+ (BOOL)isAvailableEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 判断字符串是否为标准URL
 */
+ (BOOL)isAvailableURL:(NSString *)URL
{
    NSString *urlRegex = @"http(s)?://([\\w-]+\\.)+(/[\\w-./?%&=]*)?";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",urlRegex];
    return [urlTest evaluateWithObject:URL];
}

/**
 银行卡号的匹配
 */
+ (BOOL)isAvailableBankcard:(NSString *)bankcard
{
    NSInteger card = [bankcard integerValue];
    if (card > 0)
    {
        char bit = [IRTools getBankCardCheckCode:bankcard];
        if (bit == 'N') {
            return NO;
        }
        return [bankcard UTF8String][[bankcard length]-1] == bit;
    }
    else
    {
        return NO;
    }
}

BOOL isNumber (char ch)
{
    if (!(ch >= '0' && ch <= '9')) {
        return FALSE;
    }
    return TRUE;
}

+ (char)getBankCardCheckCode:(NSString *)string {
    const char *cvalue = [string UTF8String];
    int len = (int)strlen(cvalue);
    for (int i = 0; i < len; i++) {
        if(!isNumber(cvalue[i])){
            return 'N';
        }
    }
    int luhmSum = 0;
    for(int i = len - 2, j = 0; i >= 0; i--, j++) {
        int k = cvalue[i] - '0';
        if(j % 2 == 0) {
            k *= 2;
            k = k / 10 + k % 10;
        }
        luhmSum += k;
    }
    return (luhmSum % 10 == 0) ? '0' : (char)((10 - luhmSum % 10) + '0');
}

/**
 身份证号码的匹配
 */
+ (BOOL)isAvailableIDCard:(NSString *)idcard
{
    BOOL flag;
    if (idcard.length <= 0)
    {
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    flag = [identityCardPredicate evaluateWithObject:idcard];
    
    
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(flag)
    {
        if(idcard.length==18)
        {
            //将前17位加权因子保存在数组里
            NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
            
            //这是除以11后，可能产生的11位余数、验证码，也保存成数组
            NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
            
            //用来保存前17位各自乖以加权因子后的总和
            
            NSInteger idCardWiSum = 0;
            for(int i = 0;i < 17;i++)
            {
                NSInteger subStrIndex = [[idcard substringWithRange:NSMakeRange(i, 1)] integerValue];
                NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
                
                idCardWiSum+= subStrIndex * idCardWiIndex;
                
            }
            
            //计算出校验码所在数组的位置
            NSInteger idCardMod=idCardWiSum%11;
            
            //得到最后一位身份证号码
            NSString * idCardLast= [idcard substringWithRange:NSMakeRange(17, 1)];
            
            //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
            if(idCardMod==2)
            {
                if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
                {
                    return flag;
                }else
                {
                    flag =  NO;
                    return flag;
                }
            }else
            {
                //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
                if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
                {
                    return flag;
                }
                else
                {
                    flag =  NO;
                    return flag;
                }
            }
        }
        else
        {
            flag =  NO;
            return flag;
        }
    }
    else
    {
        return flag;
    }
}

/**
 根据身份证号识别性别
 */
+ (IRGender)identifyGenderWithIDCard:(NSString *)idcard
{
    NSString *oushu = @"02468";
    IRGender gender = IRGenderNone;
    NSInteger length = idcard.length;
    if (idcard && length > 1)
    {
        NSString *last2Number = [idcard substringWithRange:NSMakeRange(length - 2, 1)];
        if (last2Number)
        {
            //判断字符串是否包含
            NSRange range = [oushu rangeOfString:last2Number];
            //不包含那么表示是奇数，则是男性
            if (range.location ==NSNotFound)
            {
                gender = IRGenderMale;
            }
            else
            {
                gender =  IRGenderFemale;
            }
        }
    }
    return gender;
}

/**
 获取当前屏幕的宽度
 */
+ (CGFloat)getScreenWidth
{
    CGRect mainRect = [UIScreen mainScreen].bounds;
    
    return mainRect.size.width;
}

/**
 获取当前屏幕的高度
 */
+ (CGFloat)getScreenHeight
{
    CGRect mainRect = [UIScreen mainScreen].bounds;
    return mainRect.size.height;
}

/**
 对URL进行Encode
 */
+ (NSString *)encoderURLWithURLString:(NSString *)urlString
{
    NSString *encodeString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)urlString, NULL, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", kCFStringEncodingUTF8));
    return encodeString;
}

@end
