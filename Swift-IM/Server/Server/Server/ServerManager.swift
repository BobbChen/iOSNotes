//
//  ServerManager.swift
//  Server
//
//  Created by 陈博 on 2018/4/7.
//  Copyright © 2018年 陈博. All rights reserved.
//

import Cocoa

class ServerManager: NSObject {
    fileprivate lazy var serverSocket : TCPServer = TCPServer(addr: "192.168.10.101", port: 7878)
}
extension ServerManager{
    func startRunning(){
        
        // 开始监听
        serverSocket.listen()
        
        // 接收客户端,可选类型，该方法会阻塞当前线程,放入子线程
        if let client = self.serverSocket.accept() {
            
            
            print("接收到一个客户端!")
        }

        
        
    }
    func stopRunning(){
        
    }
}
