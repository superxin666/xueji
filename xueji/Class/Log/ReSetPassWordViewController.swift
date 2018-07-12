//
//  ReSetPassWordViewController.swift
//  xueji
//
//  Created by lvxin on 2018/1/7.
//  Copyright © 2018年 lvxin. All rights reserved.
//  重置密码

import UIKit

class ReSetPassWordViewController: BaseViewController {
    var pwView = ReSetPWView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.creatUI()

    }

    // MARK: - UI
    func creatUI() {
        self.navigation_title_fontsize(name: "重置密码", fontsize: 20)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "base_arrow_<"))
        pwView = ReSetPWView(frame: CGRect(x: 0, y: LNAVIGATION_HEIGHT, width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT - LNAVIGATION_HEIGHT))
        self.view.addSubview(pwView)

    }
    
    // MARK: - event response
    override func navigationLeftBtnClick() {
        if (pwView.time != nil) {
            pwView.time.invalidate()
        }
        self.navigationController?.popViewController(animated: true)
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
