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
    let pageNum = 2
    
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

    func reflishData() {
        self.removeArr()
        self.resetPage()
        self.listRequest()

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


    /// 返回是否已经有学习数据
    ///
    /// - Returns: <#return value description#>
    func isHaveData() -> Bool  {
        if !(listArr.count > 0) && !(recent_learnListArr.count > 0) {
            return false
        } else {
            return true
        }
//        return false
    }
    
    /// 获取分类数据模型数组个数
    ///
    /// - Returns: <#return value description#>
    func getListArrCount()-> Int {
        //最近学习
        var num = 0
        if self.getRecentListCount() > 0 {
            num = 1
        }
        //分类
        if let arr = self.listArr{
            XJLog(message: arr.count)
            if arr.count > 0 {
                return arr.count + num

            } else {
                return 0 + num
            }
        } else{
            return 0 + num
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
    
    /// 获取一组书籍
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
        XJLog(message: "获取高度\(bookNum)")
        let imageH = ip6(132 + 14 + 7)

        let num1 = bookNum/3
        let num2 = bookNum%3 > 0 ? 1 : 0
        var height =  imageH
        height = height + CGFloat((num1 - 1)) * (imageH + ip6(10))
        height = height +  CGFloat(num2) *  (imageH + ip6(10))
        return height
    }



    /// 最近学习cell高度
    ///
    /// - Returns: <#return value description#>
    func getRecentRowHeight() -> CGFloat {
        let bookNum = self.recent_learnListArr.count
        let imageH = ip6(100)
        let height = (CGFloat((bookNum/5))+1) * (imageH)

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
    
    
    /// 获取最近学习列表个数
    ///
    /// - Returns: <#return value description#>
    func getRecentListCount() -> Int {
        if !(UserDataManger.getIsShowRecentStudy() == "1")  {
            return 0
        } else {
            if let arr = self.recent_learnListArr {
                if arr.count > 0 {
                    return arr.count
                } else {
                    return 0
                }
            } else {
                return 0
            }

        }
    }


    func removeBookModel(model : CategoryListModel_list_book_list) {
        
    }


    
    /// 获取最近学习数组
    ///
    /// - Returns: <#return value description#>
    func getRecentList() -> Array<CategoryListModel_list_book_list> {
        if let arr = self.recent_learnListArr {
            return arr
        } else {
            return Array()
        }
    }
    
    /// 清除数据
    func removeArr() {
        if var arr = listArr {
            if arr.count > 0 {
                arr.removeAll()
            }
        }
        if var arr2 = recent_learnListArr {
            if arr2.count > 0 {
                arr2.removeAll()
            }
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
