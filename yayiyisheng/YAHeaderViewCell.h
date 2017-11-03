//
//  YAHeaderViewCell.h
//  yayiyisheng
//
//  Created by hxp on 17/6/2.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAHomeheaderView.h"
@interface YAHeaderViewCell : UITableViewCell
@property (nonatomic, weak)YAHomeheaderView *headerView;
@property (nonatomic, weak)UIButton *todayBtn;
@property (nonatomic, weak)UIButton *tomorrowBtn;
@property (nonatomic, weak)UIButton *historyBtn;
@property (nonatomic, weak)UILabel *vLine1;
@property (nonatomic, weak)UILabel *vLine2;

@end
