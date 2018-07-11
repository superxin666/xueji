//
//  LoginApiMangerViewController.swift
//  xueji
//
//  Created by lvxin on 2018/1/5.
//  Copyright © 2018年 lvxin. All rights reserved.
//  登陆接口

import UIKit
import ObjectMapper
protocol LoginApiMangerViewControllerDelegate: NSObjectProtocol{
    func requestSucceed() -> Void
    func requestFail() -> Void
}

class LoginApiMangerViewController:UIViewController, BaseApiMangerViewControllerDelegate {
    weak var delegate :LoginApiMangerViewControllerDelegate!
    let request : BaseApiMangerViewController = BaseApiMangerViewController()


    func loginRequest(name : String, password : String)  {
        request.delegate = self
        request.request_api(url: login_user_api + "phone=\(name)" + "&key=\(password)")
    }

    func requestSucceed(response: Any) {
        XJLog(message: response)
        let model = Mapper<LoginModel>().map(JSON: response as! [String : Any])!
        XJLog(message: model.token)
        UserDataManger.storeLoginIdAndTokenInUD(loginUserId: "1", token: model.token!) { (result) in
            let str:String = result as! String
            if str == "1"{
                //存储成工
                if self.delegate != nil {
                    self.delegate.requestSucceed()
                }
            }
        }
    }

    func requestFail(response: Any) {
        XJLog(message: response)
        let model = Mapper<ErrorCodeData>().map(JSON: response as! [String : Any])!
        XJLog(message: model.msg)
        SVPMessageShow.showErro(infoStr: model.msg)

    }
}
