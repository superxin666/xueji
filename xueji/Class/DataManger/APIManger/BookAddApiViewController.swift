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
    case getBookInfo,getMyBookInfo,getBookInfo_ID,add_isbn,add_custom,editeBook
}
protocol BookAddApiViewControllerDelegate: NSObjectProtocol{
    func requestSucceed(type : BookAddApiType) -> Void
    func requestFail(type : BookAddApiType) -> Void
}

class BookAddApiViewController: UIViewController,BaseApiMangerViewControllerDelegate {
    weak var delegate :BookAddApiViewControllerDelegate!
    let request : BaseApiMangerViewController = BaseApiMangerViewController()
    var bookModel : BookModel!
    var myBookModel : MyBookDetailModel!
    var type : BookAddApiType!


    

    /// 添加书籍 扫描
    ///
    /// - Parameters:
    ///   - isbn: 书本号
    ///   - cid: 分类id
    func addBookRequestByIsbn(isbn:String,cid:Int) {
        request.delegate = self
        self.type = .add_isbn
        SVPMessageShow.showLoad()
        let url  = book_add_book_api + "type=isbn" + "&isbn=\(isbn)" + "&add=Y" + "&cid=\(cid)" + request.getTokenParameter()
        request.request_api(url: url)

    }


    /// 编辑书籍 isbn
    ///
    /// - Parameters:
    ///   - isbn: <#isbn description#>
    ///   - cid: <#cid description#>
    func editBookRequestByIsbn(bid : Int ,isbn:String,cid:Int) {
        request.delegate = self
        self.type = .editeBook
        SVPMessageShow.showLoad()
        let url  = book_add_book_api + "bid=\(bid)" + "&type=isbn" + "&isbn=\(isbn)" + "&add=Y" + "&cid=\(cid)" + request.getTokenParameter()
        request.request_api(url: url)

    }


    /// 添加书籍 手动
    ///
    /// - Parameter bookInfo: 参数元
    func addBookByCustom(cid : Int,title:String,img:String,author:String,publisher:String,pubdate:String,pages:String) {
        if !(title.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入标题")
            return
        }
        let titleStr = title.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let imgStr = img.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let authorStr = author.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let publisherStr = publisher.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let pubdateStr = pubdate.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!

        request.delegate = self
        self.type = .add_custom
        SVPMessageShow.showLoad()
        let url  = book_add_book_api + "type=custom"  + "&add=Y" + "&cid=\(cid)" + "&title=\(titleStr)" + "&img=\(imgStr)" + "&author=\(authorStr)" + "&publisher=\(publisherStr)" + "&pubdate=\(pubdateStr)" + "&pages=\(pages)" + request.getTokenParameter()
        request.request_api(url: url)
    }


    /// 编辑书籍 手动添加
    ///
    /// - Parameters:
    ///   - cid: <#cid description#>
    ///   - title: <#title description#>
    ///   - img: <#img description#>
    ///   - author: <#author description#>
    ///   - publisher: <#publisher description#>
    ///   - pubdate: <#pubdate description#>
    ///   - pages: <#pages description#>
    func editeBookByCustom(bid : Int ,cid : Int,title:String,img:String,author:String,publisher:String,pubdate:String,pages:String) {
        if !(title.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入标题")
            return
        }
        let titleStr = title.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let imgStr = img.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let authorStr = author.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let publisherStr = publisher.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let pubdateStr = pubdate.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!

        request.delegate = self
        self.type = .editeBook
        SVPMessageShow.showLoad()
        let url  = book_add_book_api + "bid=\(bid)" + "&type=custom"  + "&add=Y" + "&cid=\(cid)" + "&title=\(titleStr)" + "&img=\(imgStr)" + "&author=\(authorStr)" + "&publisher=\(publisherStr)" + "&pubdate=\(pubdateStr)" + "&pages=\(pages)" + request.getTokenParameter()
        request.request_api(url: url)
    }



    /// 扫描获取书籍信息
    ///
    /// - Parameter isbn: 书籍号
    func getBookInfoByIsbn(isbn : Int) {
        request.delegate = self
        self.type = .getBookInfo
        SVPMessageShow.showLoad()
        let url  = book_add_book_api + "type=isbn" + "&isbn=\(isbn)" + "&add=N" + request.getTokenParameter()
        request.request_api(url: url)
    }



    /// 书本详情
    ///
    /// - Parameter bookID: 书id
    func getBookInfoByBookID(bookID : Int) {
        request.delegate = self
        self.type = .getBookInfo
        SVPMessageShow.showLoad()
        let url  = book_detail_api + "id=\(bookID)"  + request.getTokenParameter()
        request.request_api(url: url)
    }


    /// 我的书本详情
    ///
    /// - Parameter bookID: <#bookID description#>
    func getMyBookInfoByBookID(bookID : Int) {
        request.delegate = self
        self.type = .getMyBookInfo
        SVPMessageShow.showLoad()
        let url  = book_my_detail_api + "id=\(bookID)"  + request.getTokenParameter()
        request.request_api(url: url)
    }


    /// 返回书模型
    ///
    /// - Returns: <#return value description#>
    func getBookModel() -> BookModel{
        if let model = bookModel {
            return model
        } else {
            return BookModel()
        }
    }


    /// 返回我的书据模型
    ///
    /// - Returns: <#return value description#>
    func getMyBookModel() -> MyBookDetailModel {
        if let model = myBookModel {
            return model
        } else {
            return MyBookDetailModel()
        }
    }


    func requestSucceed(response: Any) {
        SVPMessageShow.dismissSVP()
        if self.type ==  .getBookInfo{
            bookModel = Mapper<BookModel>().map(JSON: response as! [String : Any])!
        } else if type == .getMyBookInfo{
            myBookModel = Mapper<MyBookDetailModel>().map(JSON: response as! [String : Any])!
        }
        if self.delegate != nil {
            self.delegate.requestSucceed(type: self.type)
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
