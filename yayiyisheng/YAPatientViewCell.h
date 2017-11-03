//
//  YAPatientViewCell.h
//  yayiyisheng
//
//  Created by hxp on 17/6/5.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAPatientModel.h"
@interface YAPatientViewCell : UITableViewCell
@property (nonatomic, weak)UIImageView *iconImageView;
@property (nonatomic, weak)UILabel *nameLab;
@property (nonatomic, weak)UILabel *titleLab;
@property (nonatomic, weak)UILabel *timeLab;
@property (nonatomic, weak)UILabel *stateLab;
@property (nonatomic, weak)UILabel *hLine;
@property (nonatomic, strong)YAPatientModel *model;
@end
