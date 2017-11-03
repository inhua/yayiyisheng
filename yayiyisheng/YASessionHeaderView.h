//
//  YASessionHeaderView.h
//  yayiyisheng
//
//  Created by hxp on 17/6/5.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YASessionModel.h"

typedef void(^YAHeaderViewExpandCallback)(BOOL  isExpand);

@interface YASessionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong)YASessionModel *model;

@property (nonatomic, copy)YAHeaderViewExpandCallback callback;

@property (nonatomic, strong)YASessionModel *lastModel;


@end
