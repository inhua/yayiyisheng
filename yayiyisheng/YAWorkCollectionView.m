//
//  YAWorkCollectionView.m
//  yayiyisheng
//
//  Created by hxp on 17/6/1.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAWorkCollectionView.h"

@interface  YAWorkCollectionView ()  <UICollectionViewDelegate,UICollectionViewDataSource>
// 流水布局
@property (nonatomic,strong) UICollectionViewFlowLayout *layout;

@end

static NSString *const cellreuseIdentifier = @"workCell";
@implementation YAWorkCollectionView

- (instancetype)init {
    
    
    if (self = [super initWithFrame:CGRectZero collectionViewLayout:self.layout]) {
        self.dataSource = self;
        self.delegate = self;
        self.scrollEnabled = false;
        [self registerClass:[YAWorkCollectionViewCell class] forCellWithReuseIdentifier:cellreuseIdentifier];
        self.delaysContentTouches = false;  
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
    
}

#pragma mark - setter & getter

- (void)setItemSize:(CGSize)itemSize
{
    _itemSize = itemSize;
    self.layout.itemSize = itemSize;
}

#pragma mark - UICollcetionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataAry.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath

{

    YAWorkCollectionViewCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:cellreuseIdentifier forIndexPath:indexPath];

    cell.model = self.dataAry[indexPath.item];
   //NSLog(@"%@",self.dataAry[indexPath.item]);
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_delgate && [_delgate respondsToSelector:@selector(didSelectedItem:)]) {
        YAWorkModel *model = self.dataAry[indexPath.item];
        [_delgate didSelectedItem:model.deClass];
    }
}
-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
     YAWorkCollectionViewCell *cell = (YAWorkCollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [YAColor YABackgroundColor];
}
-(void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    YAWorkCollectionViewCell *cell = (YAWorkCollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}
- (UICollectionViewFlowLayout *)layout
{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        // 设置水平滚动
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _layout.minimumLineSpacing = 1;
        _layout.minimumInteritemSpacing = 1;
        
    }
    return _layout;
}

@end
