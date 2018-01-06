//
//  StudyApiMangerViewController.swift
//  xueji
//
//  Created by lvxin on 2017/12/20.
//  Copyright © 2017年 lvxin. All rights reserved.
//  study 网络请求

import UIKit

class StudyApiMangerViewController: BaseApiMangerViewController,BaseApiMangerViewControllerDelegate {


//    convenience init() {
//        self.init()
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func loginRequest()  {
        self.delegate = self
//        self.request_api()
    }

    func requestSucceed(response: Any) {
        XJLog(message: response)
    }

    func requestFail(response: Any) {
        XJLog(message: response)
    }

    func methodName() -> String {
        return login_user_api + "id=1"
    }
}
