//
//  UIView+Frame.m
//  WZLCodeLibrary
//
//  Created by wzl on 15/3/23.
//  Copyright (c) 2015年 Weng-Zilin. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

#pragma mark - x
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

#pragma mark - Y
- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

#pragma mark - origin
- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

#pragma mark - width
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

#pragma mark - Height
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

#pragma mark - size
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

#pragma mark - bottom
- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return CGRectGetMaxY(self.frame);
}

#pragma mark - tail
- (CGFloat)tail
{
    return CGRectGetMaxX(self.frame);
}

- (void)setTail:(CGFloat)tail
{
    CGRect frame = self.frame;
    frame.origin.x = tail - frame.size.width;
    self.frame = frame;
}

#pragma mark - middleX
- (void)setMiddleX:(CGFloat)middleX
{
    CGRect frame = self.frame;
    frame.origin.x = middleX - frame.size.width / 2;
    self.frame = frame;
}

- (CGFloat)middleX
{
    return CGRectGetMidX(self.frame);
}

#pragma mark - middleY
- (void)setMiddleY:(CGFloat)middleY
{
    CGRect frame = self.frame;
    frame.origin.y = middleY - frame.size.height / 2 ;
    self.frame = frame;
}

- (CGFloat)middleY
{
    return CGRectGetMidY(self.frame);
}

#pragma mark - centerX
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

#pragma mark - centerY
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}


#pragma mark - centerPoint
- (void)setCenterPoint:(CGPoint)centerPoint
{
    self.center = centerPoint;
}

- (CGPoint)centerPoint
{
    return self.center;
}


@end
