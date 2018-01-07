//
//  LoginApiMangerViewController.swift
//  xueji
//
//  Created by lvxin on 2018/1/5.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper
protocol LoginApiMangerViewControllerDelegate: NSObjectProtocol{
    func requestSucceed() -> Void
    func requestFail() -> Void
}

class LoginApiMangerViewController:UIViewController, BaseApiMangerViewControllerDelegate {
    weak var delegate :LoginApiMangerViewControllerDelegate!
    let request : BaseApiMangerViewController = BaseApiMangerViewController()


    func loginRequest()  {
        request.delegate = self
        request.request_api(url: login_user_api + "id=1")
    }

    func requestSucceed(response: Any) {
        XJLog(message: response)
        let model = Mapper<LoginModel>().map(JSON: response as! [String : Any])!
        XJLog(message: model.token)
        UserDataManger.storeLoginIdAndTokenInUD(loginUserId: "1", token: model.token!) { (result) in
            let str:String = result as! String
            if str == "1"{
                //存储成工
//                let dele: AppDelegate =  UIApplication.shared.delegate as! AppDelegate
//                dele.tabCreat()
//                SVPMessageShow.showSucess(infoStr: "登录成功")
                if self.delegate != nil {
                    self.delegate.requestSucceed()
                }
            }
        }
    }

    func requestFail(response: Any) {
        XJLog(message: response)

    }
}
