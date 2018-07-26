//
//  LearnDetailViewController.swift
//  xueji
//
//  Created by lvxin on 2018/5/7.
//  Copyright © 2018年 lvxin. All rights reserved.
//  学习详情页面

import UIKit

class LearnDetailViewController: BaseTableViewController,LearnDetailReviewTableViewCellDelegate,LearnDetailPageTableViewCellDelegate,LearnLogDataMangerDelegate {

    /// 数据模型
    var model  : CategoryListModel_list_book_list!

    var request : LearnLogDataManger = LearnLogDataManger()


    /// 学习时间
    var timeNum : Int!
    /// 时间显示
    var timeStr : String!

    /// 是否加入复习
    var isNotice : Bool = false

    /// 首次学习时间
    var noticeTimeStrTuple : (time1 : String,time2 : String)!

    /// 备注
    var noticeStr : String = ""

    var bPage : String!

    var ePage : String!

    var totlePage : String!

    var tolPage : Int!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationbar_transparency()
        self.navigationController?.navigationBar.isTranslucent = false

    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        request.delegate = self
        self.navigation_title_fontsize(name: "学习详情", fontsize: 20)
        self.navigationBar_leftBtn_title(title: "取消")
        self.navigationBar_rightBtn_title(title: "保存")
        self.creatTableView()
    }

    // MARK: - TableView视图
    func creatTableView()  {
        tableView = UITableView(frame: CGRect(x: 0, y: LNAVIGATION_HEIGHT, width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT - LNAVIGATION_HEIGHT), style: .grouped)
        tableView.backgroundColor = .white
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0  {
            return 3
        } else if section == 1 {
            return 3
        } else {
            return 2
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
                cell.setData_date(timeStr: noticeTimeStrTuple.time1)
                return cell
            } else {
                let cell  = LearnDetailTitleTableViewCell(style: .default, reuseIdentifier: LearnDetailTitleTableViewCellID)
                cell.setData_time(timeStr : timeStr)
                return cell
            }


        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let cell  = LearnDetailPageTableViewCell(style: .default, reuseIdentifier: LearnDetailPageTableViewCellID)
                if let str = bPage {
                    cell.setData_start(contentStr: "\(str)")
                } else {
                    cell.setData_start(contentStr: "")
                }
                cell.delegate = self
                return cell
            } else if indexPath.row == 1 {
                let cell  = LearnDetailPageTableViewCell(style: .default, reuseIdentifier: LearnDetailPageTableViewCellID)
                if let str = ePage {
                    cell.setData_end(contentStr: "\(str)")
                } else {
                    cell.setData_end(contentStr: "")
                }
                cell.delegate = self
                return cell
            } else {
                let cell  = LearnDetailPageTableViewCell(style: .default, reuseIdentifier: LearnDetailPageTableViewCellID)
                if let str = totlePage {
                    cell.setData_tolat(contentStr: "\(str)")
                } else {
                    cell.setData_tolat(contentStr: "")
                }
                cell.delegate = self
                return cell
            }

        } else {
            if indexPath.row == 0 {
                let cell  = LearnDetailTitleTableViewCell(style: .default, reuseIdentifier: LearnDetailTitleTableViewCellID)
                cell.setData_firstTime(timeStr : noticeTimeStrTuple.time2)
                
                if isNotice {
                    cell.setData_firstTime_enble()
                } else {
                    cell.setData_firstTime_unenble()
                }
                return cell
            } else {
                let cell  = LearnDetailReviewTableViewCell(style: .default, reuseIdentifier: LearnDetailReviewTableViewCellID)
                cell.setData_notice(contentStr: noticeStr)
                cell.delegate = self
                if isNotice {
                    cell.setData_notice_enble()
                } else {
                    cell.setData_notice_unenble()
                }
                return cell
            }
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            if indexPath.row == 1 {
                return LearnDetailReviewTableViewCellH
            } else {
                return LearnDetailTitleTableViewCellH
            }
        } else {
            return LearnDetailTitleTableViewCellH
        }

    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return ip6(40)
        } else if section == 1 {
            return ip6(40)
        } else {
            return ip6(60)
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: ip6(40)))
            view.backgroundColor = .white
            return view
        } else if section == 1 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: ip6(40)))
            view.backgroundColor = .white
            return view
        } else {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: ip6(80)))
            view.backgroundColor = .white

            let label = UILabel(frame: CGRect(x: ip6(20), y: ip6(40), width: ip6(100), height: ip6(20)))
            label.text = "是否加入复习"
            label.textColor = black_53
            label.font = xj_fzFontMedium(ip6(15))
            label.textAlignment = .left
            view.addSubview(label)

            let switchBtn = UISwitch(frame: CGRect(x: KSCREEN_WIDTH - ip6(20) - 47, y: 39, width: 0, height: 0))
            switchBtn.isOn = isNotice
            view.addSubview(switchBtn)
            switchBtn.addTarget(self, action: #selector(switchClick(sender:)), for: .valueChanged)

            return view
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            if indexPath.row == 0 {
                //时间
                if isNotice {
                    XJLog(message: "时间点击")
                }
            }
        }
    }
    func switchClick(sender : UISwitch) {
        if sender.isOn {
            XJLog(message: "打开")
            isNotice = true
        } else {
            XJLog(message: "关闭")
            isNotice = false
        }
        self.tableView.reloadSections([2], with: .automatic)
        
    }

    func endText(contentStr: String, tagNum: Int) {

        if tagNum == 10 {
            bPage = contentStr
            XJLog(message: "输入开始页数" + bPage)
        } else if tagNum == 11 {
            ePage = contentStr
            XJLog(message: "输入结束页数" + ePage)
        }
        if let e = ePage, let b = bPage, e.count > 0,b.count > 0 {
            pageCalculate()
        }


    }

    func endText_LearnDetailReview(contentStr: String, tagNum: Int) {
        noticeStr = contentStr
    }

    func LearnLogDataSucceed() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: FLISHDATA), object: nil)
        self.navigationLeftBtnClick()
    }

    func LearnLogDataFail() {

    }

    /// 页数计算
    func pageCalculate() {
        let cell2 : LearnDetailPageTableViewCell = self.tableView.cellForRow(at:NSIndexPath(row: 2, section: 1) as IndexPath) as! LearnDetailPageTableViewCell
        var eNum = 0
        if let str =  ePage,str.count > 0 {
            eNum = Int(str)!
        }
        var bNum = 0
        if let str =  bPage,str.count > 0 {
            bNum = Int(str)!
        }

        tolPage = eNum - bNum + 1
        cell2.textFiled.text = "\(tolPage!)"
    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popToRootViewController(animated: true)
    }

    override func navigationRightBtnClick() {
        XJLog(message: "保存")
        self.view.endEditing(true)

        if let e = ePage, let b = bPage, e.count > 0,b.count > 0 {
            if tolPage > 0 {
                request.learnRequest(bid: model.id, etime: noticeTimeStrTuple.time1 + " " + noticeTimeStrTuple.time2, mins_count: timeNum/60, bpage: bPage, epage: ePage, review: isNotice,reminder: noticeStr)
            } else {
                SVPMessageShow.showErro(infoStr: "请输入正确开始结束页码")
            }

        } else {
            SVPMessageShow.showErro(infoStr: "请输入开始或结束页码")
            return
        }

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
