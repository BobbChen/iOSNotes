//
//  ViewController.swift
//  Swift-瀑布流
//
//  Created by 陈博 on 2018/4/24.
//  Copyright © 2018年 陈博. All rights reserved.
//

import UIKit
private let kContentCellID = "kContentCellID"
class ViewController: UIViewController {
    fileprivate lazy var collectionView : UICollectionView = {
       let layout = WaterFallLayout()
        
        // 设置列数
        let cols : CGFloat = 3
        // 设置item之间的间距
        let itemMargin : CGFloat = 8
        let itemWH = (self.view.bounds.width - (cols + 1) * itemMargin) / cols
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        layout.minimumLineSpacing = itemMargin
        layout.minimumInteritemSpacing = itemMargin
        
        
        // 设置内边距
        layout.sectionInset = UIEdgeInsets(top: itemMargin, left: itemMargin, bottom: itemMargin, right: itemMargin)
        
       let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        collectionView .register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        
    }

}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        cell.backgroundColor = UIColor.green
        return cell
    }
}

