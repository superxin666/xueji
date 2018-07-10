//
//  BaseApiMangerViewController.swift
//  xueji
//
//  Created by lvxin on 2017/12/21.
//  Copyright © 2017年 lvxin. All rights reserved.
//  网络请求 集约处

import UIKit
import Alamofire
import ObjectMapper

protocol BaseApiMangerViewControllerDelegate: NSObjectProtocol{
func requestSucceed(response :Any) -> Void
func requestFail(response :Any) -> Void
}


class BaseApiMangerViewController: UIViewController {
    weak var delegate :BaseApiMangerViewControllerDelegate!

    /// 请求链接
    var urlStr: String!
    
    /// 请求头
    var headers : HTTPHeaders!
    //请求参数字典
    var requestMethod : HTTPMethod!
    
    
    func request_api(url : String){

        let url = base_api + url
        XJLog(message: url)
        Alamofire.request(url, method: .get).responseJSON { (returnResult) in
            print("secondMethod --> get 请求 --> returnResult = \(returnResult)")
            if let json = returnResult.result.value {
                let model = Mapper<CodeData>().map(JSON: json as! [String : Any])!
                if model.code == 0 {
                    if self.delegate != nil {
                        self.delegate.requestSucceed(response: model.data)
                    }
                } else {
                    SVPMessageShow .showErro(infoStr: model.msg)
                    self.delegate.requestFail(response:json)
                }

            } else {
                if self.delegate != nil {
                    SVPMessageShow .showErro(infoStr: "请求失败")
   
                }
            }
        }
        
    }

    static func uploadfile(imgageData:Data, completion : @escaping (_ data : Any) ->(), failure : @escaping (_ error : Any)->()) {
        //

        XJLog(message:  "上传文件开始")
        XJLog(message: imgageData.count)
        let tokenStr = UserDataManger.getLoginIdAndTokenInUD().tokenStr
        let str = "token=\(tokenStr)"
        let urlStr = base_api + upload_api + str


        var model:ImageData = ImageData()

        let headers = ["content-type":"multipart/form-data"]
        var bookImageUrl = ""

        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imgageData, withName: "img", fileName: "img1", mimeType: "image/jpeg")

        },
            to: urlStr,headers: headers,
            encodingCompletion: { encodingResult in
                XJLog(message: encodingResult)
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let json = response.result.value {
                            XJLog(message: json)
                            model = Mapper<ImageData>().map(JSON: json as! [String : Any])!
                            if model.code == 0 {
                                if let urlStr = model.data.url{
                                    bookImageUrl = urlStr
                                    completion(bookImageUrl)
                                } else {
                                    SVPMessageShow.showErro(infoStr: "上传图片失败请重新尝试~")
                                }
                            } else {
                                SVPMessageShow.showErro(infoStr: "上传图片失败请重新尝试~")
                            }
                        } else {
                            failure("请求失败")
                        }
                    }
                case .failure(let encodingError):
                    failure("请求失败")
                    print(encodingError)
                }
        }
        )
    }



    func getTokenParameter()->String {
        let tokenStr = UserDataManger.getLoginIdAndTokenInUD().tokenStr
        let str = "&token=\(tokenStr)"
        return str;
    }

}
