//
//  YASessionModel.h
//  yayiyisheng
//
//  Created by hxp on 17/6/5.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YASessionModel : NSObject
@property (nonatomic, copy)NSString *title;
@property (nonatomic, assign)NSInteger isExpanded;
@property (nonatomic, strong)NSMutableArray *cellModels;

@end
