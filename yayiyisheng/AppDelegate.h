//
//  AppDelegate.h
//  yayiyisheng
//
//  Created by hxp on 17/5/31.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (AFHTTPSessionManager *)sharedHTTPSession;
@end

