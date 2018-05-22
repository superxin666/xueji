//
//  TimeDistributeViewController.swift
//  xueji
//
//  Created by lvxin on 2018/5/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
enum TimeDistributeViewControllerType {
    case time
    case amount
}
class TimeDistributeViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    var mainTabelView : UITableView!//

    /// vc类型
    var type : TimeDistributeViewControllerType!

    /// 数据类型 0-资料 1-分类
    var dataType :Int = 0


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if self.type == .time {
            self.navigation_title_fontsize(name: "时间分布", fontsize: 20)
        } else {
            self.navigation_title_fontsize(name: "学习量分布", fontsize: 20)

        }
        self.navigationBar_rightBtn_title(title: "切换分类统计")
        self.navigationBar_leftBtn_title(title: "返回")
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
            return 10
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                var cell : DateSelectedTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: DateSelectedTableViewCellID, for: indexPath) as! DateSelectedTableViewCell
                if (cell == nil)  {
                    cell = DateSelectedTableViewCell(style: .default, reuseIdentifier: DateSelectedTableViewCellID)
                }
                return cell
            } else if indexPath.row == 1 {
                var cell : DateStepTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: DateStepTableViewCellID, for: indexPath) as! DateStepTableViewCell
                if (cell == nil)  {
                    cell = DateStepTableViewCell(style: .default, reuseIdentifier: DateStepTableViewCellID)
                }
                return cell
            } else if indexPath.row == 2 {
                var cell : CateSelectedTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: CateSelectedTableViewCellID, for: indexPath) as! CateSelectedTableViewCell
                if (cell == nil)  {
                    cell = CateSelectedTableViewCell(style: .default, reuseIdentifier: CateSelectedTableViewCellID)
                }
                return cell
            } else  {
                var cell : PieTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: PieTableViewCellID, for: indexPath) as! PieTableViewCell
                if (cell == nil)  {
                    cell = PieTableViewCell(style: .default, reuseIdentifier: PieTableViewCellID)
                }
        
                return cell
            }


        } else {
            var cell : DistributeTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: DistributeTableViewCellID, for: indexPath) as! DistributeTableViewCell
            if (cell == nil)  {
                cell = DistributeTableViewCell(style: .default, reuseIdentifier: DistributeTableViewCellID)
            }
            cell.setData()
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

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        XJLog(message: "切换")
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
