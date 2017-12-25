//
//  UserDataManger.swift
//  xueji
//
//  Created by lvxin on 2017/12/25.
//  Copyright © 2017年 lvxin. All rights reserved.
//  用户信息管理

import UIKit
import KeychainSwift
let TOKENSTR = "token"


class UserDataManger: NSObject {
    var addQuery : NSMutableDictionary!
    var token : String!
    
    static  func storeTokenInChain(token : String) {
        XJLog(message: "token储存---\(token)")
        let keychain = KeychainSwift()
        keychain.synchronizable = true
        keychain.set(token, forKey: TOKENSTR)
        
    }
    
    static func getTokenFromChain() -> String? {
        let keychain = KeychainSwift()
        keychain.synchronizable = true
        let str = keychain.get(TOKENSTR)
        XJLog(message: str)
        return str
    }
    
    static func delChain() {
        let keychain = KeychainSwift()
        keychain.synchronizable = true
//        let ok = keychain.delete(TOKENSTR)
        let ok = keychain.clear()
        if ok {
            XJLog(message: "清除成功")
        }else {
            XJLog(message: "清除失败")

        }
    }
}
