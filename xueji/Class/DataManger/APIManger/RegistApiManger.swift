//
//  RegistApiManger.swift
//  xueji
//
//  Created by lvxin on 2018/7/12.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
protocol RegistApiMangerDelegate: NSObjectProtocol{
    func requestSucceed_regist() -> Void
    func requestFail_regist() -> Void
}
class RegistApiManger: UIViewController,BaseApiMangerViewControllerDelegate {
    weak var delegate :RegistApiMangerDelegate!
    let request : BaseApiMangerViewController = BaseApiMangerViewController()


    func registRequest(phone:String,sms_code:String,key:String)  {


        request.delegate = self
        request.request_api(url: sign_up_api + "phone=\(phone)")

    }

    func requestSucceed(response: Any) {


    }

    func requestFail(response: Any) {

    }


}
