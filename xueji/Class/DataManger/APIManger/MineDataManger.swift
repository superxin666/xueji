
//
//  MineDataMangerViewController.swift
//  xueji
//
//  Created by lvxin on 2018/5/27.
//  Copyright © 2018年 lvxin. All rights reserved.
//  个人数据页面请求

import UIKit
import ObjectMapper
protocol MineDataMangerDelegate: NSObjectProtocol{
    func MineDatarequestSucceed() -> Void
    func MineDataRequestFail() -> Void
}

class MineDataManger: UIViewController,BaseApiMangerViewControllerDelegate {
    weak var delegate :MineDataMangerDelegate!
    let request : BaseApiMangerViewController = BaseApiMangerViewController()
    var dataModel : UserInfoModel!


    func dataRequest() {
        request.delegate = self
        let url  = user_data_api  + request.getTokenParameter()
        request.request_api(url: url)

    }

    func requestSucceed(response: Any) {
        dataModel = Mapper<UserInfoModel>().map(JSON: response as! [String : Any])!
        self.delegate.MineDatarequestSucceed()

    }

    func requestFail(response: Any) {
        XJLog(message: response)

    }

    func getHeadViewModel() -> UserInfoModel_head {
        if let model = dataModel {
            return model.head
        } else {
            return UserInfoModel_head()
        }
    }

    func getAimModel() -> UserInfoModel_weekgoal {
        if let model = dataModel {
            return model.week_goal
        } else {
            return UserInfoModel_weekgoal()
        }
    }
    func getreportModel() -> ReportModel {
        if let model = dataModel {
            return model.report
        } else {
            return ReportModel()
        }
    }
}



