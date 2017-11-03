//
//  YAColor.m
//  yayiyisheng
//
//  Created by hxp on 17/6/1.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAColor.h"

@implementation YAColor
+(instancetype)shareInstance
{
    static YAColor *color= nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [[YAColor alloc] init];
    });
    return color;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
+(UIColor *)YABackgroundColor
{
    return YAYIColor(250,250,250);
}

+(UIColor *)YALineColor
{

    return YAYIColor(239,240,240);
}

+(UIColor *)columeColor:(YAColortype)type{

    switch (type) {
        case YALineColor:
            return [UIColor whiteColor];
            break;
        case YABackgroundColor:
             return [UIColor whiteColor];
            break;
        default:
            break;
             return [UIColor whiteColor];
    }
}

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

+ (UIColor *) colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            return nil;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

@end
