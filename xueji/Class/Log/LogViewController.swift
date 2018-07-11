//
//  LogViewController.swift
//  学记
//
//  Created by lvxin on 2017/8/30.
//  Copyright © 2017年 lvxin. All rights reserved.
//

import UIKit

class LogViewController: BaseViewController,LoginViewDelegate,LoginApiMangerViewControllerDelegate {
    var loginView: LoginView!
    let requestManger = LoginApiMangerViewController()


     // MARK: - lifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
      
        
        self.creatUI()
    }
    // MARK: - UI
    func creatUI() {
        self.navigationBar_rightBtn_title(title: "注册")
//        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "base_arrow_<"))
        loginView = LoginView(frame: CGRect(x: 0, y: LNAVIGATION_HEIGHT, width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT - LNAVIGATION_HEIGHT))
        loginView.delegate = self
        self.view.addSubview(loginView)

    }
    func showNavigationTitle() {
        self.navigation_title_fontsize(name: "学记", fontsize: 20)
        loginView.titleLabel.isHidden = true
        loginView.frame.origin.y = -ip6(66)
    }

    func showViewTitle() {
        self.navigation_title_fontsize(name: "", fontsize: 20)
        loginView.titleLabel.isHidden = false
        loginView.frame.origin.y = 0
    }
    // MARK: - delegate
    //登陆  13910510356   1234
    func login() {
        XJLog(message: "登陆点击")
        requestManger.delegate = self
        requestManger.loginRequest(name: loginView.phoneStr, password: loginView.keyStr)

    }

    func requestSucceed_login() {
        let dele :AppDelegate = UIApplication.shared.delegate as! AppDelegate
        SVPMessageShow.showSucess(infoStr: "登录成功")
        dele.tabCreat()
    }
    func requestFail_login() {

    }
    
    func forgetPassword() {
        XJLog(message: "忘记密码点击")
        let vc = ReSetPassWordViewController()
        self.navigationController?.pushViewController(vc, animated: true)

    }

    // MARK: - event response
    override func navigationRightBtnClick() {
        XJLog(message: "注册点击")
        let vc = RegistViewController()
        self.navigationController?.pushViewController(vc, animated: true)

    }
    override func navigationLeftBtnClick() {
        self.dismiss(animated: true) {

        }
    }
    
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
