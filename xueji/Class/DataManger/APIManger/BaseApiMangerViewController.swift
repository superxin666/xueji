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
}


class BaseApiMangerViewController: UIViewController {
    weak var delegate :BaseApiMangerViewControllerDelegate!

    /// 请求链接
    var urlStr: String!
    
    /// 请求头
    var headers : HTTPHeaders!
    //请求参数字典
    var requestMethod : HTTPMethod!
    
    
    func request_api(url : String){

        let url = base_api + url
        XJLog(message: url)
        Alamofire.request(url, method: .get).responseJSON { (returnResult) in
            print("secondMethod --> get 请求 --> returnResult = \(returnResult)")
            if let json = returnResult.result.value {
                let model = Mapper<CodeData>().map(JSON: json as! [String : Any])!
                if model.code == 0 {
                    if self.delegate != nil {
                        self.delegate.requestSucceed(response: model.data)
                    }
                } else {
                    SVPMessageShow .showErro(infoStr: model.msg)
                    self.delegate.requestFail(response:json)
                }

            } else {
                if self.delegate != nil {
                    SVPMessageShow .showErro(infoStr: "请求失败")
   
                }
            }
        }
        
    }

    func getTokenParameter()->String {
        let tokenStr = UserDataManger.getLoginIdAndTokenInUD().tokenStr
        let str = "&token=\(tokenStr)"
        return str;
    }

}
