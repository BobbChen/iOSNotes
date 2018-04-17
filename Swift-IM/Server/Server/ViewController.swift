//
//  ViewController.swift
//  Server
//
//  Created by 陈博 on 2018/4/7.
//  Copyright © 2018年 陈博. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var statusLabel: NSTextField!
    // 懒加载
    fileprivate lazy var serverMgr : ServerManager = ServerManager()
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func startServer(_ sender: NSButton) {
        
        
        serverMgr.startRunning()
        statusLabel.stringValue = "开启服务器"
    }
    
    @IBAction func stopServer(_ sender: NSButton) {
        serverMgr.stopRunning()
        statusLabel.stringValue = "停止服务器"
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

