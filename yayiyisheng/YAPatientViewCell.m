//
//  YAPatientViewCell.m
//  yayiyisheng
//
//  Created by hxp on 17/6/5.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAPatientViewCell.h"

@implementation YAPatientViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;

}
-(void)setModel:(YAPatientModel *)model
{
    _model = model;
    self.titleLab.text = @"李四：回访";
    self.timeLab.text = @"2017/6/8";
    self.stateLab.text = @"治疗";
}
-(void)createView{
    UIImageView *icon = [UIImageView new];
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = 5;
    self.iconImageView = icon;
    icon.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:icon];
    
    UILabel *nameLab = [UILabel new];
    nameLab.textColor = [UIColor blackColor];
    nameLab.font = [UIFont systemFontOfSize:15];
    self.nameLab = nameLab;
    [self.contentView addSubview:nameLab];
    
    UILabel *titleLab = [UILabel new];
    titleLab.font = [UIFont systemFontOfSize:13];
    titleLab.textColor = [UIColor lightGrayColor];
    self.titleLab = titleLab;
    
    [self.contentView addSubview:titleLab];
    
    UILabel *timeLab = [UILabel new];
    timeLab.font = [UIFont systemFontOfSize:12];
    timeLab.textColor = [UIColor lightGrayColor];
    self.timeLab = timeLab;
    [self.contentView addSubview:timeLab];
    
    UILabel *stateLab = [UILabel new];
    stateLab.textColor = [UIColor whiteColor];
    stateLab.font = [UIFont systemFontOfSize:10];
    stateLab.textAlignment = NSTextAlignmentCenter;
    stateLab.layer.cornerRadius = 8.f;
    stateLab.clipsToBounds = YES;
    stateLab.backgroundColor = [YAColor colorWithHexString:@"528CF5"];
    self.stateLab = stateLab;
    [self.contentView addSubview:stateLab];
    
    UILabel *hLine = [UILabel new];
    hLine.backgroundColor = [YAColor YALineColor];
    self.hLine = hLine;
    [self.contentView addSubview:hLine];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(8);
        make.top.mas_equalTo(self.iconImageView.mas_top).offset(4);
        make.height.mas_equalTo(15);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLab.mas_left);
        make.bottom.mas_equalTo(self.iconImageView.mas_bottom).offset(-4);
        make.height.mas_equalTo(15);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.titleLab.mas_bottom);
        make.height.mas_equalTo(15);
    }];
    
    [self.stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(self.nameLab.mas_top);
        make.height.mas_equalTo(16);
        make.width.equalTo(@50);
    }];
    
    [self.hLine  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.left.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_width, 0.5));
    }];
    
}

@end
