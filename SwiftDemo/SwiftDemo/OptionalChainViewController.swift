//
//  OptionalChainViewController.swift
//  SwiftDemo
//
//  Created by 侨品汇 on 2017/11/29.
//  Copyright © 2017年 陈博. All rights reserved.
//

import UIKit

class OptionalChainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let roomCount = Peron()
        print("\(roomCount.residence?.numberOfRooms ?? 1)")
        
    }
}
class Peron {
    var residence: Residence?
    
}
class Residence {
    let numberOfRooms = 1
}
