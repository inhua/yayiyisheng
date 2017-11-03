//
//  YAWorkCollectionViewCell.m
//  yayiyisheng
//
//  Created by hxp on 17/6/1.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAWorkCollectionViewCell.h"

@implementation YAWorkCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createViews];
       
    }
    return self;
}






-(void)setModel:(YAWorkModel *)model
{
    _model = model;
    
    self.titleLab.text = model.title;
    self.imageView.image = [UIImage imageNamed:model.name];

}

-(void)createViews{
    
    UIView *grayView = [UIView new];
    grayView.backgroundColor = [YAColor YABackgroundColor];
    self.grayView = grayView;
    grayView.alpha = 0;
    [self.contentView addSubview:grayView];
    
    UILabel *label = [UILabel new];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    self.titleLab = label;
    [self.contentView addSubview:label];
    
    UIImageView *imageView = [UIImageView  new];
    self.imageView = imageView;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:imageView];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.width.mas_equalTo(self.contentView.mas_width);
        make.height.mas_equalTo(self.contentView.mas_height);
    }];
    
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.equalTo(@20);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(8);
        make.left.equalTo(@0);
        make.height.equalTo(@16);
        make.width.equalTo(self.contentView.mas_width);

    }];
     
    
}



@end
