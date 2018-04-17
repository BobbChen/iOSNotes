//
//  CBTitleView.swift
//  CBPageView
//
//  Created by 陈博 on 2018/4/16.
//  Copyright © 2018年 陈博. All rights reserved.
//

import UIKit

class CBTitleView: UIView {
    fileprivate var titles : [String]
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
