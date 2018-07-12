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
        request.request_api(url: sign_up_api + "phone=\(phone)&sms_code=\(sms_code)&key=\(key)")

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
                    self.delegate.requestSucceed_regist()
                }
            }
        }
    }

    func requestFail(response: Any) {
        self.delegate.requestFail_regist()
    }


}
