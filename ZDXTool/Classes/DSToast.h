//
//  DSToast.h
//  DSToast
//
//  Created by LS on 8/18/15.
//  Copyright (c) 2015 LS. All rights reserved.
//  文本提示框

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DSToastShowType) {
    DSToastShowTypeTop,
    DSToastShowTypeCenter,
    DSToastShowTypeBottom,
    DSToastShowTypeCustom,//自定义位置
};

@interface DSToast : UILabel

+ (void)showText:(NSString *)text InView:(UIView *)view;
+ (void)showText:(NSString *)text InView:(UIView *)view ShowType:(DSToastShowType)type;

@end
