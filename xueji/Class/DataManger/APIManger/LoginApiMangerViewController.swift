//
//  LoginApiMangerViewController.swift
//  xueji
//
//  Created by lvxin on 2018/1/5.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

class LoginApiMangerViewController:UIViewController, BaseApiMangerViewControllerDelegate {

    let request : BaseApiMangerViewController = BaseApiMangerViewController()


    func loginRequest()  {
        request.delegate = self
        request.request_api(url: login_user_api + "id=1")
    }

    func requestSucceed(response: Any) {
        XJLog(message: response)
        let model = Mapper<LoginModel>().map(JSON: response as! [String : Any])!
        XJLog(message: model.token)
    }

    func requestFail(response: Any) {
        XJLog(message: response)
        
    }
}
