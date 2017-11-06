//
//  UserViewController.swift
//  学记
//
//  Created by lvxin on 2017/8/29.
//  Copyright © 2017年 lvxin. All rights reserved.
//  tab --我的

import UIKit


class UserViewController: BaseViewController {
    

    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(false, animated: animated)

        self.navigationbar_transparency()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigation_title_fontsize(name: "我的", fontsize: 20)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "study_setup"))
        self.navigationBar_rightBtn_image(image: #imageLiteral(resourceName: "user_send"))
        self.creatHeadUI()
    }
    //MARK: 导航栏点击
    override func navigationLeftBtnClick() {
        
    }
    override func navigationRightBtnClick() {
        
    }
    //MARK: 头部视图
    func creatHeadUI() {
        let headView : UserHeadView = UserHeadView(frame: CGRect(x: 0, y: LNAVIGATION_HEIGHT, width: KSCREEN_WIDTH, height: headViewHeight))
        self.view.addSubview(headView)
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
