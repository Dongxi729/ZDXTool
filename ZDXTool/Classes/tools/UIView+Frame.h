//
//  UIView+Frame.h
//  WZLCodeLibrary
//
//  Created by wzl on 15/3/23.
//  Copyright (c) 2015年 Weng-Zilin. All rights reserved.
//

/*
 获取当前的X,Y,Width,Height,origin,size,bottom,tail,middleX,middleY 
 设置当前的X,Y,Width,Height,origin,size,bottom,tail,middleX,middleY
 */


#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat tail;
@property (nonatomic, assign) CGFloat middleX;
@property (nonatomic, assign) CGFloat middleY;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGPoint centerPoint;



@end
