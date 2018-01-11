//
//  CategoryListApiMangerViewController.swift
//  xueji
//
//  Created by lvxin on 2018/1/11.
//  Copyright © 2018年 lvxin. All rights reserved.
//  分类列表

import UIKit
import ObjectMapper

protocol CategoryListApiMangerViewControllerDelegate: NSObjectProtocol{
    func requestSucceed() -> Void
    func requestFail() -> Void
}
class CategoryListApiMangerViewController: UIViewController,BaseApiMangerViewControllerDelegate {

    weak var delegate :CategoryListApiMangerViewControllerDelegate!
    let request : BaseApiMangerViewController = BaseApiMangerViewController()
    
    func listRequest()  {
        request.delegate = self
        request.request_api(url: logout_user_api + request.getTokenParameter())
    }
    
    func requestSucceed(response: Any) {
        XJLog(message: response)
        UserDataManger.setLogout { (data) in
            let str = data as! String
            if str == "1"{
                self.delegate.requestSucceed()
            } else {
                
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
