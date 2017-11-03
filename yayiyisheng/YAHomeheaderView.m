//
//  YAHomeheaderView.m
//  yayiyisheng
//
//  Created by hxp on 17/6/2.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAHomeheaderView.h"

@implementation YAHomeheaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.scrollView];
        [self addSubview:self.pagecontrol];
        [self createView];
    }
    return self;
}
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_width, viewHeight)];
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.bounces = false;
        self.scrollView.showsHorizontalScrollIndicator = false;
    }
    return _scrollView;
}


-(UIPageControl *)pagecontrol
{
    if (!_pagecontrol) {
        self.pagecontrol = [[UIPageControl alloc] initWithFrame:CGRectMake((SCREEN_width - 100)/2.0, viewHeight - 30, 100, 20)];
        self.pagecontrol.numberOfPages = 3;
        self.pagecontrol.pageIndicatorTintColor = [UIColor lightGrayColor];
        self.pagecontrol.currentPageIndicatorTintColor = [UIColor orangeColor];
    }
    return _pagecontrol;
}

-(void)createView{
    for (int i = 0; i < 3; i++) {
        UIView *view = [UIView new];
        view.frame = CGRectMake(i*SCREEN_width, 0, SCREEN_width, viewHeight);
        view.backgroundColor = [YAColor colorWithHexString:@"528CF5"];
        [self.scrollView addSubview:view];
    }
    self.scrollView.contentSize = CGSizeMake(SCREEN_width*3, viewHeight);
    self.scrollView.contentOffset = CGPointMake(0, 0);
   

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollWidth = self.scrollView.frame.size.width;
    NSInteger index = (self.scrollView.contentOffset.x + scrollWidth * 0.5) / scrollWidth;
    self.pagecontrol.currentPage = index;

}
@end
