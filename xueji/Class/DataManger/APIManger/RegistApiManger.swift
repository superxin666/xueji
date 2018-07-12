//
//  RegistApiManger.swift
//  xueji
//
//  Created by lvxin on 2018/7/12.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper
protocol RegistApiMangerDelegate: NSObjectProtocol{
    func requestSucceed_regist() -> Void
    func requestFail_regist() -> Void
}
class RegistApiManger: UIViewController,BaseApiMangerViewControllerDelegate {
    weak var delegate :RegistApiMangerDelegate!
    let request : BaseApiMangerViewController = BaseApiMangerViewController()


    func registRequest(phone:String,sms_code:String,key:String)  {


        request.delegate = self
        request.request_api(url: reset_password_api + "phone=\(phone)&sms_code=\(sms_code)&key=\(key)")

    }

    func requestSucceed(response: Any) {
        XJLog(message: response)
        UserDataManger.setLogout { (data) in
            let str = data as! String
            if str == "1"{
                let dele :AppDelegate = UIApplication.shared.delegate as! AppDelegate
                dele.showLogin()
            } else {

            }
        }
    }

    func requestFail(response: Any) {
        self.delegate.requestFail_regist()
    }


}
