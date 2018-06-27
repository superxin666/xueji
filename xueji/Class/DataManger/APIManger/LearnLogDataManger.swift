//
//  LearnLogDataManger.swift
//  xueji
//
//  Created by lvxin on 2018/6/25.
//  Copyright © 2018年 lvxin. All rights reserved.
//  记录时间

import UIKit
protocol LearnLogDataMangerDelegate: NSObjectProtocol {
    func LearnLogDataSucceed() -> Void
    func LearnLogDataFail() -> Void
}
class LearnLogDataManger: UIViewController,BaseApiMangerViewControllerDelegate {

    weak var delegate :LearnLogDataMangerDelegate!
    let request : BaseApiMangerViewController = BaseApiMangerViewController()



    /// 学习记录
    ///
    /// - Parameters:
    ///   - bid: 书籍ID
    ///   - etime: 学习结束时间
    ///   - mins_count: 学习时长
    ///   - bpage: 开始页码
    ///   - epage: 结束页码
    ///   - review: 复习计划开关  0:不添加复习计划（默认） 1:添加
    ///   - reminder: 备注      150字max
    func learnRequest(bid : Int,etime : String,mins_count:Int,bpage:String,epage:String,review:Bool = false,reminder:String) {
        if !(Int(bpage)! > 0) {
            SVPMessageShow.showErro(infoStr: "请输入开始页数")
            return
        }
        if !(Int(epage)! > 0) {
            SVPMessageShow.showErro(infoStr: "请输入结束页数")
            return
        }
        if review == true {
            if !(reminder.count > 0) {
                SVPMessageShow.showErro(infoStr: "请输入备注")
                return
            }
            if reminder.count > 150 {
                SVPMessageShow.showErro(infoStr: "备注不能超过150字")
                return
            }
        }

        let reminderStr = reminder.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let etimeStr = etime.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let num = review.hashValue

        request.delegate = self
        let url  = learn_log_api  + "bid=\(bid)" + "&etime=\(etimeStr)" + "&mins_count=\(mins_count)" + "&bpage=\(bpage)" + "&epage=\(epage)" + "&review=\(num)" + "&reminder=\(reminderStr)" + request.getTokenParameter()
        request.request_api(url: url)
        
    }


    func requestSucceed(response: Any) {
        if (self.delegate != nil) {
            self.delegate.LearnLogDataSucceed()
        }
    }

    func requestFail(response: Any) {
        if (self.delegate != nil) {
            self.delegate.LearnLogDataFail()
        }
    }


}
