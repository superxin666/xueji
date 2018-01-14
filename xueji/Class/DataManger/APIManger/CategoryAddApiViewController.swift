//
//  CategoryAddApiViewController.swift
//  xueji
//
//  Created by lvxin on 2018/1/14.
//  Copyright © 2018年 lvxin. All rights reserved.
//  添加分类

import UIKit
import ObjectMapper
protocol CategoryAddApiViewControllerDelegate: NSObjectProtocol{
    func requestSucceed() -> Void
    func requestFail() -> Void
}

class CategoryAddApiViewController: UIViewController,BaseApiMangerViewControllerDelegate {

    weak var delegate :CategoryAddApiViewControllerDelegate!
    let request : BaseApiMangerViewController = BaseApiMangerViewController()

    func addCategoryRequest(name:String) {
        if !(name.count>0) {
            SVPMessageShow.showErro(infoStr: "请输入分类名称")
            return
        }
        if name.count > 8 {
            SVPMessageShow.showErro(infoStr: "分类名称最多8字")
            return
        }
        if name.containsEmoji() {
            SVPMessageShow.showErro(infoStr: "分类名称不能有特殊符号")
            return
        }

        request.delegate = self
        SVPMessageShow.showLoad()
        let nameCode :String = name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let url  = category_add_api + "&name=\(nameCode)" + request.getTokenParameter()
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
        XJLog(message: response)
        let model = Mapper<ErrorCodeData>().map(JSON: response as! [String : Any])!
        XJLog(message: model.msg)
        SVPMessageShow.showErro(infoStr: model.msg)
    }

}
