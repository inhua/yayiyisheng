//
//  YAWorkCollectionView.h
//  yayiyisheng
//
//  Created by hxp on 17/6/1.
//  Copyright © 2017年 achego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAWorkCollectionViewCell.h"


@protocol  YAWorkCollectionViewDelegate <NSObject>

-(void)didSelectedItem:(Class)cotrollView;

@end

@interface YAWorkCollectionView : UICollectionView

@property (nonatomic, weak)id <YAWorkCollectionViewDelegate>delgate;

@property (nonatomic, strong)NSMutableArray *dataAry;

@property (nonatomic,assign) CGSize itemSize;
@end

