//
//  OUNavAnimation.m
//  GWL
//
//  Created by oujinlong on 16/6/1.
//  Copyright © 2016年 oujinlong. All rights reserved.
// OJL

#import "OUNavAnimation.h"
//#import "DetailViewController.h"
@interface OUNavAnimation ()

@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation OUNavAnimation


-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    if (self.isPush) {
        [self push:transitionContext];
    }else{
        [self pop:transitionContext];
    }
}


#pragma mark - Private
- (void)push:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView* contentView = [transitionContext containerView];
    
    // 清除以前的view
    for (UIView *subView in contentView.subviews) {
        
        if (subView.tag == 1000) {
            
            [subView removeFromSuperview];
        }
    }
    
    
    contentView.backgroundColor = [UIColor grayColor];
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    // 对fromVC.view的截图添加动画效果
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.tag = 1000;
    tempView.frame = fromVC.view.frame;
    
    UIView *tempNavBar = [fromVC.navigationController.navigationBar snapshotViewAfterScreenUpdates:NO];
    tempNavBar.frame = CGRectMake(0, 0, SCREEN_width, 44);
    [tempView addSubview:tempNavBar];
    
    
    __block UIImageView* imageView = [[UIImageView alloc] initWithImage:self.imageView.image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.frame = self.isPush ? self.origionRect : self.desRect;
    imageView.backgroundColor = self.imageView.backgroundColor;
    
    //    toVc.view.alpha = 0;
    
    // 对截图添加动画，则fromVC可以隐藏
    fromVC.view.hidden = YES;
    // 要实现转场，必须加入到containerView中
    [contentView addSubview:tempView];
    [contentView addSubview:toVc.view];
    toVc.view.alpha = 0;
    
    [contentView addSubview:imageView];
    [UIView animateWithDuration:0.2 animations:^{
        toVc.view.alpha = 1.0f;
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        // 让截图缩放
        tempView.center = fromVC.view.center;
        tempView.transform = CGAffineTransformMakeScale(0.8, 0.8);
        imageView.frame = self.isPush ? self.desRect : self.origionRect;
    } completion:^(BOOL finished) {
        
        if ([self.delegate respondsToSelector:@selector(didFinishTransition)] && self.isPush) {
            [self.delegate didFinishTransition];
        }
        
        [transitionContext completeTransition:YES];
        
        [imageView removeFromSuperview];
        imageView = nil;
    }];
}

- (void)pop:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView* contentView = [transitionContext containerView];
    contentView.backgroundColor = [UIColor grayColor];
    
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 取出present时的截图用于动画
    UIView *tempView = contentView.subviews.firstObject;
    
    
    __block UIImageView* imageView = [[UIImageView alloc] initWithImage:self.imageView.image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.frame = self.desRect;
    imageView.backgroundColor = self.imageView.backgroundColor;
    
    //    toVc.view.alpha = 0;
    
    // 对截图添加动画，则fromVC可以隐藏
//    fromVC.view.hidden = YES;
    // 要实现转场，必须加入到containerView中
    [contentView addSubview:toVc.view];
    toVc.view.hidden = YES;
    toVc.view.alpha = 0;
    
    [contentView addSubview:imageView];
    [UIView animateWithDuration:0.3 animations:^{
        toVc.view.alpha = 1.0f;
    }];
    
    UIImage* image = nil;
    if (!self.isPush) {
        image = [self.imageView.image copy];
        self.imageView.image = nil;
    }
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        // 让截图缩放
        tempView.transform = CGAffineTransformIdentity;
        tempView.y = 0;
        imageView.frame = self.origionRect;
    } completion:^(BOOL finished) {
        
        if ([self.delegate respondsToSelector:@selector(didFinishTransition)] && self.isPush) {
            [self.delegate didFinishTransition];
        }
        
        [transitionContext completeTransition:YES];
        toVc.view.hidden = NO;
        
        // 将截图去掉
        [tempView removeFromSuperview];
        [imageView removeFromSuperview];
        self.imageView.image = image;
        imageView = nil;
    }];
}


@end
