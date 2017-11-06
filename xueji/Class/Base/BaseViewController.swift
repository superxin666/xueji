//
//  BaseViewController.swift
//  学记
//
//  Created by lvxin on 2017/8/29.
//  Copyright © 2017年 lvxin. All rights reserved.
//

import UIKit
import SVProgressHUD

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
    }
    //MARK: 导航栏
    func navigation_title_fontsize(name:String, fontsize:Int) {
        self.title = name
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: xj_fzFontMedium(CGFloat(fontsize)),NSForegroundColorAttributeName:black_53]
    }
    
    //导航栏透明
    func navigationbar_transparency()  {
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
//        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    //设置导航栏右键_图片
    func navigationBar_rightBtn_image(image:UIImage){
        let btn:UIButton = UIButton(type: UIButtonType.custom)
        btn.frame = CGRect(x: 0, y: 0, width: 40, height: 44)
        btn.setImage(image, for: .normal)
        btn.addTarget(self, action:#selector(BaseViewController.navigationRightBtnClick), for: .touchUpInside)
        let item:UIBarButtonItem = UIBarButtonItem(customView:btn)
        self.navigationItem.rightBarButtonItem = item
    }
    //设置导航栏左键_图片
    func navigationBar_leftBtn_image(image:UIImage){
        let btn:UIButton = UIButton(type: UIButtonType.custom)
        btn.frame = CGRect(x: 0, y: 0, width: 40, height: 44)
        btn.setImage(image, for: .normal)
        btn.addTarget(self, action:#selector(BaseViewController.navigationLeftBtnClick), for: .touchUpInside)
        let item:UIBarButtonItem = UIBarButtonItem(customView:btn)
        self.navigationItem.leftBarButtonItem = item
    }
    //设置导航栏左键_文字
    func navigationBar_leftBtn_title(title:String){
        let btn:UIButton = UIButton(type: UIButtonType.custom)
        btn.frame = CGRect(x: 0, y: 0, width: 40, height: 44)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(black_53, for: .normal)
        btn.addTarget(self, action:#selector(BaseViewController.navigationLeftBtnClick), for: .touchUpInside)
        let item:UIBarButtonItem = UIBarButtonItem(customView:btn)
        self.navigationItem.leftBarButtonItem = item
    }
    //设置导航栏右键_文字
    func navigationBar_rightBtn_title(title:String){
        let btn:UIButton = UIButton(type: UIButtonType.custom)
        btn.frame = CGRect(x: 0, y: 0, width: 40, height: 44)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(black_53, for: .normal)
        btn.addTarget(self, action:#selector(BaseViewController.navigationRightBtnClick), for: .touchUpInside)
        let item:UIBarButtonItem = UIBarButtonItem(customView:btn)
        self.navigationItem.rightBarButtonItem = item
    }
    //返回键
    func navigationLeftBtnClick() {
        print("导航栏返回键点击")
    }
    //右键点击
    func navigationRightBtnClick(){
        print("导航栏右键点击")
    }
    
    //MARK: 提示
    func showErro(infoStr:String){
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setMaximumDismissTimeInterval(1)
        SVProgressHUD.showError(withStatus: infoStr)

    }
    func showSucess(infoStr:String) {
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setMaximumDismissTimeInterval(1)
        SVProgressHUD.showSuccess(withStatus: infoStr)
    }
    func showLoad() {
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        SVProgressHUD.show(withStatus: "正在努力加载中")
    }
    
    func dismiss() {
        SVProgressHUD.dismiss()
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
