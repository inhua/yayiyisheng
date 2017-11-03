//
//  UIImage+VR.h
//  VRWeibo
//
//  Created by h3c-hp on 15/12/21.
//  Copyright © 2015年 h3c-mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (VR)

+ (UIImage *)imageWithColor:(UIColor*)color;
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

@end
