//
//  SmsCodeApiManger.swift
//  xueji
//
//  Created by lvxin on 2018/7/11.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
protocol SmsCodeApiMangerDelegate: NSObjectProtocol{
    func requestSucceed_code() -> Void
    func requestFail_code() -> Void
}
class SmsCodeApiManger: UIViewController,BaseApiMangerViewControllerDelegate {
    weak var delegate :SmsCodeApiMangerDelegate!
    let request : BaseApiMangerViewController = BaseApiMangerViewController()



    func getCode(phone:String) {

        request.delegate = self
        request.request_api(url: get_sms_code_api + "phone=\(phone)")
    }


    func requestSucceed(response: Any) {
        self.delegate.requestSucceed_code()
    }

    func requestFail(response: Any) {
        self.delegate.requestFail_code()
    }
}
