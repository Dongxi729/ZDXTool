//
//  XTNetWorkService.h
//  AFNetWorkingDemo
//
//  Created by 亿同科技 on 16/7/6.
//  Copyright © 2016年 xutong. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^XTResultBlock)(BOOL isSuccess, NSString * _Nullable msg, id _Nullable result);
typedef void (^XTOriginResultBlock)(NSInteger status, id _Nullable result);

@interface XTNetWorkService : NSObject

@property (nonatomic,strong) NSMutableArray<NSURLSessionDataTask*>  * _Nullable managerArray;
/// 请求的task任务
@property (nonatomic,strong) NSURLSessionTask * _Nonnull requestDataTask;

+ (XTNetWorkService *_Nullable)shareInstance;

- (void)netWorkUrlUsePost:(NSString *_Nullable)url DataSource:(NSDictionary *_Nullable)dic Block:(XTResultBlock _Nullable )block andHud:(NSString *_Nullable)hud;

@end

