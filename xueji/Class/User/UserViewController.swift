//
//  UserViewController.swift
//  学记
//
//  Created by lvxin on 2017/8/29.
//  Copyright © 2017年 lvxin. All rights reserved.
//  tab --我的

import UIKit
let study_value_sectionHeight = ip6(148)//学习力





let study_value_cell_ID = "study_value_cell_id"

let study_time_cell_ID = "study_time_cell_id"
let study_amount_cell_ID = "study_amount_cell_id"
let FLISHDATA_user = "flishdata_user"


class UserViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,MineDataMangerDelegate {
    var mainTabelView : UITableView!//
    var headView : UserHeadView!
    let sectionTitleArr : [String] = ["本周目标","学习时间","学习量","学习分布","本周目标"]//
    var aimCell : StudyAimTableViewCell!
    var timecell : StudyTimeTableViewCell!
    var amountcell : StudyAmountTableViewCell!
    var distributecell : StudyDistributeTableViewCell!
    let requestVC = MineDataManger()



        // MARK: - lifeCirlce
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
        self.creatTableView()
        requestVC.delegate = self
        requestVC.dataRequest()
        NotificationCenter.default.addObserver(self, selector: #selector(reflishData), name: NSNotification.Name(rawValue: FLISHDATA_user), object: nil)


    }

    func reflishData() {
        requestVC.dataRequest()
    }
        // MARK: - view
    //MARK: 导航栏点击
    override func navigationLeftBtnClick() {
        let vc = SetInfoViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.model = requestVC.getHeadViewModel()
        self.navigationController?.pushViewController(vc, animated: true)

    }
    override func navigationRightBtnClick() {
        
    }
    //MARK: 头部视图
    func creatHeadUI() {
        headView  = UserHeadView(frame: CGRect(x: 0, y: LNAVIGATION_HEIGHT, width: KSCREEN_WIDTH, height: headViewHeight))
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
        mainTabelView.register(StudyValueTableViewCell.self, forCellReuseIdentifier: study_value_cell_ID)
        mainTabelView.register(StudyAimTableViewCell.self, forCellReuseIdentifier: study_aim_cell_ID)
        mainTabelView.register(StudyTimeTableViewCell.self, forCellReuseIdentifier: study_time_cell_ID)
        mainTabelView.register(StudyAmountTableViewCell.self, forCellReuseIdentifier: study_amount_cell_ID)
        mainTabelView.register(StudyDistributeTableViewCell.self, forCellReuseIdentifier: study_distribute_cell_ID)
        self.creatHeadUI()
        mainTabelView.tableHeaderView = headView
        self.view.addSubview(mainTabelView)
    }
    // MARK: - delegate
    // MARK: - TableViewdelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            aimCell  = tableView.dequeueReusableCell(withIdentifier: study_aim_cell_ID, for: indexPath) as! StudyAimTableViewCell
            if (aimCell == nil)  {
                aimCell = StudyAimTableViewCell(style: .default, reuseIdentifier: study_aim_cell_ID)
            }
            return aimCell
        } else if indexPath.section == 1{
            timecell  = tableView.dequeueReusableCell(withIdentifier: study_time_cell_ID, for: indexPath) as! StudyTimeTableViewCell
            if (timecell == nil)  {
                timecell = StudyTimeTableViewCell(style: .default, reuseIdentifier: study_time_cell_ID)
            }
            weak var weakself = self
            timecell.timeClickBlock = {
                weakself?.timeCellClick()
            }
            return timecell
        } else if indexPath.section == 2{
            amountcell  = tableView.dequeueReusableCell(withIdentifier: study_amount_cell_ID, for: indexPath) as! StudyAmountTableViewCell
            if (amountcell == nil)  {
                amountcell = StudyAmountTableViewCell(style: .default, reuseIdentifier: study_amount_cell_ID)
            }
            weak var weakself = self
            amountcell.amountClickBlock = {
                weakself?.amountCellClick()

            }
            return amountcell
            
        } else if indexPath.section == 3{
            distributecell  = tableView.dequeueReusableCell(withIdentifier: study_distribute_cell_ID, for: indexPath) as! StudyDistributeTableViewCell
            if (distributecell == nil)  {
                distributecell = StudyDistributeTableViewCell(style: .default, reuseIdentifier: study_distribute_cell_ID)
            }
            weak var weakSelf = self

            distributecell.nestBlock = {(num) in

                let vc = TimeDistributeViewController()
                vc.hidesBottomBarWhenPushed = true
                if num == 0 {
                    vc.type = .time
                } else {
                    vc.type = .amount
                }
                weakSelf?.navigationController?.pushViewController(vc, animated: true)

            }
            return distributecell
        } else {
            var cell : StudyValueTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: study_value_cell_ID, for: indexPath) as! StudyValueTableViewCell
            if (cell == nil)  {
                cell = StudyValueTableViewCell(style: .default, reuseIdentifier: study_value_cell_ID)
            }
            return cell
        }

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                XJLog(message: "0")
                let vc = WeekAimViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)

            }
        } else if indexPath.section == 1 {
            self.timeCellClick()
        } else if indexPath.section == 2 {

            self.amountCellClick()
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let view : UIView = UIView()
        let nameLabel = UILabel.getLabel(fream:CGRect(x: ip6(19), y: ip6(30), width: KSCREEN_WIDTH - ip6(32), height: ip6(20)), fontSize: 15, text: sectionTitleArr[section], textColor: black_53, textAlignment: .left)
        view.addSubview(nameLabel)

        let lineView = UIView(frame: CGRect(x: ip6(10), y: ip6(51), width: KSCREEN_WIDTH - ip6(20), height: 1))
        lineView.backgroundColor = black_e3e3e3
        view.addSubview(lineView)

        return view
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return ip6(57)
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }




    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return study_aim_sectionHeight
        } else if indexPath.section == 1 {
            return study_time_sectionHeight
        } else if indexPath.section == 2 {
            return study_amount_sectionHeight
        } else if indexPath.section == 3 {
            return study_distribute_sectionHeight
        } else {
            return study_value_sectionHeight
        }
    }

    func timeCellClick() {
        XJLog(message: "时间详情")
        let vc = TimeDetailViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.type = .time
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func amountCellClick() {
        XJLog(message: "量详情")
        let vc = TimeDetailViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.type = .amount
        self.navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: - data
    func MineDatarequestSucceed() {
        headView.setData(model:  requestVC.getHeadViewModel())
        aimCell.setData(model: requestVC.getAimModel())
        timecell.setData(model: requestVC.getreportModel())
        amountcell.setData(model: requestVC.getreportModel())
        distributecell.setData(model: requestVC.getreportSumModel())
    }

    func MineDataRequestFail() {
        
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
