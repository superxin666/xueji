//
//  BaseApiMangerViewController.swift
//  xueji
//
//  Created by lvxin on 2017/12/21.
//  Copyright © 2017年 lvxin. All rights reserved.
//  网络请求 集约处

import UIKit
import Alamofire
import ObjectMapper
protocol BaseApiMangerViewControllerDelegate: NSObjectProtocol{

func requestSucceed(response :Any) -> Void
func requestFail(response :Any) -> Void
func methodName() -> String
//func parameterStr() -> String
    
}


class BaseApiMangerViewController: UIViewController {
    weak var delegate :BaseApiMangerViewControllerDelegate!

    /// 请求链接
    var urlStr: String!
//    var urlStr : String?{
//        set{
//            _urlStr = newValue
//        }
//        get {
//            return _urlStr
//        }
//    }
    
    /// 请求头
    var headers : HTTPHeaders!
    //请求参数字典
    var requestMethod : HTTPMethod!

    func request_api()  {
        let str = self.delegate.methodName()
        let url = base_api+str
        XJLog(message: url)
        Alamofire.request(url, method: .get).responseJSON { (returnResult) in
            print("secondMethod --> get 请求 --> returnResult = \(returnResult)")
            if let json = returnResult.result.value {
                if self.delegate != nil {
                    self.delegate.requestSucceed(response: json)
                }
            } else {
                if self.delegate != nil {
                    self.delegate.requestFail(response: "请求失败")
                }
            }
        }
        
    }


}
