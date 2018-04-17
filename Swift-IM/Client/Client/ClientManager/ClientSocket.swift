//
//  ClientSocket.swift
//  Client
//
//  Created by 陈博 on 2018/4/7.
//  Copyright © 2018年 陈博. All rights reserved.
//

import UIKit

class ClientSocket: NSObject {
    fileprivate var tcpClient:TCPClient
    init(addr : String, port : Int) {
        tcpClient = TCPClient(addr: addr, port: port)
    }
}
extension ClientSocket{
    
    func connectServer() -> Bool {
        return tcpClient.connect(timeout: 15).0
    }
}
