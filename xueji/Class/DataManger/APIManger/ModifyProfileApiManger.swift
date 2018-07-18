//
//  ModifyProfileApiManger.swift
//  xueji
//
//  Created by lvxin on 2018/7/18.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
protocol ModifyProfileApiMangerDelegate: NSObjectProtocol{
    func requestSucceed_modifyProfile() -> Void
    func requestFail_modifyProfile() -> Void
}
class ModifyProfileApiManger: UIViewController,BaseApiMangerViewControllerDelegate {
    weak var delegate :ModifyProfileApiMangerDelegate!
    let request : BaseApiMangerViewController = BaseApiMangerViewController()



    func modifyProfileRequest(name:String,avatar:String) {
        request.delegate = self
        if !(name.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入名字")
            return
        }
        let nameStr = name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let str = avatar.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        request.request_api(url: modify_profile_api + "name=\(nameStr)&avatar=\(str)" + request.getTokenParameter())
    }

    func requestSucceed(response: Any) {
        self.delegate.requestSucceed_modifyProfile()
    }

    func requestFail(response: Any) {
        self.delegate.requestFail_modifyProfile()
    }
}
