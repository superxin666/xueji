//
//  TimeDistributeViewController.swift
//  xueji
//
//  Created by lvxin on 2018/5/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//  分布

import UIKit
enum TimeDistributeViewControllerType {
    case time
    case amount
}
class TimeDistributeViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,DetailApiMangerDelegate,cateSelectedTableViewCellDelegate,DateSelectedTableViewCellDelegate,DateStepTableViewCellDelegate {
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
    /// vc类型
    var type : TimeDistributeViewControllerType = .time



    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if self.type == .time {
            self.navigation_title_fontsize(name: "时间分布", fontsize: 20)
        } else {
            self.navigation_title_fontsize(name: "学习量分布", fontsize: 20)

        }
        self.navigationBar_leftBtn_title(title: "返回")
        request.delegate = self
        self.requestList()
        self.creatTableView()
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
        mainTabelView.register(DistributeTableViewCell.self, forCellReuseIdentifier: DistributeTableViewCellID)
        mainTabelView.register(DateSelectedTableViewCell.self, forCellReuseIdentifier: DateSelectedTableViewCellID)
        mainTabelView.register(CateSelectedTableViewCell.self, forCellReuseIdentifier: CateSelectedTableViewCellID)
        mainTabelView.register(PieTableViewCell.self, forCellReuseIdentifier: PieTableViewCellID)
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
                cell.setData(arr: request.getCatArr())
                cell.delegate = self
                return cell
            } else  {
                var cell : PieTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: PieTableViewCellID, for: indexPath) as! PieTableViewCell
                if (cell == nil)  {
                    cell = PieTableViewCell(style: .default, reuseIdentifier: PieTableViewCellID)
                }
                cell.setPieData(model: request.getDataModel(), type: type)
                return cell
            }


        } else {
            var cell : DistributeTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: DistributeTableViewCellID, for: indexPath) as! DistributeTableViewCell
            if (cell == nil)  {
                cell = DistributeTableViewCell(style: .default, reuseIdentifier: DistributeTableViewCellID)
            }
            cell.setData(model: request.getCatOrBookListModel(row: indexPath.row), viewType: type)
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
                return PieTableViewCellH
            }

        } else {
            return DistributeTableViewCellH
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
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


    func requestList() {
         request.listRequest(calc_type: calc_typeStr, cid: cidInt, time_dim: time_dim, page: page)
    }

    func requestSucceed_Detail() {
        request.getBookpageTime(type: time_dim)
        self.mainTabelView.reloadData()
    }

    func requestFail_Detail() {

    }

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
