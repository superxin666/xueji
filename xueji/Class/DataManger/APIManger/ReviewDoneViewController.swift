//
//  ReviewDoneViewController.swift
//  xueji
//
//  Created by lvxin on 2018/4/23.
//  Copyright © 2018年 lvxin. All rights reserved.
//  完成复习

import UIKit
import ObjectMapper

protocol ReviewDoneViewControllerDelegate: NSObjectProtocol{
    func reviewDoneRequestSucceed() -> Void
    func reviewDoneRequestFail() -> Void
}

class ReviewDoneViewController: UIViewController,BaseApiMangerViewControllerDelegate {
    weak var delegate :ReviewDoneViewControllerDelegate!
    let request : BaseApiMangerViewController = BaseApiMangerViewController()

    func doneRequest(id:Int,step:Int)  {
        request.delegate = self
         let url  = review_done_api + "id=\(id)" + "&step=\(step)" + request.getTokenParameter()
        request.request_api(url: url)
    }

    func requestSucceed(response: Any) {
        XJLog(message: response)
        self.delegate.reviewDoneRequestSucceed()
    }

    func requestFail(response: Any) {
        XJLog(message: response)
        let model = Mapper<ErrorCodeData>().map(JSON: response as! [String : Any])!
        XJLog(message: model.msg)
        SVPMessageShow.showErro(infoStr: model.msg)
    }
}
