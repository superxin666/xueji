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

class BaseApiMangerViewController: UIViewController {
    
    /// 请求链接
    var _urlStr: String!
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
        
        Alamofire.request(_urlStr, method: .get).responseJSON { (returnResult) in
            print("secondMethod --> get 请求 --> returnResult = \(returnResult)")
 
            
        }
//        Alamofire.request(_urlStr, method: requestMethod, parameters: baseParameter, encoding: JSONEncoding.default, headers: headers).responseJSON { (returnResult) in
//            debugPrint("返回数据：\(returnResult)")
//            if let json = returnResult.result.value {
////                model = Mapper<GetmyfeedlistModel>().map(JSON: json as! [String : Any])!
////                completion(model)
//                debugPrint(json)
//            } else {
////                failure("请求失败")
//            }
//
//        }
        
    }
}
