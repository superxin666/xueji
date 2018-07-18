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

let TOKENUDSTR = "LOGININTOKEN"
let LOGINUDSTR = "LOGININLOGINID"
let ISLOGINSTR = "ISHAVELOGIN"
let ShowRecentStudy = "setShowRecentStudy"

class UserDataManger: NSObject {
    var addQuery : NSMutableDictionary!
    var token : String!
    
    //MARK: chain 部分
    
    /// 储存token到keychain中
    ///
    /// - Parameter token: <#token description#>
    static  func storeTokenInChain(token : String) {
        XJLog(message: "token储存---\(token)")
        let keychain = KeychainSwift()
        keychain.synchronizable = true
        keychain.set(token, forKey: TOKENSTR)
        
    }
    
    /// 获取chain 中的 token
    ///
    /// - Returns: <#return value description#>
    static func getTokenFromChain() -> String? {
        let keychain = KeychainSwift()
        keychain.synchronizable = true
        let str = keychain.get(TOKENSTR)
        XJLog(message: str)
        return str
    }
    
    
    /// 删除所有keychain的数据
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
    
        //MARK: userDefaule 部分
    
    /// 储存用户数据到UserDefaults
    ///
    /// - Parameters:
    ///   - loginUserId: 用户id
    ///   - token: token
    ///   - complate: <#complate description#>
    class func storeLoginIdAndTokenInUD(loginUserId : String , token : String, complate:(_ data : Any) ->() ){
        UserDefaults.standard.set("1", forKey: ISLOGINSTR)
        UserDefaults.standard.set(token, forKey: TOKENUDSTR)
        UserDefaults.standard.set(loginUserId, forKey: LOGINUDSTR)
        UserDefaults.standard.set("1", forKey: ShowRecentStudy)


        let ok = UserDefaults.standard.synchronize()
        if ok {
            print("存储成功")
            complate("1")
        } else {
            print("存储失败")
            complate("0")
        }
    }
    
    /// 返回当前登录用户的 loginid tokenid
    ///
    /// - returns: 返回元组loginid
    class func getLoginIdAndTokenInUD() -> (loginId : String, tokenStr:String,isHaveLogin : String) {
        var isloginStr :String? = UserDefaults.standard.value(forKey: ISLOGINSTR) as! String?
        if isloginStr == nil {
            isloginStr = "0"
        }
        var loginStr :String? = UserDefaults.standard.value(forKey: LOGINUDSTR) as! String?
        if loginStr == nil {
            loginStr = ""
        }
        var tokenStr :String? = UserDefaults.standard.value(forKey: TOKENUDSTR) as! String?
        if tokenStr == nil {
            tokenStr = ""
        }
        return (loginStr!,tokenStr!,isloginStr!)
    }
    
    
    
    /// 登出
    ///
    /// - Parameter complate: <#complate description#>
    class func setLogout(complate:(_ data : Any) ->()) {
        UserDefaults.standard.set("0", forKey: ISLOGINSTR)
        UserDefaults.standard.set("", forKey: TOKENUDSTR)
        UserDefaults.standard.set("", forKey: LOGINUDSTR)
        let ok = UserDefaults.standard.synchronize()
        if ok {
            print("存储成功")
            complate("1")
        } else {
            print("存储失败")
            complate("0")
        }
        
    }


    /// 存储 是否展示最近学习
    ///
    /// - Parameters:
    ///   - value: <#value description#>
    ///   - complate: <#complate description#>
    class func setShowRecentStudy(value : String,complate:(_ data : Any) ->()) {
        UserDefaults.standard.set(value, forKey: ShowRecentStudy)
        let ok = UserDefaults.standard.synchronize()
        if ok {
            print("存储成功")
            complate("1")
        } else {
            print("存储失败")
            complate("0")
        }
    }

    /// 获取 是否展示最近学习
    ///
    /// - Returns: <#return value description#>
    class func getIsShowRecentStudy() -> String {
        var isloginStr :String? = UserDefaults.standard.value(forKey: ShowRecentStudy) as! String?
        if isloginStr == nil {
            isloginStr = ""
        }
        return isloginStr!
    }

}
