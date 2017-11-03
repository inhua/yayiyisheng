//
//  YAWorkCollectionViewCell.h
//  yayiyisheng
//
//  Created by hxp on 17/6/1.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAWorkModel.h"


@interface YAWorkCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak)UIView *grayView;
@property (nonatomic, weak)UIImageView *imageView;
@property (nonatomic, weak)UILabel *titleLab;
@property (nonatomic, strong)YAWorkModel *model;

@end
