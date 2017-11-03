//
//  YAColor.h
//  yayiyisheng
//
//  Created by hxp on 17/6/1.
//  Copyright © 2017年 achego. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    YABackgroundColor,
    YALineColor,
} YAColortype;

@interface YAColor : NSObject

+ (instancetype)shareInstance;

+ (UIColor *)YABackgroundColor; //背景色

+ (UIColor *)YALineColor;       //cell 分割线的背景色

+ (UIColor *) colorWithHexString: (NSString *) hexString;
@end
