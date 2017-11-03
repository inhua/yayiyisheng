//
//  YUYANetWorking.h
//  com.yigu.yuya
//
//  Created by hxp on 16/3/4.
//  Copyright © 2016年 hxp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YAYINetWorking : NSObject
+(void)postJsonSerilizeWithURL:(NSString *)url param:(NSDictionary *)param finish:(void(^)(NSData *data,NSDictionary *dict,NSError *error,NSDictionary *responseError))cb;
+(void)postWithURL:(NSString *)url param:(NSDictionary *)param finish:(void(^)(NSData *data,NSDictionary *dict,NSError *error))cb;
+(void)getWithURL:(NSString *)url param:(NSDictionary *)dict finish:(void(^)(NSData *data,NSDictionary *dict,NSError *error))cb;

+(void)postJsonSerilizeWithURL:(NSString *)url APIStr:(NSString *)APIStr param:(NSDictionary *)param finish:(void (^)(NSData *data, NSDictionary *dict, NSError *error, NSDictionary *responseError))cb;
@end
