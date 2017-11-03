//
//  YAWorkViewCell.h
//  yayiyisheng
//
//  Created by hxp on 17/6/1.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAWorkCollectionView.h"
@interface YAWorkViewCell : UITableViewCell <YAWorkCollectionViewDelegate>
@property (nonatomic, strong)NSMutableArray *dataAry;
@property (nonatomic, strong)UIViewController *controller;
@property (nonatomic, strong)YAWorkCollectionView *collectionView;

@property (nonatomic, weak)UIView *tipView;
@property (nonatomic, weak)UILabel *titleLab;
@property (nonatomic, weak)UILabel *hLine;
@property (nonatomic, weak)UIImageView *iconView;
@property (nonatomic, weak)UIButton *button;
@end
