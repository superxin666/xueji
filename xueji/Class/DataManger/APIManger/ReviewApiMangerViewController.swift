//
//  ReviewApiMangerViewController.swift
//  xueji
//
//  Created by lvxin on 2018/3/26.
//  Copyright © 2018年 lvxin. All rights reserved.
//  复习

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
    
    
    
 
    /// 获取当天复习数据模型个数
    ///
    /// - Parameter dayNum: 当前周的第几天
    /// - Returns: <#return value description#>
    func getListCount_day(dayNum : Int) -> Int  {
        
        if listArr.count > 0 {
            XJLog(message: listArr[dayNum].content.count)
            return listArr[dayNum].content.count
        } else {
            return 0
        }
        
    }
    
    /// 获取复习数据模型
    ///
    /// - Parameter rowNum: <#rowNum description#>
    /// - Returns: <#return value description#>
    func getModel(rowNum : Int,currectDay : Int) -> ReviewModel_content {
        if listArr.count > 0 {
            if currectDay < self.listArr.count , rowNum < self.listArr[currectDay].content.count {
                let model : ReviewModel_content = self.listArr[currectDay].content[rowNum]
                return model
            } else {
                return ReviewModel_content()
            }
         
        } else {
            return ReviewModel_content()
        }
    }

    
    /// 获取数据模型数组 头部
    ///
    /// - Returns: <#return value description#>
    func getListArr() ->Array<ReviewModel>  {
        return listArr
    }
    
    
    
    func getDateArr() {
        
    }
    
    //MARK:网络回调
    func requestSucceed(response: Any) {
        SVPMessageShow.dismissSVP()
        XJLog(message: response)
        let arr = Mapper<ReviewModel>().mapArray(JSONArray: response as! [[String : Any]])
    
        for i in 1..<arr.count {
            let model = arr[i]
            listArr.append(model)
        }
        listArr.insert(arr[0], at: listArr.count)
        XJLog(message: listArr.count)
        self.delegate.requestSucceed()
    }
    
    func requestFail(response: Any) {
        
    }

}
