
//
//  AddAimViewController.swift
//  xueji
//
//  Created by lvxin on 2018/5/18.
//  Copyright © 2018年 lvxin. All rights reserved.
//  添加周目标

import UIKit

class AddAimViewController: BaseViewController,AddAimDataMangerDelegate {
    var backView : AddAimView!
    var requestVC = AddAimDataManger()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigation_title_fontsize(name: "本周目标", fontsize: 20)
        self.navigationBar_rightBtn_title(title: "保存")
        self.navigationBar_leftBtn_title(title: "返回")
        requestVC.delegate = self
        backView = AddAimView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: ip6(210)))
        backView.backgroundColor = .white
        self.view.addSubview(backView)

    }




    func AddAimDataSucceed() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: FLISHDATA_user), object: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }

    func AddAimDataFail() {

    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        XJLog(message: "保存")
        self.view.endEditing(true)
        requestVC.addWeekAimRequest(pages: backView.pages, time: backView.times)

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
