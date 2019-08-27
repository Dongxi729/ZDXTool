//
//  VVV.m
//  Pods-ZDXTool_Tests
//
//  Created by 郑东喜 on 2019/8/27.
//

#import "VVV.h"

@implementation VVV


- (void)extracted {
    NSString *urlString = @"https://api.weibo.com/2/statuses/public_timeline.json";
    
    NSDictionary *parameters = @{@"access_token":@"2.00PogMQGGQ5O2E3633c3a534p58DVB"};
    
    //1.创建管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2.设置请求参数的拼接
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    //3.设置接受的响应数据类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //做get请求
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject is:%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error is:%@",error);
    }];
}


@end
