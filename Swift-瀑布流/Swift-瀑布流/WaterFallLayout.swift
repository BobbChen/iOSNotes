//
//  WaterFallLayout.swift
//  Swift-瀑布流
//
//  Created by 陈博 on 2018/4/24.
//  Copyright © 2018年 陈博. All rights reserved.
//

import UIKit

class WaterFallLayout: UICollectionViewFlowLayout {
    fileprivate lazy var cellAttrs: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
    // 初始的时候,三列的高度都是内边距的高度
    fileprivate lazy var totalHeight : [CGFloat] = Array(repeating: self.sectionInset.top, count: 3)

}
// MARK:- 准备布局
extension WaterFallLayout {
    override func prepare() {
        super.prepare()
        
        
        // 获取lItem的个数
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        // 为每一个item 创建对应的 UICollectionViewLayoutAttributes
        
        let cellW: CGFloat = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - 2 * minimumInteritemSpacing) / 3

        
        for i in 0 ..< itemCount{
            let indexPath = IndexPath(item: i, section: 0)
            // 通过indexPath为每个item创建UICollectionViewLayoutAttributes
            let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            // 设置item的frame
            let cellH: CGFloat = CGFloat(arc4random_uniform(150)) + 150
            
            // x的位置要放到高度最小的那一列
            let minH = totalHeight.min()!
            // 根据最小的高度找到对应的列
            let minIndex = totalHeight.index(of: minH)!
            
            let cellX: CGFloat = (sectionInset.left + (cellW + minimumInteritemSpacing) * CGFloat(minIndex))
            
            let cellY: CGFloat = minH + minimumLineSpacing

            attr.frame = CGRect(x: cellX, y: cellY, width: cellW, height: cellH)
            
            // 保存attr
            cellAttrs.append(attr)
            
            
            // 将所添加的这一列的高度添加到数组高度数组中
            totalHeight[minIndex] = minH + cellH + minimumInteritemSpacing
            
        }
    }
    
}
// MARK:- 返回布局
extension WaterFallLayout {
    // 为每个元素进行布局
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            return cellAttrs
    }
}

// MARK:- 重新设置滚动区域contentSize
extension WaterFallLayout {
    override var collectionViewContentSize: CGSize{
        return CGSize(width: 0, height: totalHeight.max()!+sectionInset.bottom)
    }
    
}


