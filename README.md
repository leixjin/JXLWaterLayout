# JXLWaterLayout



###一款毫无入侵性的瀑布流布局文件,目前仅支持纵向瀑布流。

##How To Use:

傻瓜式使用    
1.创建布局文件，初始化UICollectionView的时候传入布局文件。   
2.实现'UICollectionView'以下代理方法即可。

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {    
//返回item的尺寸。    
}    

##To Do
- 支持横向瀑布流。
- 性能进一步优化。
- 代码精简。
