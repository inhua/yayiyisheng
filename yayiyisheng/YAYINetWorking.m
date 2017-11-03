//
//  YUYANetWorking.m
//  com.yigu.yuya
//
//  Created by hxp on 16/3/4.
//  Copyright © 2016年 hxp. All rights reserved.
//

#import "YAYINetWorking.h"
#import "AppDelegate.h"


@implementation YAYINetWorking



+(void)postJsonSerilizeWithURL:(NSString *)url param:(NSDictionary *)param finish:(void (^)(NSData *, NSDictionary *, NSError *, NSDictionary *))cb
{

    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    AFHTTPSessionManager *manager = [app sharedHTTPSession];
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [[NSSet  alloc] initWithObjects:@"application/json", nil];
    
    AFJSONResponseSerializer *json =[AFJSONResponseSerializer serializer];
    json.removesKeysWithNullValues = YES;
    manager.responseSerializer = json;

    manager.requestSerializer=[AFJSONRequestSerializer serializer];

    // 设置超时时长
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.0;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",API,url];
    [manager POST:urlStr parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        [SVProgressHUD dismiss];
        cb(responseObject,responseObject,nil,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        if (error.code == -1009) {
            
           // [SVProgressHUD showErrorWithStatus:@"网络连接错误"];
        }else if (error.code == -1001){ // 链接超时
            
            //[SVProgressHUD showErrorWithStatus:@"请求超时"];
        }else{
            
            //[SVProgressHUD dismiss];
            
            if (error.userInfo[@"com.alamofire.serialization.response.error.data"]) {
                
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
                
                cb(nil,nil,error, dict);
            }else{
                
                cb(nil, nil, error, nil);
            }
        }
    }];
    
}


+ (void)getWithURL:(NSString *)url param:(NSDictionary *)dict finish:(void (^)(NSData *, NSDictionary *, NSError *))cb
{
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    AFHTTPSessionManager *manager = [app sharedHTTPSession];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    
    // 设置超时时长
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.0;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
    AFJSONResponseSerializer *json =[AFJSONResponseSerializer serializer];
    json.removesKeysWithNullValues = YES;
    manager.responseSerializer = json;
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",API,url];
    
    [manager GET:urlStr parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        [SVProgressHUD dismiss];
        cb(responseObject, responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //YAYILog(@"af ： erro:%@", error);
        
        if (error.code == -1009) {  // 网络连接错误
            
           // [SVProgressHUD showErrorWithStatus:@"网络连接错误"];
        }else if (error.code == -1001){ // 链接超时
        
            //[SVProgressHUD showErrorWithStatus:@"请求超时"];
        }else{
            
           // [SVProgressHUD dismiss];
        }
        cb(nil, nil, error);
    }];
    
}


+(void)postWithURL:(NSString *)url param:(NSDictionary *)param finish:(void (^)(NSData *, NSDictionary *, NSError *))cb
{

    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    AFHTTPSessionManager *manager = [app sharedHTTPSession];
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *json =[AFJSONResponseSerializer serializer];
    json.removesKeysWithNullValues = YES;
    manager.responseSerializer = json;
    
    // 设置超时时长
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.0;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",API,url];
    [manager POST:urlStr parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        [SVProgressHUD dismiss];
        cb(responseObject,responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        if (error.code == -1009) {
            
            //[SVProgressHUD showErrorWithStatus:@"网络连接错误"];
        }else if (error.code == -1001){ // 链接超时
            
            //[SVProgressHUD showErrorWithStatus:@"请求超时"];
        }else{
            
            //[SVProgressHUD dismiss];
            
        }
        
        cb(nil,nil,error);
        
    }];
    
}


+(void)postJsonSerilizeWithURL:(NSString *)url APIStr:(NSString *)APIStr param:(NSDictionary *)param finish:(void (^)(NSData *, NSDictionary *, NSError *,NSDictionary *))cb
{
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    AFHTTPSessionManager *manager = [app sharedHTTPSession];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [[NSSet  alloc] initWithObjects:@"application/json", nil];
    
    AFJSONResponseSerializer *json =[AFJSONResponseSerializer serializer];
    json.removesKeysWithNullValues = YES;
    manager.responseSerializer = json;
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    // 设置超时时长
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.0;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",APIStr, url];
    [manager POST:urlStr parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //[SVProgressHUD dismiss];
        cb(responseObject,responseObject,nil,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //YAYILog(@"erro:%@", error);
        
        if (error.code == -1009) {
            
            //[SVProgressHUD showErrorWithStatus:@"网络连接错误"];
        }else if (error.code == -1001){ // 链接超时
            
           // [SVProgressHUD showErrorWithStatus:@"请求超时"];
        }else{
            
            //[SVProgressHUD dismiss];
            if (error.userInfo[@"com.alamofire.serialization.response.error.data"]) {
                
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:nil];
                
                cb(nil,nil,error, dict);
            }else{
                
                
            }
            cb(nil, nil, error, nil);
        }
        
    }];
    
}

@end
