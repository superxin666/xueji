//
//  ReviewApiMangerViewController.swift
//  xueji
//
//  Created by lvxin on 2018/3/26.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

protocol ReviewApiMangerViewControllerDelegate: NSObjectProtocol{
    func requestSucceed() -> Void
    func requestFail() -> Void
}

class ReviewApiMangerViewController: UIViewController,BaseApiMangerViewControllerDelegate {
    weak var delegate :ReviewApiMangerViewControllerDelegate!
    let request : BaseApiMangerViewController = BaseApiMangerViewController()
   
    /// 复习模型数组
    var listArr : Array<ReviewModel> = []
    
    
    //MARK:列表请求
    func listRequest()  {
        request.delegate = self
        SVPMessageShow.showLoad()
        listArr = Array()
        let url = review_range_api  + request.getTokenParameter()
        request.request_api(url: url)
    }
    
    
    
    ///获取列表模型个数
    ///
    /// - Returns: <#return value description#>
    func getListCount() -> Int  {
        
        if listArr.count > 0 {
            return listArr.count
        } else {
            return 0
        }
        
    }
    
    func getModel(rowNum : Int) -> ReviewModel {
        if listArr.count > 0 {
            let model = self.listArr[rowNum]
            return model
        } else {
            return ReviewModel()
        }
    }
    
    
    //MARK:网络回调
    func requestSucceed(response: Any) {
        SVPMessageShow.dismissSVP()
        XJLog(message: response)
        let arr = Mapper<ReviewModel>().mapArray(JSONArray: response as! [[String : Any]])
        listArr = arr
        self.delegate.requestSucceed()
    }
    
    func requestFail(response: Any) {
        
    }

}
