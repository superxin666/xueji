//
//  CategoryListApiMangerViewController.swift
//  xueji
//
//  Created by lvxin on 2018/1/11.
//  Copyright © 2018年 lvxin. All rights reserved.
//  分类列表

import UIKit
import ObjectMapper

protocol CategoryListApiMangerViewControllerDelegate: NSObjectProtocol{
    func requestSucceed() -> Void
    func requestFail() -> Void
}
class CategoryListApiMangerViewController: UIViewController,BaseApiMangerViewControllerDelegate {

    weak var delegate :CategoryListApiMangerViewControllerDelegate!
    let request : BaseApiMangerViewController = BaseApiMangerViewController()
    var page = 0
    let pageNum = 20

    /// 模型数组
    var listArr : Array<CategoryListModel_list> = Array()

    

    //MARK: 请求
    func listRequest()  {
        request.delegate = self
        SVPMessageShow.showLoad()
        page = page + 1
        let url = category_list_api + "&page=\(page)" + request.getTokenParameter()
        request.request_api(url: url)
    }
    
    func requestSucceed(response: Any) {
        SVPMessageShow.dismissSVP()
        XJLog(message: response)
        let model = Mapper<CategoryListModel>().map(JSON: response as! [String : Any])!
        if page>1 {
            listArr = listArr + model.list
            self.delegate.requestSucceed()
        } else {
            self.removeArr()
            listArr = model.list
            self.delegate.requestSucceed()
        }
    }
    
    func requestFail(response: Any) {
        SVPMessageShow.dismissSVP()
        XJLog(message: response)
        let model = Mapper<ErrorCodeData>().map(JSON: response as! [String : Any])!
        XJLog(message: model.msg)
        SVPMessageShow.showErro(infoStr: model.msg)
        self.delegate.requestFail()
    }
        //MARK: 数据处理
    func getListArrCount()-> Int {
        XJLog(message: self.listArr.count)
        if self.listArr.count > 0 {
            return listArr.count
        } else {
            return 0
        }
    }
    
    func getModel(index : Int) -> CategoryListModel_list {
        if index < self.listArr.count {
            return self.listArr[index]
        } else {
            return CategoryListModel_list()
        }
    }
    func removeArr() {
        if listArr.count>0 {
            listArr.removeAll()
        }
    }

    func resetPage()  {
        page = 0
    }
}
