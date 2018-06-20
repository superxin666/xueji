//
//  BookAddApiViewController.swift
//  xueji
//
//  Created by lvxin on 2018/1/14.
//  Copyright © 2018年 lvxin. All rights reserved.
//  添加书本 扫码添加

import UIKit
import ObjectMapper
enum BookAddApiType {
    case getBookInfo,add_isbn,add_custom
}
protocol BookAddApiViewControllerDelegate: NSObjectProtocol{
    func requestSucceed() -> Void
    func requestFail() -> Void
}

class BookAddApiViewController: UIViewController,BaseApiMangerViewControllerDelegate {
    weak var delegate :BookAddApiViewControllerDelegate!
    let request : BaseApiMangerViewController = BaseApiMangerViewController()
    var bookModel : BookModel!
    var type : BookAddApiType!


    

    /// 添加书籍 扫描
    ///
    /// - Parameters:
    ///   - isbn: 书本号
    ///   - cid: 分类id
    func addBookRequestByIsbn(isbn:Int,cid:Int) {
        request.delegate = self
        self.type = .getBookInfo
        SVPMessageShow.showLoad()
        let url  = book_add_book_api + "type=isbn" + "&isbn=\(isbn)" + "&add=Y" + "&cid=\(cid)" + request.getTokenParameter()
        request.request_api(url: url)

    }


    /// 添加书籍 手动
    ///
    /// - Parameter bookInfo: 参数元
    func addBookByCustom(bookInfo : (cid : Int,title:String,img:String,author:String,publisher:String,pubdate:String,pages:Int)) {
        if bookInfo.title.count > 0 {
            SVPMessageShow.showErro(infoStr: "请输入标题")
            return
        }
        let titleStr = bookInfo.title.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let imgStr = bookInfo.img.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let authorStr = bookInfo.author.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let publisherStr = bookInfo.publisher.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let pubdateStr = bookInfo.pubdate.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!

        request.delegate = self
        self.type = .getBookInfo
        SVPMessageShow.showLoad()
        let url  = book_add_book_api + "type=custom"  + "&add=Y" + "&cid=\(bookInfo.cid)" + "&title=\(titleStr)" + "&img=\(imgStr)" + "&author=\(authorStr)" + "&publisher=\(publisherStr)" + "&pubdate=\(pubdateStr)" + "&pages=\(bookInfo.pages)" + request.getTokenParameter()
        request.request_api(url: url)
    }


    /// 扫描获取书籍信息
    ///
    /// - Parameter isbn: 书籍号
    func getBookInfoByIsbn(isbn : Int) {
        request.delegate = self
        self.type = .add_isbn
        SVPMessageShow.showLoad()
        let url  = book_add_book_api + "type=isbn" + "&isbn=\(isbn)" + "&add=N" + request.getTokenParameter()
        request.request_api(url: url)
    }

    func requestSucceed(response: Any) {
        SVPMessageShow.dismissSVP()
        bookModel = Mapper<BookModel>().map(JSON: response as! [String : Any])!
        SVPMessageShow.showSucess(infoStr: "扫描成功")
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
