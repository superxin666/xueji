//
//  LearnDetailViewController.swift
//  xueji
//
//  Created by lvxin on 2018/5/7.
//  Copyright © 2018年 lvxin. All rights reserved.
//  学习详情页面

import UIKit

class LearnDetailViewController: BaseTableViewController {
    var model  : CategoryListModel_list_book_list!

    /// 学习时间
    var timeNum : Int!



    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.navigation_title_fontsize(name: "学习详情", fontsize: 20)
        self.navigationBar_leftBtn_title(title: "取消")
        self.navigationBar_rightBtn_title(title: "保存")
        self.creatTableView()
    }

    // MARK: - TableView视图
    func creatTableView()  {
        tableView.backgroundColor = .white
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0  {
            return 3
        } else if section == 1 {
            return 3
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell  = LearnDetailTitleTableViewCell(style: .default, reuseIdentifier: LearnDetailTitleTableViewCellID)
                cell.setData_title(contentStr: model.title)
                return cell
            } else if indexPath.row == 1 {
                let cell  = LearnDetailTitleTableViewCell(style: .default, reuseIdentifier: LearnDetailTitleTableViewCellID)
                cell.setData_date()
                return cell
            } else {
                let cell  = LearnDetailTitleTableViewCell(style: .default, reuseIdentifier: LearnDetailTitleTableViewCellID)
                cell.setData_time()
                return cell
            }


//        } else if indexPath.section == 1 {
//
//
        } else {
            if indexPath.row == 0 {
                let cell  = LearnDetailPageTableViewCell(style: .default, reuseIdentifier: LearnDetailPageTableViewCellID)
                cell.setData_start(contentStr: "")
                return cell
            } else if indexPath.row == 1 {
                let cell  = LearnDetailPageTableViewCell(style: .default, reuseIdentifier: LearnDetailPageTableViewCellID)
                cell.setData_end(contentStr: "")
                return cell
            } else {
                let cell  = LearnDetailPageTableViewCell(style: .default, reuseIdentifier: LearnDetailPageTableViewCellID)
                cell.setData_tolat(contentStr: "")
                return cell
            }
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LearnDetailTitleTableViewCellH
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ip6(40)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: ip6(40)))
        view.backgroundColor = .white
        return view
    }


    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }

    override func navigationRightBtnClick() {
        XJLog(message: "保存")
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
