//
//  LoginApiMangerViewController.swift
//  xueji
//
//  Created by lvxin on 2018/1/4.
//  Copyright © 2018年 lvxin. All rights reserved.
//  登陆api

import UIKit

class LoginApiManger: BaseApiMangerViewController,BaseApiMangerViewControllerDelegate {
    
    func loginRequest()  {
        self.delegate = self
        self.request_api()
    }
    
    func methodName() -> String {
        return login_user_api + "id=1"
    }
    func requestSucceed(response: Any) {
        XJLog(message: response)
    }
    
    func requestFail(response: Any) {
        XJLog(message: response)
        SVPMessageShow.showErro(infoStr: response as! String)
    }
}
