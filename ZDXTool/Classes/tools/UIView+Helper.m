//
//  UIView+Helper.m
//  ZLToolsDemo
//
//  Created by irisZL on 2017/9/27.
//  Copyright © 2017年 irisZL. All rights reserved.
//

#import "UIView+Helper.h"

@implementation UIView (Helper)

/**
 判断当前的View和另一个View之间的关系
 */
- (IRPositionRelation)determineThePositionShipWithOtherView:(UIView *)otherView
{
    if (otherView) {
        
        BOOL isContain = CGRectContainsRect(self.frame, otherView.frame);
        if (isContain) {
            return IRPositionRelationContain;
        }
        else
        {
            BOOL isOverLapper = CGRectIntersectsRect(self.frame, otherView.frame);
            if (isOverLapper) {
                return IRPositionRelationOverLapper;
            }
            else
            {
                // 不相交也不包含的情况下，即为分离
                return IRPositionRelationSeparation;
            }
        }
        
    }
    else
    {
        return IRPositionRelationNone;
    }
    
}

/**
 判断两个view之间的位置关系
 */
+ (IRPositionRelation)determineThePositionShip:(UIView *)view OtherView:(UIView *)otherView
{
    return [view determineThePositionShipWithOtherView:otherView];
}

@end
