



//
//  ResetPasswordApiManger.swift
//  xueji
//
//  Created by lvxin on 2018/7/12.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit


protocol ResetPasswordApiMangerDelegate: NSObjectProtocol{
    func requestSucceed_reset() -> Void
    func requestFail_reset() -> Void
}
class ResetPasswordApiManger: UIViewController,BaseApiMangerViewControllerDelegate {
    weak var delegate :ResetPasswordApiMangerDelegate!
    let request : BaseApiMangerViewController = BaseApiMangerViewController()



    func resetRequest(phone:String,sms_code:String,key:String) {
        request.delegate = self
        request.request_api(url: reset_password_api + "phone=\(phone)&sms_code=\(sms_code)&key=\(key)")
    }


    func requestSucceed(response: Any) {
        self.delegate.requestSucceed_reset()
    }

    func requestFail(response: Any) {
        self.delegate.requestFail_reset()
    }
}
