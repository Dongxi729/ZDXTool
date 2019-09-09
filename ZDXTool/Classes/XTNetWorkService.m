//
//  XTNetWorkService.m
//  AFNetWorkingDemo
//
//  Created by 亿同科技 on 16/7/6.
//  Copyright © 2016年 xutong. All rights reserved.
//  网络请求类

#import "XTNetWorkService.h"
#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif

#define TIMEOUTINTERVAL 60

@interface XTNetWorkService ()

@property (nonatomic,strong) AFHTTPSessionManager * _Nullable manager;

@end

static XTNetWorkService *_netWorkService = nil;

@implementation XTNetWorkService

+ (XTNetWorkService *)shareInstance {
    if (_netWorkService == nil) {
        _netWorkService = [[XTNetWorkService alloc] init];
    }
    return _netWorkService;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.requestSerializer.timeoutInterval = TIMEOUTINTERVAL;
        [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    return self;
}


#pragma mark - 请求成功处理和失败处理 异步登录通知
- (void)extracted:(XTResultBlock)block responseObject:(id _Nullable)responseObject urlString:(NSString *)urlString {
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    
    if (dic == nil) {
        NSDictionary *errorInfo = @{
                                    @"status" : @(200),
                                    @"url" : urlString,
                                    @"data" : @{},
                                    @"headers" : @{}
                                    };
        block((NO), @"网络请求失败", errorInfo);
    } else {
        int resultCode = [[dic objectForKey:@"resultCode"] intValue];
        NSString *resultMessage = [dic objectForKey:@"resultMessage"];
        id result = [dic objectForKey:@"result"];
        block((resultCode == 0), resultMessage, result);
        //        NSLog(@"resultCode=%d,resultMessage=%@,result=%@",resultCode,resultMessage,result);
    }
}

- (void)extracted:(XTResultBlock)block error:(NSError * _Nonnull)error urlString:(NSString *)urlString {
    NSDictionary *errorInfoDic = @{};
    
    NSDictionary *errorInfo;
    if ([error userInfo][@"com.alamofire.serialization.response.error.data"]) {
        errorInfo = [NSJSONSerialization JSONObjectWithData:([error userInfo][@"com.alamofire.serialization.response.error.data"]) options:NSJSONReadingMutableLeaves error:NULL];
    }
    
    errorInfoDic = @{@"status" : errorInfo[@"resultCode"] == nil ? @(-1004) : errorInfo[@"resultCode"],
                     @"msg" : [error userInfo][@"NSLocalizedDescription"],
                     @"headers" : @{},
                     @"url" : urlString,
                     };
    
    block((NO), @"网络请求失败", errorInfoDic);
    
    [self notifiTologin:error];
}

- (void)notifiTologin:(NSError * _Nonnull)error {
    
}


// 默认开启https请求
- (void)netWorkUrlUsePost:(NSString *)url DataSource:(NSDictionary *)dic Block:(XTResultBlock)block andHud:(NSString *)hud {
    
    NSMutableDictionary *requestDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    NSLog(@"%@",dic);
    
    
    if (dic == nil) {
        requestDic = [NSMutableDictionary dictionary];
    }
    //    NSLog(@"地址%@-报文%@:",url,dic);
    
    [_manager.requestSerializer setValue:[dic objectForKey:@"Authorization"] forHTTPHeaderField:@"Authorization"];
    
    
    // 申明返回的结果是text/html类型
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *urlString = url;
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    _requestDataTask = [_manager POST:urlString parameters:requestDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self extracted:block responseObject:responseObject urlString:urlString];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        /// 返回的错误字典
        [self extracted:block error:error urlString:urlString];
    }];
    
    
}

@end

