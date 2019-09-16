//
//  UIView+Helper.h
//  ZLToolsDemo
//
//  Created by irisZL on 2017/9/27.
//  Copyright © 2017年 irisZL. All rights reserved.
//

/*
 （1）判断两个View的位置关系（重叠，重合，分离）
 */


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, IRPositionRelation) {
    IRPositionRelationOverLapper, // 重叠(仅有部分交叠在一起)
    IRPositionRelationContain,  // 包含(包括重合）
    IRPositionRelationSeparation, // 分离(没有重合在一起)
    
    IRPositionRelationNone, // 未知
};


@interface UIView (Helper)

/**
 判断当前的View和另一个View之间的关系
 */
- (IRPositionRelation)determineThePositionShipWithOtherView:(UIView *)otherView;


/**
 判断两个view之间的位置关系
 */
+ (IRPositionRelation)determineThePositionShip:(UIView *)view OtherView:(UIView *)otherView;





@end
