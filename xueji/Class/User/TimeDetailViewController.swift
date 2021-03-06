//
//  TimeDetailViewController.swift
//  xueji
//
//  Created by lvxin on 2018/5/18.
//  Copyright © 2018年 lvxin. All rights reserved.
//  时间分布详情  学习量分布详情

import UIKit
let CALC_BOOK = "BOOK"
let CALC_CATEGORY = "CATEGORY"

enum TimeDetailViewControllerType {
    case time;
    case amount
}

class TimeDetailViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,DetailApiMangerDelegate,cateSelectedTableViewCellDelegate,DateSelectedTableViewCellDelegate,DateStepTableViewCellDelegate {
    var mainTabelView : UITableView!//

    var request = DetailApiManger()

    /// 分来id 默认为全部
    var cidInt = 0
    /// BOOK:书籍(默认) CATEGORY:分类
    var calc_typeStr = CALC_BOOK
    /// DAY:日(默认) WEEK:周 MONTH:月
    var time_dim = "DAY"
    /// 默认为0，步长位7(天周月)
    var page = 0

    /// 默认为时间统计
    var type : TimeDetailViewControllerType = .time


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.navigationBar_rightBtn_title(title: "分类统计")
        self.navigationBar_leftBtn_title(title: "返回")
        self.creatTableView()
        if  type == .time {
             self.navigation_title_fontsize(name: "学习时间", fontsize: 20)
        } else {
             self.navigation_title_fontsize(name: "学习量", fontsize: 20)
        }
        request.delegate = self
        self.requestList()

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
        mainTabelView.register(DateStepTableViewCell.self, forCellReuseIdentifier: DateStepTableViewCellID)
        mainTabelView.register(TimeDetailTableViewCell.self, forCellReuseIdentifier: TimeDetailTableViewCellID)
        mainTabelView.register(DateSelectedTableViewCell.self, forCellReuseIdentifier: DateSelectedTableViewCellID)
        mainTabelView.register(CateSelectedTableViewCell.self, forCellReuseIdentifier: CateSelectedTableViewCellID)
        mainTabelView.register(HistogramTableViewCell.self, forCellReuseIdentifier: HistogramTableViewCellID)
        self.view.addSubview(mainTabelView)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }else {
            return request.getCatListCount()
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                var cell : DateSelectedTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: DateSelectedTableViewCellID, for: indexPath) as! DateSelectedTableViewCell
                if (cell == nil)  {
                    cell = DateSelectedTableViewCell(style: .default, reuseIdentifier: DateSelectedTableViewCellID)
                }
                cell.delegate = self
                return cell
            } else if indexPath.row == 1 {
                var cell : DateStepTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: DateStepTableViewCellID, for: indexPath) as! DateStepTableViewCell
                if (cell == nil)  {
                    cell = DateStepTableViewCell(style: .default, reuseIdentifier: DateStepTableViewCellID)
                }
                cell.delegate = self
                cell.setData(str: request.getDayTitle(type: time_dim))
                
                return cell
            } else if indexPath.row == 2 {
                var cell : CateSelectedTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: CateSelectedTableViewCellID, for: indexPath) as! CateSelectedTableViewCell
                if (cell == nil)  {
                    cell = CateSelectedTableViewCell(style: .default, reuseIdentifier: CateSelectedTableViewCellID)
                }
                cell.delegate = self
                cell.setData(arr: request.getCatArr())
                return cell
            } else  {
                var cell : HistogramTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: HistogramTableViewCellID, for: indexPath) as! HistogramTableViewCell
                if (cell == nil)  {
                    cell = HistogramTableViewCell(style: .default, reuseIdentifier: HistogramTableViewCellID)
                }
                cell.setData(model: request.getDataModel(), calc_type: calc_typeStr, time_dim: time_dim, viewType: type)
                return cell
            }


        } else {
            let cell : TimeDetailTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: TimeDetailTableViewCellID, for: indexPath) as! TimeDetailTableViewCell
//            if (cell == nil)  {
//                cell = TimeDetailTableViewCell(style: .default, reuseIdentifier: TimeDetailTableViewCellID)
//            }
            cell.setData(model: request.getCatOrBookListModel(row: indexPath.row), type: calc_typeStr, time_dimType: time_dim, viewType: type)
            return cell
        }

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return DateSelectedTableViewCellH
            } else if indexPath.row == 1 {
                return DateStepTableViewCellH
            }else if indexPath.row == 2 {
                return CateSelectedTableViewCellH
            } else {
                return HistogramTableViewCellH
            }

        } else {
            return TimeDetailTableViewCellH
        }
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return ip6(15)
        } else {
            return 0

        }


    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view : UIView = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: ip6(15)))
            view.backgroundColor = .clear
            return view
        } else {
            return UIView()
        }

    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }


    func catClick(_ model: MyDetailModel_category_list) {
        cidInt = model.id
        self.requestList()
        
    }

    func dateTypeSlected(type: Int) {
        if type == 0 {
            time_dim = "DAY"
        } else if type == 1 {
            time_dim = "WEEK"
        } else {
            time_dim = "MONTH"

        }
        self.requestList()
    }

    func dateStepClick(stpeNum: Int) {
        page = stpeNum
        self.requestList()
    }
    

    func requestSucceed_Detail() {
        self.mainTabelView.reloadData()
    }

    func requestFail_Detail() {

    }

    func requestList() {
        request.listRequest(calc_type: calc_typeStr, cid: cidInt, time_dim: time_dim, page: page)
    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        XJLog(message: "切换")
        if calc_typeStr == CALC_BOOK {
            //
            calc_typeStr = CALC_CATEGORY
            self.navigationBar_rightBtn_title(title: "资料统计")

        } else {
            calc_typeStr = CALC_BOOK
            self.navigationBar_rightBtn_title(title: "分类统计")

        }
        self.requestList()


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
