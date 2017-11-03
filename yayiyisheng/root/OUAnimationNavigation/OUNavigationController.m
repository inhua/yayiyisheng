//
//  OUNavigationController.m
//  GWL
//
//  Created by oujinlong on 16/6/1.
//  Copyright © 2016年 oujinlong. All rights reserved.
//

#import "OUNavigationController.h"


@interface OUNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic, assign) CGRect origionRect;
@property (nonatomic, assign) CGRect desRect;
@property (nonatomic, assign) BOOL isPush;
@property (nonatomic, weak) id  animationDelegate;

@end

@implementation OUNavigationController


+ (void)initialize
{
    //    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    UINavigationBar *bar = [UINavigationBar appearance];
//    [bar setBackgroundImage:[UIImage  imageNamed:@"navagation_alphaBg"] forBarMetrics:UIBarMetricsDefault];
    
    bar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont  systemFontOfSize:18 weight:0]};
    //    bar.translucent = NO;
    
    // 去掉底部黑边
    
    bar.shadowImage = [[UIImage alloc] init];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.创建全屏手势
//    UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
//    
//    // 控制手势什么时候触发
//    edgePan.delegate = self;
//    edgePan.edges = UIRectEdgeLeft;
//    // 全屏滑动返回
//    [self.view addGestureRecognizer:edgePan];
//    
//    // 2.禁止边缘手势
//    self.interactivePopGestureRecognizer.enabled = NO;
}



- (void)presentViewController:(UIViewController *)viewController withImageView:(UIImageView *)imageView desRect:(CGRect)desRect delegate:(id<OUNavAnimationDelegate>)delegate
{
    
//    self.delegate = self;
//    self.imageView = imageView;
//    self.origionRect = imageView.frame;//[imageView convertRect:imageView.frame toView:self.view];
//    self.desRect = desRect;
//    self.isPush = YES;
//    self.animationDelegate = delegate;
    
    [super presentViewController:viewController animated:YES completion:nil];
}


-(void)pushViewController:(UIViewController *)viewController withImageView:(UIImageView *)imageView desRect:(CGRect)desRect delegate:(id<OUNavAnimationDelegate>)delegate{
    
    self.delegate = self;
    self.imageView = imageView;
    self.origionRect = [imageView convertRect:imageView.frame toView:self.view];
    self.desRect = desRect;
    self.isPush = YES;
    self.animationDelegate = delegate;
    
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"back_button"] forState:UIControlStateNormal];
        
        button.frame = (CGRect){{0, 0}, CGSizeMake(70, 30)};
        
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //        [button sizeToFit];
        // 让按钮的内容往左边偏移10
        //        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        // 修改导航栏左边的item
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    
    [super pushViewController:viewController animated:YES];
}


-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    self.isPush = NO;
    //self.transition
   return  [super popViewControllerAnimated:animated];
}


-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    OUNavAnimation* animation = [[OUNavAnimation alloc] init];
    
    animation.imageView = self.imageView;

    animation.origionRect = self.origionRect;
    
    animation.desRect = self.desRect;
    
    animation.isPush = self.isPush;
    
    animation.delegate = self.animationDelegate;
    
    if (!self.isPush && self.delegate) {
        self.delegate = nil;
    }
    return animation;
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
    //    [SVProgressHUD dismiss];
    [self popViewControllerAnimated:YES];
    
    
}




#pragma mark - UIGestureRecognizerDelegate
// 控制手势是否触发
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        // 根控制器的时候
        return NO;
    }
    
    return YES;
}


@end
