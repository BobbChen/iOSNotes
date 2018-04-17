//
//  ViewController.swift
//  Client
//
//  Created by 陈博 on 2018/4/7.
//  Copyright © 2018年 陈博. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    fileprivate lazy var client : ClientSocket = ClientSocket(addr: "192.168.10.101", port: 7878)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if client.connectServer(){
            print("!!!!!")
        }
    }
}

