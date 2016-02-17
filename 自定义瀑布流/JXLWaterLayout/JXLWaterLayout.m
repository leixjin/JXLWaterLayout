//
//  JXLWaterLayout.m
//  自定义瀑布流
//
//  Created by i mac on 16/2/16.
//  Copyright © 2016年 金小白. All rights reserved.
//

#import "JXLWaterLayout.h"

@interface JXLWaterLayout ()

@property (strong, nonatomic) NSMutableArray *maxYArray;

@property (strong, nonatomic) NSMutableArray <UICollectionViewLayoutAttributes *> *attArray;

@property (weak, nonatomic) id<UICollectionViewDelegateFlowLayout>delegate;

@end

@implementation JXLWaterLayout

- (void)prepareLayout {
    
    [super prepareLayout];

    //转屏情况下数据刷新处理
    [self.maxYArray removeAllObjects];
    [self.attArray removeAllObjects];
    
    //为了获取代理的尺寸
    self.delegate = (id)self.collectionView.delegate;
    
    //获取第一个item的宽度(纵向瀑布流宽度一致)
    CGFloat W = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]].width;
    
    //计算列数
    NSUInteger columnCount = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right) / W;
    
    //计算间距
    self.minimumInteritemSpacing = ((self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right) - (W * columnCount)) / (double)(columnCount - 1);
    
    //根据列数初始化数组
    for (int i = 0; i < columnCount; i++) {
        [self.maxYArray addObject:@(self.sectionInset.top)];
    }
    
    //组数
    NSInteger sectionCout = [self.collectionView numberOfSections];
    
    for (NSInteger section = 0; section < sectionCout; section++) {
        
        //每组item数
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        
        for (NSInteger item = 0; item < itemCount; item++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            UICollectionViewLayoutAttributes *att = [self layoutAttributesForItemAtIndexPath:indexPath];
            
            //获取item高度
            CGFloat H = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath].height;
            
            //最短的列
            int minColumn = 0;
            
            //初始化最短列的Y值
            CGFloat minY = [self.maxYArray[0] doubleValue];
            
            //找出最短的一列
            for (int i = 0; i < self.maxYArray.count; i++) {
                if ([self.maxYArray[i] doubleValue] < minY) {
                    minY = [self.maxYArray[i] doubleValue];
                    minColumn = i;
                }
            }
            
            //更新最大Y值数组
            [self.maxYArray replaceObjectAtIndex:minColumn withObject:@(minY + H + self.minimumLineSpacing)];
            
            //设置对应item位置
            att.frame = CGRectMake(self.sectionInset.left + (self.minimumInteritemSpacing + W) * minColumn, [self.maxYArray[minColumn] doubleValue] - H - self.minimumLineSpacing, W, H);
            
            [self.attArray addObject:att];
            
        }
    }
}

#pragma mark - 返回滚动范围

- (CGSize)collectionViewContentSize {
    
    CGFloat maxY = 0;
    for (id Y in self.maxYArray) {
        maxY = MAX([Y doubleValue], maxY);
    }
    
    return CGSizeMake(self.collectionView.frame.size.width, maxY + self.sectionInset.bottom);
}

#pragma mark - 返回布局设置

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return self.attArray;
}

#pragma mark - 懒加载

- (NSMutableArray<UICollectionViewLayoutAttributes *> *)attArray {
    if (!_attArray) {
        _attArray = [NSMutableArray array];
    }
    return _attArray;
}

- (NSMutableArray *)maxYArray {
    if (!_maxYArray) {
        _maxYArray = [NSMutableArray array];
    }
    return _maxYArray;
}

@end
