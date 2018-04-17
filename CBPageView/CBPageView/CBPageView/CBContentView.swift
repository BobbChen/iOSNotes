//
//  CBContentView.swift
//  CBPageView
//
//  Created by 陈博 on 2018/4/16.
//  Copyright © 2018年 陈博. All rights reserved.
//

import UIKit
private let kContentCellID = "kContentCellID"
class CBContentView: UIView {
    fileprivate var childVcs: [UIViewController]
    fileprivate var parentVc: UIViewController
    // 懒加载
    fileprivate lazy var titleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        layout.itemSize = self.bounds.size
        let titleCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        titleCollectionView.dataSource = self
        titleCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        
        return titleCollectionView
    }()
    init(frame: CGRect, childVcs: [UIViewController], parentVc: UIViewController) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        super.init(frame: frame)
        titleCollectionView.isPagingEnabled = true
        titleCollectionView.bounces = false
        titleCollectionView.scrollsToTop = false
        setUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CBContentView{
    fileprivate func setUI() {
        // 添加子控制器到父控制器
        for childVc in childVcs {
            parentVc.addChildViewController(childVc)
        }
        
        addSubview(titleCollectionView)
    }
}



// MARK - UICollectionViewDelegate && UICollectionViewDataSource
extension CBContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let chiladVc = childVcs[indexPath.row]
        chiladVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(chiladVc.view)
        return cell
     }
}
// MARK: - CBTitleViewDlegate
extension CBContentView : CBPageViewDelegate{
    func pageView(_ pageView: CBTitleView, targetIndex: NSInteger) {
        let indexPath  =  IndexPath(item: targetIndex, section: 0)
        titleCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
}

