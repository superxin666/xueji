//
//  LogViewController.swift
//  学记
//
//  Created by lvxin on 2017/8/30.
//  Copyright © 2017年 lvxin. All rights reserved.
//

import UIKit

class LogViewController: BaseViewController {

     // MARK: - lifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.navigationBar_rightBtn_title(title: "")
        self.creatUI()
    }
    // MARK: - UI
    func creatUI() {
        //登陆按钮
        let logBtn = UIButton(type: .custom)
        logBtn.frame = CGRect(x: 100, y: 200, width: 50, height: 50)
        logBtn.setTitle("登陆", for: .normal)
        logBtn.backgroundColor = .red
        logBtn.addTarget(self, action: #selector(logInClick), for: UIControlEvents.touchUpInside)
        self.view.addSubview(logBtn)

    }
    // MARK: - delegate
    // MARK: - event response
    func logInClick() {
        print("登陆")
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
