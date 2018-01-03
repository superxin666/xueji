//
//  LogViewController.swift
//  学记
//
//  Created by lvxin on 2017/8/30.
//  Copyright © 2017年 lvxin. All rights reserved.
//

import UIKit

class LogViewController: BaseViewController,LoginViewDelegate {
    var loginView: LoginView!
    let requestManger = StudyApiMangerViewController()


     // MARK: - lifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
      
        
        self.creatUI()
    }
    // MARK: - UI
    func creatUI() {
        self.navigationBar_rightBtn_title(title: "注册新账号")
        loginView = LoginView(frame: CGRect(x: 0, y: LNAVIGATION_HEIGHT, width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT - LNAVIGATION_HEIGHT))
        loginView.delegate = self
        self.view.addSubview(loginView)

    }
    // MARK: - delegate
    func login() {
        XJLog(message: "登录")

        requestManger.loginRequest()
    }

    // MARK: - event response


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
