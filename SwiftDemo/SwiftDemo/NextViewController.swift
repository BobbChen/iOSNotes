//
//  NextViewController.swift
//  SwiftDemo
//
//  Created by 侨品汇 on 2017/11/27.
//  Copyright © 2017年 陈博. All rights reserved.
//

import UIKit


class NextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        
        //MARK: 方法
        let count = Counter()
        count.increment()
        count.increment(by: 5)
        count.reset()
    }
}
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count  = 0
    }
}

