//
//  SetInfoViewController.swift
//  xueji
//
//  Created by lvxin on 2018/1/7.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let SetInfoViewHeadHeight = ip6(175)

let SetInfoViewControllerCellid = "SetInfoViewControllerCell_id"
class SetInfoViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    var mainTabelView : UITableView!//
    let nameArr = ["个人资料","账号与安全","学习设置","复习周期","使用教程","关于学记",]
    /// 退出登录
    var logOutBtn : UIButton!


        // MARK: - lifeCirlce
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationBar_leftBtn_title(title: "返回")
        self.creatTableView()
    }
    // MARK: - view
    func creatTableView()  {
        mainTabelView = UITableView.init(frame: CGRect(x: 0, y: LNAVIGATION_HEIGHT , width: KSCREEN_WIDTH, height: ip6(385)), style: .grouped)
        mainTabelView.backgroundColor = UIColor.clear
        mainTabelView.delegate = self;
        mainTabelView.dataSource = self;
        mainTabelView.tableFooterView = UIView()
        mainTabelView.separatorStyle = .none
        mainTabelView.showsVerticalScrollIndicator = false
        mainTabelView.showsHorizontalScrollIndicator = false
        //        footer.setRefreshingTarget(self, refreshingAction: #selector(HomeViewController.loadMoreData))
        //        header.setRefreshingTarget(self, refreshingAction: #selector(HomeViewController.freshData))
        //        mainTabelView.mj_footer = footer
        //        mainTabelView.mj_header = header
        mainTabelView.register(SetInfoTableViewCell.self, forCellReuseIdentifier: SetInfoViewControllerCellid)
        self.view.addSubview(mainTabelView)

        //退出登录
        logOutBtn = UIButton.getBtn_titleStyle(title_normal: "退出账号", title_selected: "退出账号", fream: CGRect(x: 0, y: mainTabelView.frame.maxY + ip6(50) , width: KSCREEN_WIDTH, height: ip6(25)), backgroundColor: .clear, textColor:  UIColor.xj_colorFromRGB(rgbValue: 0x535353), fontSize: 18, textAlignment: .center, selector: #selector(logoutClick), vc: self, tag: 1)
        self.view.addSubview(logOutBtn)
    }

    // MARK: - delegate
    // MARK: - TableViewdelegate

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : SetInfoTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: SetInfoViewControllerCellid, for: indexPath) as! SetInfoTableViewCell
        if (cell == nil)  {
            cell = SetInfoTableViewCell(style: .default, reuseIdentifier: SetInfoViewControllerCellid)
        }
        cell.setName(name: nameArr[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view : SetHeadView = SetHeadView()
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SetInfoViewHeadHeight
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SetInfoCellHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    // MARK: - EvenResponse
    func logoutClick()  {
        XJLog(message: "退出登录")
        UserDataManger.setLogout { (data) in
            let str = data as! String
            if str == "1"{
                XJLog(message: "退出登录成功")
                self.navigationController?.popViewController(animated: true)
            } else {
                    
            }

        }
    }

}
