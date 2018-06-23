




//
//  BookDelApiManger.swift
//  xueji
//
//  Created by lvxin on 2018/6/23.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper
protocol BookDelApiMangerDelegate : NSObjectProtocol {
    func requestSucceed_BookDelApi() -> Void
    func requestFail_BookDelApi() -> Void
}

class BookDelApiManger: UIViewController,BaseApiMangerViewControllerDelegate {

    weak var delegate :BookDelApiMangerDelegate!
    let request : BaseApiMangerViewController = BaseApiMangerViewController()


    /// 删除网络请求
    ///
    /// - Parameters:
    ///   - id: 书籍id  必传
    func delRequest(id : Int) {
        request.delegate = self
        SVPMessageShow.showLoad()
        let url  = book_remove_api + "id=\(id)"  + request.getTokenParameter()
        request.request_api(url: url)
    }


    func requestSucceed(response: Any) {
        if !(self.delegate == nil) {
            self.delegate.requestSucceed_BookDelApi()
        }
    }

    func requestFail(response: Any) {
        if !(self.delegate == nil) {
            self.delegate.requestFail_BookDelApi()
        }
    }
    
}
