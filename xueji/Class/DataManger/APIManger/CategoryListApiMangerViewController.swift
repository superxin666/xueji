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
    var listArr : Array<CategoryListModel_list>!

    

    //MARK: 请求
    func listRequest()  {
        request.delegate = self
        listArr = Array()
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
    
    /// 获取分类数据模型数组
    ///
    /// - Returns: <#return value description#>
    func getListArrCount()-> Int {
        XJLog(message: self.listArr!.count)
        if self.listArr!.count > 0 {
            return listArr.count
        } else {
            return 0
        }
    }
    
    /// 获取分类下 书籍模型个数
    ///
    /// - Parameter index: 第几个分类
    /// - Returns: <#return value description#>
    func getBookArrCount(index : Int) -> Int {
        if index<self.listArr!.count {
            let model : CategoryListModel_list = self.listArr[index]
            if model.book_list.count > 0{
                XJLog(message: "书个数\(model.book_list.count)")
                return model.book_list.count
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
    
    /// 获取分类模型
    ///
    /// - Parameter index: 位置
    /// - Returns: <#return value description#>
    func getModel(index : Int) -> CategoryListModel_list {
        if index < self.listArr.count {
            return self.listArr[index]
        } else {
            return CategoryListModel_list()
        }
    }
    
    /// 获取分类下具体书籍数据模型
    ///
    /// - Parameters:
    ///   - index: 分类位置
    ///   - row: 书籍位置
    /// - Returns: <#return value description#>
    func getBookModel(index : Int, row : Int) -> CategoryListModel_list_book_list {
        if index<self.listArr.count {
            let model : CategoryListModel_list = self.listArr[index]
            if model.book_list.count > 0{
                if row < model.book_list.count{
                    return model.book_list[row]
                } else {
                    return CategoryListModel_list_book_list()
                }
            } else {
                return CategoryListModel_list_book_list()
            }
        } else {
            return CategoryListModel_list_book_list()
        }
    }
    
    /// 清除数据
    func removeArr() {
        if listArr.count>0 {
            listArr.removeAll()
        }
    }
    
    /// 清除 页码
    func resetPage()  {
        page = 0
    }
}
