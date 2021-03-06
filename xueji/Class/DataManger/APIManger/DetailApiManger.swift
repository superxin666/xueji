//
//  DetailApiManger.swift
//  xueji
//
//  Created by lvxin on 2018/7/13.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

protocol DetailApiMangerDelegate: NSObjectProtocol{
    func requestSucceed_Detail() -> Void
    func requestFail_Detail() -> Void
}
class DetailApiManger: UIViewController,BaseApiMangerViewControllerDelegate {
    weak var delegate :DetailApiMangerDelegate!
    let request : BaseApiMangerViewController = BaseApiMangerViewController()
    var dataModel : MyDetailModel!

    var totlaPage : Int = 0
    var totlaTime : Int = 0



    /// 统计详情
    ///
    /// - Parameters:
    ///   - calc_type: BOOK:书籍(默认) CATEGORY:分类
    ///   - cid: 指定分类id
    ///   - time_dim: DAY:日(默认) WEEK:周 MONTH:月
    ///   - page: 默认为0，步长位7(天周月)
    func listRequest(calc_type:String,cid:Int,time_dim:String,page:Int) {
        request.delegate = self
        let url = my_detail_api + "calc_type=\(calc_type)" + "&cid=\(cid)" + "&time_dim=\(time_dim)" + "&page=\(page)" + request.getTokenParameter()
        request.request_api(url: url)
    }


    func requestSucceed(response: Any) {
        dataModel = Mapper<MyDetailModel>().map(JSON: response as! [String : Any])!
        self.delegate.requestSucceed_Detail()
    }

    func requestFail(response: Any) {
        self.delegate.requestFail_Detail()
    }

    /// 获取时间标题
    ///
    /// - Returns: <#return value description#>
    func getDayTitle(type : String) ->String {
        if let model = dataModel {
            if model.report.count > 0 {
                let model1 : MyDetailModel_report = model.report[0]
                let model2 : MyDetailModel_report = model.report[6]

                if type == "DAY" {
                    let str = model2.day + "~" + model1.day
                    return str

                } else if type == "WEEK" {
                    let str = model2.week + "~" + model1.week
                    return str

                } else {
                    let str = model2.month + "~" + model1.month
                    return str
                }

            }  else {
                return ""
            }
        } else {
            return ""
        }
    }

    /// 获取分类数组
    ///
    /// - Returns: <#return value description#>
    func getCatArr() -> [MyDetailModel_category_list] {
        let holeModel : MyDetailModel_category_list = MyDetailModel_category_list()
        holeModel.name = "全部"
        holeModel.id = 0
        var arr : [MyDetailModel_category_list] = []
        arr.append(holeModel)


        if let model = dataModel {
            if model.category_list.count > 0 {
                arr = arr + model.category_list
                return arr
            } else {
                return arr
            }
        } else {
            return arr
        }
    }

    /// 返回 已学习 书籍列表 或者是书籍列表
    ///
    /// - Returns: <#return value description#>
    func getCatListCount() ->Int  {
        if let model = dataModel {
            if model.btm_list.count > 0 {
                return model.btm_list.count
            } else {
                return 0
            }
        } else {
            return 0
        }
    }


    /// 获取书籍/分类list
    ///
    /// - Parameter row: <#row description#>
    /// - Returns: <#return value description#>
    func getCatOrBookListModel(row : Int) -> MyDetailModel_btm_list {
        if let model = dataModel {
            if model.btm_list.count > 0 {
                let model : MyDetailModel_btm_list = model.btm_list[row]
                return model
            } else {
                return MyDetailModel_btm_list()
            }
        } else {
            return MyDetailModel_btm_list()
        }
    }

    /// 获取模型
    ///
    /// - Returns: <#return value description#>
    func getDataModel() ->   MyDetailModel{
        if let model = dataModel {
            return model
        } else {
            return MyDetailModel()
        }
    }


    /// 获取书籍总页数 总时间
    ///
    /// - Parameters:
    ///   - row: <#row description#>
    ///   - type: <#type description#>
    func getBookpageTime(type:String) {

        totlaPage = 0
        totlaTime = 0
        let dataModel = self.getDataModel()
        //数据计算
        for model in dataModel.btm_list {
            var arr : [MyDetailModel_day] = []
            if type == "DAY" {
                arr = model.day
            } else if type == "WEEK" {
                arr = model.week
            } else {
                arr = model.month
            }
            var totlaNum_time = 0
            var totlaNum_page = 0
            for subModel in arr {
                totlaNum_time = totlaNum_time + subModel.time_count
                totlaNum_page = totlaNum_page + subModel.page_count
            }
            model.pageTotla = totlaNum_page
            model.timeTotla = totlaNum_time

            totlaPage = totlaPage + totlaNum_page
            totlaTime = totlaTime + totlaNum_time
//            XJLog(message: totlaPage)
//            XJLog(message: totlaTime)
        }

        //百分数计算
        for model in dataModel.btm_list {
            let page = CGFloat(model.pageTotla)/CGFloat(totlaPage)
            let pageStr = String(format:"%.1f",page*100)//

            let time = CGFloat(model.timeTotla)/CGFloat(totlaTime)
            let timeStr = String(format:"%.1f",time*100)//

            model.pagePre = pageStr
            model.timePre = timeStr
        }

    }

}
