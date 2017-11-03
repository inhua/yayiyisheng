//
//  YAHomeheaderView.h
//  yayiyisheng
//
//  Created by hxp on 17/6/2.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSInteger const viewHeight = 200;

@interface YAHomeheaderView : UIView<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIPageControl *pagecontrol;
@end
