//
//  ViewController.swift
//  CBPageView
//
//  Created by 陈博 on 2018/4/16.
//  Copyright © 2018年 陈博. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let titles = ["关注","推荐","热点","北京","视频","新时代"]
        var childVcs = [UIViewController]()
        for _ in 0..<titles.count {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            childVcs.append(vc)
        }
        
        let pageFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        
        let titleStyle = CBTitleStyle()
        
        
        let pageView = CBPageView(frame: pageFrame, titles: titles, childVcs: childVcs, parentVc: self, titleStyle: titleStyle)
        view .addSubview(pageView)
    }


}

