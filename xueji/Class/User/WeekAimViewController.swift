//
//  WeekAimViewController.swift
//  xueji
//
//  Created by lvxin on 2018/5/14.
//  Copyright © 2018年 lvxin. All rights reserved.
//  本周目标

import UIKit

class WeekAimViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,WeekAimDetailDataMangerDelegate,WeekAimLineTableViewCellDelegate    {
    var mainTabelView : UITableView!//

    let request = WeekAimDetailDataManger()

    var aimCell : WeekAimLineTableViewCell!



    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigation_title_fontsize(name: "本周目标", fontsize: 20)
        self.navigationBar_leftBtn_title(title: "返回")
        self.creatTableView()
        request.delegate = self
        request.dataRequest()

        
    }

    func creatTableView()  {
        mainTabelView = UITableView.init(frame: CGRect(x: 0, y: LNAVIGATION_HEIGHT , width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT - LNAVIGATION_HEIGHT), style: .grouped)
        mainTabelView.backgroundColor = UIColor.clear
        mainTabelView.delegate = self;
        mainTabelView.dataSource = self;
        mainTabelView.tableFooterView = UIView()
        mainTabelView.separatorStyle = .none
        mainTabelView.showsVerticalScrollIndicator = false
        mainTabelView.showsHorizontalScrollIndicator = false
        mainTabelView.register(WeekAimTableViewCell.self, forCellReuseIdentifier: WeekAimTableViewCellID)
        mainTabelView.register(WeekAimLineTableViewCell.self, forCellReuseIdentifier: WeekAimLineTableViewCellID)

        mainTabelView.mj_footer = MJRefreshAutoNormalFooter()
        mainTabelView.mj_footer.setRefreshingTarget(self, refreshingAction: #selector(loadMoreData))


        self.view.addSubview(mainTabelView)
    }
    func loadMoreData() {
        request.loadMore_push()

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return request.getSectionNum()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return request.getRowsInSection(sectionNum: section)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                var cell : WeekAimTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: WeekAimTableViewCellID, for: indexPath) as! WeekAimTableViewCell
                if (cell == nil)  {
                    cell = WeekAimTableViewCell(style: .default, reuseIdentifier: WeekAimTableViewCellID)
                }
                cell.setData(model: request.currectWeakModel)
                return cell
            } else {
                aimCell  = tableView.dequeueReusableCell(withIdentifier: WeekAimLineTableViewCellID, for: indexPath) as! WeekAimLineTableViewCell
                if (aimCell == nil)  {
                    aimCell = WeekAimLineTableViewCell(style: .default, reuseIdentifier: WeekAimLineTableViewCellID)
                }
                aimCell.delegate = self
                aimCell.setData(model: request.currectMonthModel)
                return aimCell
            }
        } else {
            var cell : WeekAimTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: WeekAimTableViewCellID, for: indexPath) as! WeekAimTableViewCell
            if (cell == nil)  {
                cell = WeekAimTableViewCell(style: .default, reuseIdentifier: WeekAimTableViewCellID)
            }
            cell.setData(model: request.getModel(indexPath: indexPath))
            return cell
        }

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return WeekAimTableViewCellHeight
            } else {
                return WeekAimLineTableViewCellH
            }
        } else {
            return WeekAimTableViewCellHeight
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return UIView()
        } else {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: ip6(50)))

            let titleLabel = UILabel.getLabel(fream:  CGRect(x: ip6(20), y: ip6(30), width: ip6(200), height: ip6(20)), fontSize: 14, text: "", textColor: black_53, textAlignment: .left)
            titleLabel.text = request.getSectionTitle(sectionNum: section)
            view.addSubview(titleLabel)
            return view
        }

    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return ip6(50)
        }
    }

    func WeekAimDetailDataSucceed() {
        if request.currectWeakModel.time_goal > 0 || request.currectWeakModel.page_goal > 0 {
            self.navigationBar_rightBtn_title(title: "编辑")
        } else {
            self.navigationBar_rightBtn_title(title: "添加")

        }
        if mainTabelView.mj_footer.isRefreshing() {
            mainTabelView.mj_footer.endRefreshing()
        }

        mainTabelView.reloadData()
    }

    func MonthStepClickDelegate() {
        self.mainTabelView.reloadData()
    }
    func WeekAimDetailDataFail() {

    }

    func dateStepClick(stpeNum: Int) {
        XJLog(message: "dateStepClick-----\(stpeNum)")
        let isHaveModel : Bool = request.getMonthModel(stepNum: stpeNum)
        if isHaveModel {
            aimCell.setData(model: request.currectMonthModel)
        }
    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        let vc = AddAimViewController()
        vc.hidesBottomBarWhenPushed  = true
        self.navigationController?.pushViewController(vc, animated: true)
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
