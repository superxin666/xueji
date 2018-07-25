


//
//  AddAimDataManger.swift
//  xueji
//
//  Created by lvxin on 2018/6/5.
//  Copyright © 2018年 lvxin. All rights reserved.
//  添加周目标

import UIKit
import ObjectMapper
protocol AddAimDataMangerDelegate: NSObjectProtocol{
    func AddAimDataSucceed() -> Void
    func AddAimDataFail() -> Void
}
class AddAimDataManger: UIViewController,BaseApiMangerViewControllerDelegate {
    
    weak var delegate :AddAimDataMangerDelegate!
    let request : BaseApiMangerViewController = BaseApiMangerViewController()



    /// 添加周目标
    ///
    /// - Parameters:
    ///   - pages: <#pages description#>
    ///   - time: <#time description#>
    func addWeekAimRequest(pages : Int = 0,time : Int) {
        if !(time > 0) {
            SVPMessageShow.showErro(infoStr: "学习时间必须大于0")
            return
        }

        request.delegate = self
        let url  = learn_week_goal_api  + "pages=\(pages)" + "&time=\(time*60)" + request.getTokenParameter()
        request.request_api(url: url)
    }

    func requestSucceed(response: Any) {
        if !(self.delegate == nil) {
            self.delegate.AddAimDataSucceed()
        }
    }
    func requestFail(response: Any) {
        
    }

}
