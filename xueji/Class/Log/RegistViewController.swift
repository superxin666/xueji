//
//  RegistViewController.swift
//  xueji
//
//  Created by lvxin on 2018/1/6.
//  Copyright © 2018年 lvxin. All rights reserved.
//  注册

import UIKit

class RegistViewController: BaseViewController,UITextFieldDelegate {
    var registView : RegistView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.creatUI()
    }
    // MARK: - UI
    func creatUI() {
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "base_arrow_<"))
        registView = RegistView(frame: CGRect(x: 0, y: LNAVIGATION_HEIGHT, width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT - LNAVIGATION_HEIGHT))
        self.view.addSubview(registView)

    }

    // MARK: - event response
    override func navigationLeftBtnClick() {
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
