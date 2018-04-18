//
//  CBTitleView.swift
//  CBPageView
//
//  Created by 陈博 on 2018/4/16.
//  Copyright © 2018年 陈博. All rights reserved.
//

import UIKit
protocol CBPageViewDelegate: class {
    func pageView(_ pageView : CBTitleView, targetIndex : NSInteger)
}


class CBTitleView: UIView {
    fileprivate var titles : [String]
    fileprivate var style : CBTitleStyle
    
    weak var delegate : CBPageViewDelegate?
    
    fileprivate lazy var currentIndex: NSInteger = 0
    
    // 用于保存titleLabel
    fileprivate lazy var titleLabelArray: [UILabel] = [UILabel]()
    
    fileprivate lazy var scrollView:UIScrollView = {
        let scrollview = UIScrollView(frame: self.bounds)
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.scrollsToTop = false
        return scrollview
    }()
    init(frame: CGRect, titles: [String], style : CBTitleStyle) {
        self.titles = titles
        self.style = style
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension CBTitleView {
    fileprivate func setUpUI(){
        addSubview(scrollView)
        
        // 增加标题label
        setUpTitle()
        
        // 设置frame
        setUpTitleLabelFrame()
        
    }
    
    private func setUpTitle() {
        for(i, title) in titles.enumerated(){
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.textColor = i == 0 ? style.selectColor : style.normalColor
            titleLabel.font = UIFont.systemFont(ofSize: style.normalFont)
            titleLabel.textAlignment = .center
            titleLabel.tag = i;
            titleLabel.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapTitleLabelEvent(_:)))
            titleLabel .addGestureRecognizer(tapGes)
            scrollView.addSubview(titleLabel)
            titleLabelArray.append(titleLabel)
        }
    }
    
    private func setUpTitleLabelFrame() {
        let count = titles.count
        for (i, label) in titleLabelArray.enumerated() {
            var labelW : CGFloat = 0
            let labelH : CGFloat = bounds.height
            var labelX : CGFloat = 0
            let labelY : CGFloat = 0
            if style.isScrollEnable {
                labelW = (titles[i] as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0), options:.usesLineFragmentOrigin, attributes:[NSAttributedStringKey.font:label.font], context: nil).width
                if i == 0{
                    labelX = style.titleLabelMargin * 0.5
                }else{
                    let preLabel = titleLabelArray[i - 1]
                    labelX = preLabel.frame.maxX + style.titleLabelMargin
                }
            }else{
                labelW = bounds.width / CGFloat(count)
                labelX = labelW * CGFloat(i)
            }
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
        }
        scrollView.contentSize = style.isScrollEnable ? CGSize(width: titleLabelArray.last!.frame.maxX + style.titleLabelMargin * 0.5, height: 0) : CGSize.zero
    }
}
// MARK - tapTitleLabelEvent
extension CBTitleView {
    @objc fileprivate func tapTitleLabelEvent(_ tapGes : UITapGestureRecognizer){
        
        let targetLabel = tapGes.view as! UILabel
        
        adjustTitleLabel(targetIndex: targetLabel.tag)
        
        // 代理
        delegate?.pageView(self, targetIndex: targetLabel.tag)
        
        
    }
    
    fileprivate func adjustTitleLabel(targetIndex: Int) {
        let targetLabel = titleLabelArray[targetIndex]
        let preLabel = titleLabelArray[currentIndex]
        preLabel.textColor = style.normalColor
        targetLabel.textColor = style.selectColor
        currentIndex = targetLabel.tag
        // 调整位置
        if style.isScrollEnable {
            var offSet = targetLabel.center.x - scrollView.bounds.width * 0.5
            // 左边临界
            if offSet < 0 {
                offSet = 0
            }
            
            // 右边临界
            if offSet > (scrollView.contentSize.width - scrollView.bounds.width){
                offSet = scrollView.contentSize.width - scrollView.bounds.width
            }
            
            scrollView.setContentOffset(CGPoint(x: offSet, y: 0), animated: true)
        }


    }
}

extension CBTitleView: CBContentViewDelegate {
    func contentView(_ contentView: CBContentView, targetIndex: Int) {
        adjustTitleLabel(targetIndex: targetIndex)
    }
    func contentView(_ contentView: CBContentView, targetIndex: NSInteger, progress: CGFloat) {
        print(targetIndex)
        print(progress)
        
        let targetLabel = titleLabelArray[targetIndex]
        let preLabel = titleLabelArray[currentIndex]

        
        // 颜色渐变
        let detaRGB = UIColor.getRGBDelta(style.selectColor, style.normalColor)
        let selctRGB = style.selectColor.getRGB()
        let normalRGB = style.normalColor.getRGB()
        
        targetLabel.textColor = UIColor(r: normalRGB.0 + selctRGB.0 * progress, g: normalRGB.1 + selctRGB.1 * progress, b: normalRGB.2 + selctRGB.2 * progress)
        preLabel.textColor = UIColor(r:selctRGB.0 - detaRGB.0 * progress , g: selctRGB.1 - detaRGB.1 * progress, b: selctRGB.2 - detaRGB.2 * progress)
        
        
    }
}
