//
//  UIView+VR.h
//  day3
//
//  Created by xiaozhe on 15/4/15.
//  Copyright (c) 2016年 Veer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (VR)

/**直接赋值坐标x值*/
@property(nonatomic,assign)CGFloat x;
/*
 - (void)setX:(CGFLoat)x;
 - (CGFLoat)x;
 */

/**直接赋值坐标y值*/
@property(nonatomic,assign)CGFloat y;

/** 直接赋值座标点(x,y) */
@property(nonatomic,assign)CGPoint origin;

/**直接赋值宽度*/
@property(nonatomic,assign)CGFloat width;

/**直接赋值高度*/
@property(nonatomic,assign)CGFloat height;

/**直接赋值中心x*/
@property(nonatomic,assign)CGFloat centerX;

/**直接赋值中心y*/
@property(nonatomic,assign)CGFloat centerY;

/**直接赋值宽度与高度(w,h)*/
@property(nonatomic,assign)CGSize size;


@end
