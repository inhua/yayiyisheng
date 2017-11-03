//
//  YAWorkViewCell.m
//  yayiyisheng
//
//  Created by hxp on 17/6/1.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAWorkViewCell.h"

@implementation YAWorkViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;

}

-(void)createView{
    
    UIView *tipView = [UIView new];
    self.tipView = tipView;
    [self.contentView  addSubview:tipView];
    
    UIImageView *iconView = [UIImageView new];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    self.iconView = iconView;
    [tipView addSubview:iconView];
    
    UILabel *titlab = [UILabel new];
    titlab.textColor = [UIColor blackColor];
    titlab.text = @"我的工作台";
    titlab.font = [UIFont systemFontOfSize:14];
    self.titleLab = titlab;
    [tipView addSubview:titlab];
    
    UILabel *hLine = [UILabel new];
    hLine.backgroundColor = [YAColor YALineColor];
    self.hLine = hLine;
    [tipView addSubview:hLine];
    
    
    CGFloat width = (SCREEN_width - 2) / 3.0;
    self.collectionView = [[YAWorkCollectionView alloc] init];
    self.collectionView.delgate = self;
    self.collectionView.itemSize = CGSizeMake(width, 330/3);
    self.collectionView.frame = CGRectMake(0, 50, SCREEN_width, 330);
    //self.collectionView.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:self.collectionView];
    

}
-(void)setDataAry:(NSMutableArray *)dataAry
{
    
    self.collectionView.dataAry =dataAry;
    //[self.collectionView reloadData];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_width, 40));
    }];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.mas_equalTo(self.tipView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(10, 10));
        
        
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(18);
        make.centerY.mas_equalTo(self.tipView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 10));
    }];
    [self.hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.mas_equalTo(self.tipView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_width, 0.5));
    }];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
-(void)didSelectedItem:(Class)cotrollView
{
   
    
    [self.controller.navigationController pushViewController:[cotrollView new] animated:YES];
}
@end
