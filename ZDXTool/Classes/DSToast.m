//
//  DSToast.m
//  DSToast
//
//  Created by LS on 8/18/15.
//  Copyright (c) 2015 LS. All rights reserved.
//

#import "DSToast.h"

static CFTimeInterval const kDefaultForwardAnimationDuration = 0.5;
static CFTimeInterval const kDefaultBackwardAnimationDuration = 0.5;
static CFTimeInterval const kDefaultWaitAnimationDuration = 1.0;

static CGFloat const kDefaultTopMargin = 50.0;
static CGFloat const kDefaultBottomMargin = 50.0;
static CGFloat const kDefalultTextInset = 10.0;

static NSInteger const kOnlyToastTag  =  9999;

@interface DSToast ()<CAAnimationDelegate>

@property (nonatomic, assign) CFTimeInterval forwardAnimationDuration;
@property (nonatomic, assign) CFTimeInterval backwardAnimationDuration;
@property (nonatomic, assign) UIEdgeInsets   textInsets;
@property (nonatomic, assign) CGFloat        maxWidth;

- (id)initWithText:(NSString *)text;
- (void)showInView:(UIView *)view;
- (void)showInView:(UIView *)view showType:(DSToastShowType)type;

@end

@implementation DSToast

- (id)initWithText:(NSString *)text {
    self = [self initWithFrame:CGRectZero];
    if (self) {
        self.text = text;
        [self sizeToFit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.forwardAnimationDuration = kDefaultForwardAnimationDuration;
        self.backwardAnimationDuration = kDefaultBackwardAnimationDuration;
        self.textInsets = UIEdgeInsetsMake(kDefalultTextInset, kDefalultTextInset, kDefalultTextInset, kDefalultTextInset);
        self.maxWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 20.0;
        self.layer.cornerRadius = 4.0;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        self.numberOfLines = 0;
        self.textAlignment = NSTextAlignmentLeft;
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:14.0];
    }
    return self;
}

#pragma mark - Show Method
+ (void)showText:(NSString *)text InView:(UIView *)view {
    [DSToast showText:text InView:view ShowType:DSToastShowTypeBottom];
}

+ (void)showText:(NSString *)text InView:(UIView *)view ShowType:(DSToastShowType)type {
    if ([view viewWithTag:kOnlyToastTag]) {
        return;
    }
    DSToast *toast = [[DSToast alloc] initWithText:text];
    toast.tag = kOnlyToastTag;
    [toast showInView:view showType:type];
}

- (void)showInView:(UIView *)view {
    [self showInView:view showType:DSToastShowTypeBottom];
}

- (void)showInView:(UIView *)view showType:(DSToastShowType)type {
    [self addAnimationGroup];
    CGPoint point = CGPointMake(view.frame.size.width/2.0, view.frame.size.height/2.0);
    switch (type) {
        case DSToastShowTypeTop:
            point.y = kDefaultTopMargin;
            break;
        case DSToastShowTypeBottom:
            point.y = CGRectGetHeight(view.bounds) - kDefaultBottomMargin;
            break;
        case DSToastShowTypeCustom:{
            point.y = CGRectGetHeight(view.bounds)- 65;
            break;
        }
        default:
            break;
    }
    self.center = point;
    [view addSubview:self];
}

#pragma mark - Animation

- (void)addAnimationGroup {
    CABasicAnimation *forwardAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    forwardAnimation.duration = self.forwardAnimationDuration;
    forwardAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5f :1.7f :0.6f :0.85f];
    forwardAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    forwardAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    CABasicAnimation *backwardAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    backwardAnimation.duration = self.backwardAnimationDuration;
    backwardAnimation.beginTime = forwardAnimation.duration + kDefaultWaitAnimationDuration;
    backwardAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4f :0.15f :0.5f :-0.7f];
    backwardAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    backwardAnimation.toValue = [NSNumber numberWithFloat:0.0f];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[forwardAnimation,backwardAnimation];
    animationGroup.duration = forwardAnimation.duration + backwardAnimation.duration + kDefaultWaitAnimationDuration;
    animationGroup.removedOnCompletion = NO;
    animationGroup.delegate = self;
    animationGroup.fillMode = kCAFillModeForwards;
    
    [self.layer addAnimation:animationGroup forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        [self removeFromSuperview];
    }
}

#pragma mark - Text Configurate

- (void)sizeToFit {
    [super sizeToFit];
    
    CGRect frame = self.frame;
    CGFloat width = CGRectGetWidth(self.bounds) + self.textInsets.left + self.textInsets.right;
    frame.size.width = width > self.maxWidth? self.maxWidth : width;
    frame.size.height = CGRectGetHeight(self.bounds) + self.textInsets.top + self.textInsets.bottom;
    self.frame = frame;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.textInsets)];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
   bounds.size = [self.text boundingRectWithSize:CGSizeMake(self.maxWidth - self.textInsets.left - self.textInsets.right,
                                               CGFLOAT_MAX)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:self.font}
                                         context:nil].size;
    return bounds;
}

@end
