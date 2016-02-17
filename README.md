# JXLWaterLayout

##目前仅支持纵向瀑布流

#How To Use:
使用简单，创建布局文件，直接赋值给'UICollectionView'。
实现'UICollectionView'以下代理方法即可。

'''objc
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//返回item的尺寸。
}
'''
