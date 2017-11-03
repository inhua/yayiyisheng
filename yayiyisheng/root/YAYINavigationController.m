//
//  YAYINavigationController.m
//  YAYIDoctor
//
//  Created by hxp on 16/4/28.
//  Copyright © 2016年 hxp. All rights reserved.
//

#import "YAYINavigationController.h"

@interface YAYINavigationController () <UIGestureRecognizerDelegate>

@end

@implementation YAYINavigationController

/**
 * 当第一次使用这个类的时候会调用一次
 */
+ (void)initialize
{
    //    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    
    
    
    UINavigationBar *bar = [UINavigationBar appearance];
    
    [bar setBackgroundImage:[UIImage  imageWithColor:YAYIColorAlpha(255, 255, 255, 0.99)] forBarMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[UIImage new]];

    
    
    
    
    bar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:16*(SCREEN_height / 568.0)]};
    
   
    
    
    
    
//    bar.translucent = NO;
}
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏黑线
    
    UIImageView *navBarHairlineImageView;
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationBar];
    navBarHairlineImageView.hidden = YES;
    
    [self dropShadowWithOffset:CGSizeMake(0, -0.5)
                        radius:1
                         color:[UIColor grayColor]
                       opacity:0.3];
     
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // 1.创建全屏手势
    UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    
    // 控制手势什么时候触发
    edgePan.delegate = self;
    edgePan.edges = UIRectEdgeLeft;
    // 全屏滑动返回
    [self.view addGestureRecognizer:edgePan];
    
    // 2.禁止边缘手势
    self.interactivePopGestureRecognizer.enabled = NO;
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[SVProgressHUD dismiss];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   

}
- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {
    
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.navigationBar.bounds);
    self.navigationBar.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.navigationBar.layer.shadowColor = color.CGColor;
    self.navigationBar.layer.shadowOffset = offset;
    self.navigationBar.layer.shadowRadius = radius;
    self.navigationBar.layer.shadowOpacity = opacity;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.navigationBar.clipsToBounds = NO;
}
/**
 * 可以在这个方法中拦截所有push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"back_button"] forState:UIControlStateNormal];
        //button.backgroundColor = [UIColor orangeColor];
        button.frame = (CGRect){{0, 0}, CGSizeMake(70, 30)};
        
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //        [button sizeToFit];
        // 让按钮的内容往左边偏移10
        //        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        // 修改导航栏左边的item
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
      
//        UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
//        temporaryBarButtonItem.title = @"dd";
//        viewController.navigationItem.backBarButtonItem = temporaryBarButtonItem;
        
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
        
    }
    
    
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
}




-(void)setitle:(NSString *)title
{
    UILabel *titleView = [[UILabel  alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    titleView.textColor = [UIColor  whiteColor];
    titleView.text = title;
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.font = [UIFont  systemFontOfSize:18 weight:0];
    self.navigationItem.titleView = titleView;
}

- (void)back
{
   // [SVProgressHUD dismiss];
    [self popViewControllerAnimated:YES];
    
    
}


#pragma mark - UIGestureRecognizerDelegate
// 控制手势是否触发
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        // 根控制器的时候
        return self.childViewControllers.count != 1;
    }
    
    return YES;
}


@end
