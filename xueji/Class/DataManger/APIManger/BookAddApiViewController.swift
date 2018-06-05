//
//  BookAddApiViewController.swift
//  xueji
//
//  Created by lvxin on 2018/1/14.
//  Copyright © 2018年 lvxin. All rights reserved.
//  添加书本 扫码添加

import UIKit
import ObjectMapper
protocol BookAddApiViewControllerDelegate: NSObjectProtocol{
    func requestSucceed() -> Void
    func requestFail() -> Void
}

class BookAddApiViewController: UIViewController,BaseApiMangerViewControllerDelegate {
    weak var delegate :BookAddApiViewControllerDelegate!
    let request : BaseApiMangerViewController = BaseApiMangerViewController()

    
    /// 添加书籍
    ///
    /// - Parameter isbn: 分类id
    func addBookRequest(isbn:Int) {

        request.delegate = self
        SVPMessageShow.showLoad()
        let url  = book_add_book_api + "isbn=\(isbn)" + "&cid=\(0)" + request.getTokenParameter()
        request.request_api(url: url)

    }

    func requestSucceed(response: Any) {
        SVPMessageShow.dismissSVP()
        XJLog(message: response)
        SVPMessageShow.showSucess(infoStr: "添加成功")
        if self.delegate != nil {
            self.delegate.requestSucceed()
        }

    }

    func requestFail(response: Any) {
        SVPMessageShow.dismissSVP()
//        XJLog(message: response)
//        let model = Mapper<ErrorCodeData>().map(JSON: response as! [String : Any])!
//        XJLog(message: model.msg)
//        SVPMessageShow.showErro(infoStr: model.msg)
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
