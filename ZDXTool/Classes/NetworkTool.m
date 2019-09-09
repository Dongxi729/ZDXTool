//
//  NetworkTool.m
//  TestWebViewDemo
//
//  Created by 郑东喜 on 2019/9/9.
//  Copyright © 2019 郑东喜. All rights reserved.
//

#import "NetworkTool.h"
#import "AFNetworking.h"

@implementation NetworkTool


+ (void)networkGet {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *dict = @{
                           @"username":@"jyq",
                           @"pwd":@"jyq",
                           @"type":@"JSON"
                           };
    //第一个参数:请求路径(NSString) (URL地址后面无需添加参数)
    //第二个参数:要发送给服务器的参数 (传NSDictionary)
    //第三个参数:progress 进度回调
    //第四个参数:success 成功的回调
    //responseObject:响应体(内部默认已经做了JSON的反序列处理)
    //    task.response:响应头信息
    //第五个参数:failure 失败的回调
    NSURLSessionDataTask *cancel = [manager POST:@"http://www.baidu.com" parameters:dict progress:nil success:
                                    ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                        NSLog(@"请求成功---%@---%@",responseObject,[responseObject class]);
                                        
                                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                        
                                        NSLog(@"请求失败--%@",error);
                                    }];
    
    [cancel cancel];
    NSLog(@"====%lu",(unsigned long)manager.tasks.count);
}

@end
