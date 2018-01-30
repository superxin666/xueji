//
//  AddBook_customViewController.swift
//  xueji
//
//  Created by lvxin on 2018/1/30.
//  Copyright © 2018年 lvxin. All rights reserved.
//  自定义添加

import UIKit

import ObjectMapper
protocol AddBook_customViewControllerDelegate: NSObjectProtocol{
    func requestSucceed() -> Void
    func requestFail() -> Void
}
class AddBook_customViewController: UIViewController, BaseApiMangerViewControllerDelegate {

    weak var delegate :AddBook_customViewControllerDelegate!
    let request : BaseApiMangerViewController = BaseApiMangerViewController()
    
    
    /// 添加书籍 自定义
    ///
    /// - Parameters:
    ///   - title: 标题 必填
    ///   - cid: 分类id 必填
    ///   - img: 封面图片
    ///   - author: 作者
    ///   - publisher: 出版商
    ///   - pubdate: 出版时间
    ///   - pages: 页数
    func addBook(title:String,cid : Int,img:String,author:String,publisher:String,pubdate:String,pages:Int) {
        if !(title.count > 0) {
           SVPMessageShow.showErro(infoStr: "请填写标题")
            return
        }
        if !(cid > 0) {
            SVPMessageShow.showErro(infoStr: "请选择分类")
            return
        }
        request.delegate = self
        SVPMessageShow.showLoad()

        let titleCode :String = title.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let url  = book_add_custom_api + "cid=\(cid)" + "&title=\(titleCode)" + request.getTokenParameter()
        request.request_api(url: url)
        
    }
    
    func requestSucceed(response: Any) {
        SVPMessageShow.dismissSVP()
        XJLog(message: response)
        SVPMessageShow.showSucess(infoStr: "添加成功")
    }
    func requestFail(response: Any) {
         SVPMessageShow.dismissSVP()
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
