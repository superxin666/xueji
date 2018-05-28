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


    func dataRequest() {
        request.delegate = self
        let url  = user_data_api  + request.getTokenParameter()
        request.request_api(url: url)
    }

    func requestSucceed(response: Any) {

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
