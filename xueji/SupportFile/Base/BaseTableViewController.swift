//
//  BaseTableViewController.swift
//  xueji
//
//  Created by lvxin on 2018/5/7.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import SVProgressHUD
import MJRefresh
class BaseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
    }
    //MARK: 蒙板
    lazy var maskView : UIView = {
        ()-> UIView in
        let maskView = UIView()
        maskView.backgroundColor = UIColor.init(white: 0.0, alpha: 0.7)
        maskView.frame = CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT)
        return maskView
    }()
    //MARK: 导航栏
    func navigation_title_fontsize(name:String, fontsize:Int) {
        self.title = name
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: xj_fzFontMedium(CGFloat(fontsize)),NSForegroundColorAttributeName:black_53]
    }

    //导航栏透明
    func navigationbar_transparency()  {
//                self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
//                self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "whiteside"), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
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
        btn.frame = CGRect(x: 0, y: 0, width: ip6(40), height: ip6(44))
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
    //刷新控件
    func getMJRefreshNormalHeader()-> MJRefreshNormalHeader {
        let header = MJRefreshNormalHeader() //头部刷新
        return header
    }
    func getMJRefreshAutoNormalFooter() ->MJRefreshAutoNormalFooter {
        let footer = MJRefreshAutoNormalFooter() // 底部刷新
        return footer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
