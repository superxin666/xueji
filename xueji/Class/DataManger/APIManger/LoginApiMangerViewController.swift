//
//  LoginApiMangerViewController.swift
//  xueji
//
//  Created by lvxin on 2018/1/5.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class LoginApiMangerViewController: BaseApiMangerViewController,BaseApiMangerViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func loginRequest()  {
        self.urlStr = login_user_api + "id=1"
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
