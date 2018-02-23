//
//  StudyApiMangerViewController.swift
//  xueji
//
//  Created by lvxin on 2017/12/20.
//  Copyright © 2017年 lvxin. All rights reserved.
//  首页 网络请求

import UIKit
import ObjectMapper

protocol StudyApiMangerViewControllerDelegate: NSObjectProtocol{
    func requestSucceed() -> Void
    func requestFail() -> Void
}
class StudyApiMangerViewController: ViewController,BaseApiMangerViewControllerDelegate {
    weak var delegate :StudyApiMangerViewControllerDelegate!
    let request : BaseApiMangerViewController = BaseApiMangerViewController()
    var page = 0
    let pageNum = 20
    
    /// 书籍模型数组
    var listArr : Array<CategoryListModel_list>!
    
    /// 最近学习 数据模型
    var recent_learnListArr :Array<CategoryListModel_list_book_list>!
    
    
    func listRequest()  {
        request.delegate = self
        listArr = Array()
        SVPMessageShow.showLoad()
        page = page + 1
        let url = main_index_api + "page=\(page)" + request.getTokenParameter()
        request.request_api(url: url)
        

    }

    func requestSucceed(response: Any) {
        SVPMessageShow.dismissSVP()
        XJLog(message: response)
        let model = Mapper<StudyListModel>().map(JSON: response as! [String : Any])!
        if page>1 {
            listArr = listArr + model.list
            self.delegate.requestSucceed()
        } else {
            self.removeArr()
            listArr = model.list
            recent_learnListArr = model.recent_learn
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
        if let arr = self.listArr{
            XJLog(message: arr.count)
            if arr.count > 0 {
                return arr.count
            } else {
                return 0
            }
        } else{
            return 0
        }
    }
    
    /// 获取分类下 书籍模型个数
    ///
    /// - Parameter index: 第几个分类
    /// - Returns: <#return value description#>
    func getBookArrCount(index : Int) -> Int {
        if let listarr = self.listArr {
            if index<listarr.count {
                let model : CategoryListModel_list = listarr[index]
                if model.book_list.count > 0{
                    XJLog(message: "书个数\(model.book_list.count)")
                    return model.book_list.count
                } else {
                    return 0
                }
            } else {
                return 0
            }
            
        } else {
            return 0
        }
    }
    
    /// 获取
    ///
    /// - Parameter section: <#section description#>
    /// - Returns: <#return value description#>
    func getBookList(section : Int)-> Array<CategoryListModel_list_book_list> {
        
        if let listarr = self.listArr {
            if section<listarr.count {
                let model : CategoryListModel_list = listarr[section]
                return model.book_list
            } else {
                return Array()
            }
        } else {
            return Array()
        }
        
    }
    
    /// 获取分类下面 书籍行高
    ///
    /// - Parameter section: 组 分类位置
    /// - Returns: <#return value description#>
    func getRowHeight(section : Int) -> CGFloat {
        let bookNum = self.getBookArrCount(index: section)
        let imageH = ip6(100)
        let height = (CGFloat((bookNum/4))+1) * (imageH + ip6(16))
        return height
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
    
    /// 获取最近学习数据列表
    ///
    /// - Returns: 列表
    func getRecentLearnList() -> Array<CategoryListModel_list_book_list> {
        if let arr = recent_learnListArr {
            return arr
        } else {
            return Array()
        }
    }
}
