//
//  YASessionHeaderView.m
//  yayiyisheng
//
//  Created by hxp on 17/6/5.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YASessionHeaderView.h"

@interface  YASessionHeaderView ()
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *countLab;

@end

@implementation YASessionHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat w = [UIScreen mainScreen].bounds.size.width;
        self.arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"brand_expand"]];
        self.arrowImageView.frame = CGRectMake(10, (44 - 8) / 2, 15, 8);
        [self.contentView addSubview:self.arrowImageView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(onExpand:)forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        button.frame = CGRectMake(0, 0, w, 44);
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, 0, 200, 44)];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.titleLabel];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        
        self.countLab = [UILabel new];
        self.countLab.textColor = [YAColor colorWithHexString:@"528CF5"];
        self.countLab.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.countLab];
        
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 44 - 0.5, w, 0.5)];
        line.backgroundColor = [YAColor YALineColor];
        [self.contentView addSubview:line];
    }
    return self;

}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@20);
    }];

}
- (void)setModel:(YASessionModel *)model {
    if (_model != model) {
        _model = model;
    }
    self.countLab.text = [NSString stringWithFormat:@"%ld人",model.cellModels.count];
    
    if (model.isExpanded) {
        self.arrowImageView.transform = CGAffineTransformIdentity;
    } else {
        self.arrowImageView.transform = CGAffineTransformMakeRotation(-M_PI/2);
    }
    
    
    self.titleLabel.text = model.title;
}

- (void)onExpand:(UIButton *)sender {
    self.model.isExpanded = !self.model.isExpanded;
    
    [UIView animateWithDuration:0.25 animations:^{
        if (self.model.isExpanded) {
            self.arrowImageView.transform = CGAffineTransformIdentity;
        } else {
            self.arrowImageView.transform = CGAffineTransformMakeRotation(-M_PI/2);
        }
    }];
   
    if (self.callback) {
        self.callback(self.model.isExpanded);
    }
    
    
}

@end
