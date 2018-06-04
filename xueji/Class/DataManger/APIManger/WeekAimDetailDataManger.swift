//
//  WeekAimDetailDataManger.swift
//  xueji
//
//  Created by lvxin on 2018/5/27.
//  Copyright © 2018年 lvxin. All rights reserved.
//  本周目标详情

import UIKit
import ObjectMapper
protocol WeekAimDetailDataMangerDelegate: NSObjectProtocol{
    func WeekAimDetailDataSucceed() -> Void
    func WeekAimDetailDataFail() -> Void
}

class WeekAimDetailDataManger: UIViewController,BaseApiMangerViewControllerDelegate {

    weak var delegate :WeekAimDetailDataMangerDelegate!
    let request : BaseApiMangerViewController = BaseApiMangerViewController()
    var page = 0
    let pageNum = 2

    var listArr : Array<WeekAimDetailModel> = []
    var listArr_report : Array<WeekAimDetailModel_report>!


    /// 当前周的数据模型
    var currectWeakModel : WeekAimDetailModel_report = WeekAimDetailModel_report()

    func dataRequest() {
        SVPMessageShow.showLoad()
        request.delegate = self
        let url  = week_report_api  + "page=\(page)" + request.getTokenParameter()
        request.request_api(url: url)
    }

    func requestSucceed(response: Any) {
        SVPMessageShow.dismissSVP()
        XJLog(message: response)
        let arr = Mapper<WeekAimDetailModel>().mapArray(JSONArray: response as! [[String : Any]])

        if page>1 {
            listArr = listArr + arr
            self.delegate.WeekAimDetailDataSucceed()
        } else {
            self.removeArr()
            listArr = arr
            self.getCurrectWeakModel()
            self.delegate.WeekAimDetailDataSucceed()
        }
    }

    func getSectionNum() -> Int {
        if listArr.count > 0 {
            return listArr.count + 1
        } else {
            return 1
        }
    }

    func getRowsInSection(sectionNum : Int) -> Int {
        if listArr.count > 0 {
            let model = listArr[sectionNum - 1]
            if model.report.count > 0   {
                return model.report.count
            } else {
                return 0
            }
        } else {
            return 0
        }
    }

    func getModel(indexPath: IndexPath) ->  WeekAimDetailModel_report{
        if listArr.count > 0 {
            if indexPath.section < listArr.count + 1 {
                let model = listArr[indexPath.section - 1]
                XJLog(message: model.report.count)
                if model.report.count > 0 {

                    return model.report[indexPath.row]
                } else {
                   return WeekAimDetailModel_report()
                }
            } else {
                return WeekAimDetailModel_report()
            }
        } else {
            return WeekAimDetailModel_report()
        }
    }

    func getCurrectWeakModel() {
        if listArr.count > 0 {
            let model = listArr[0]
            if model.report.count > 0 {
                currectWeakModel = model.report[0]
                model.report.remove(at: 0)
            }
        }
    }

    func getSectionTitle(sectionNum : Int) -> String {
        if  listArr.count > 0 {
            let model : WeekAimDetailModel  = listArr[sectionNum - 1]
            if let title = model.month{
                return title
            } else {
                return ""
            }
        } else {
            return ""
        }
    }

    func removeArr() {
        if listArr.count > 0 {
            listArr.removeAll()
        }
    }


    func requestFail(response: Any) {

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
