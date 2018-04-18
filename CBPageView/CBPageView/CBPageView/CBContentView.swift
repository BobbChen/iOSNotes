//
//  CBContentView.swift
//  CBPageView
//
//  Created by 陈博 on 2018/4/16.
//  Copyright © 2018年 陈博. All rights reserved.
//

import UIKit
private let kContentCellID = "kContentCellID"

protocol CBContentViewDelegate: class {
    func contentView(_ contentView: CBContentView, targetIndex: Int)
    func contentView(_ contentView : CBContentView, targetIndex : NSInteger, progress: CGFloat)

}

class CBContentView: UIView {
    fileprivate var childVcs: [UIViewController]
    fileprivate var parentVc: UIViewController
    
    // 初始偏移值
    fileprivate var startOffSetX: CGFloat = 0
    
    // 懒加载
    weak var delegate: CBContentViewDelegate?
    
    fileprivate lazy var titleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        layout.itemSize = self.bounds.size
        let titleCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        titleCollectionView.dataSource = self
        titleCollectionView.delegate = self
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



// MARK -  UICollectionViewDataSource
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

// MARK - UICollectionViewDelegate
extension CBContentView: UICollectionViewDelegate {
    // 停止减速
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        contentViewEndScroll()
    }
    // 结束拖动
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // 如果没有减速过程
        if !decelerate {
            contentViewEndScroll()
        }
    }
    // 开始拖拽 将此刻的偏移量记录下来，用来进行比较而判断左划右滑
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffSetX = scrollView.contentOffset.x

    }
    
    // 将滑动的进度delegate出去
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 如果相等 return 因为未发生偏移
        guard startOffSetX != scrollView.contentOffset.x else {
            return
        }
        var targetIndex = 0
        var progress: CGFloat = 0
        
        if startOffSetX < scrollView.contentOffset.x {
            // 左划
            targetIndex = Int(startOffSetX / titleCollectionView.bounds.width) + 1
            if targetIndex > (childVcs.count - 1) {
                targetIndex = childVcs.count - 1
            }
            progress = (scrollView.contentOffset.x - startOffSetX) / titleCollectionView.bounds.width
            
            
        }else{
            // 右划
            targetIndex = Int(startOffSetX / titleCollectionView.bounds.width) - 1
            // 一定要判断是否越界
            if targetIndex < 0 {
                targetIndex = 0
            }
            progress = (startOffSetX - scrollView.contentOffset.x) / titleCollectionView.bounds.width
        }
        delegate?.contentView(self, targetIndex: targetIndex, progress: progress)
        
    }
    
    
    
    private func contentViewEndScroll() {
        let currentIndex = Int(titleCollectionView.contentOffset.x / titleCollectionView.bounds.width)
        delegate?.contentView(self, targetIndex: currentIndex)
    }
    
    
    
    
}


// MARK: - CBTitleViewDlegate
extension CBContentView : CBPageViewDelegate{
    func pageView(_ pageView: CBTitleView, targetIndex: NSInteger) {
        let indexPath  =  IndexPath(item: targetIndex, section: 0)
        titleCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
}

