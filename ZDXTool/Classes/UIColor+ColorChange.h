//
//  UIColor+ColorChange.h
//  xmsdyyyOA
//
//  Created by 郑东喜 on 2018/12/3.
//  Copyright © 2018 etong. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIColor (ColorChange)

// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *) colorWithHexString: (NSString *)color;

@end
