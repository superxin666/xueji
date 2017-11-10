//
//  UserViewController.swift
//  学记
//
//  Created by lvxin on 2017/8/29.
//  Copyright © 2017年 lvxin. All rights reserved.
//  tab --我的

import UIKit
let study_value_sectionHeight = ip6(148)//学习力
let study_aim_sectionHeight = ip6(126)//学习目标
let study_time_sectionHeight = ip6(236)//学习时间
let study_amount_sectionHeight = ip6(250)//学习量
let study_distribute_sectionHeight = ip6(148)//学习分布

class UserViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    var mainTabelView : UITableView!//
    var headView : UserHeadView!
    let sectionTitleArr : [String] = ["学习力","本周目标","学习时间","学习量","学习分布",]//
    
    
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
    }
    //MARK: 导航栏点击
    override func navigationLeftBtnClick() {
        
    }
    override func navigationRightBtnClick() {
        
    }
    //MARK: 头部视图
    func creatHeadUI() {
        headView  = UserHeadView(frame: CGRect(x: 0, y: LNAVIGATION_HEIGHT, width: KSCREEN_WIDTH, height: headViewHeight))
    
        self.view.addSubview(headView)
    }
    func creatTableView()  {
        mainTabelView = UITableView.init(frame: CGRect(x: 0, y: headView.frame.maxY + ip6(10) , width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT - headView.frame.maxY - ip6(10)), style: .grouped)
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
        mainTabelView.register(StudyBookCellTableViewCell.self, forCellReuseIdentifier: StudyBookCellID)
        //        mainTabelView.register(TeachTableViewCell.self, forCellReuseIdentifier: TEACHCELLID)
        self.view.addSubview(mainTabelView)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let  cell = StudyValueTableViewCell(style: .default, reuseIdentifier: "")
            return cell
        } else if indexPath.section == 1{
            let  cell = StudyAimTableViewCell(style: .default, reuseIdentifier: "")
            return cell
        } else if indexPath.section == 2{
            let  cell = StudyTimeTableViewCell(style: .default, reuseIdentifier: "")
            return cell
            
        } else if indexPath.section == 3{
            let  cell = StudyAmountTableViewCell(style: .default, reuseIdentifier: "")
            return cell
        } else {
            var cell : StudyBookCellTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: StudyBookCellID, for: indexPath) as! StudyBookCellTableViewCell
            if (cell == nil)  {
                cell = StudyBookCellTableViewCell(style: .default, reuseIdentifier: StudyBookCellID)
            }
            cell.setUpUI()
            return cell
        }

    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view : UIView = UIView()
        let nameLabel : UILabel = UILabel(frame: CGRect(x: ip6(19), y: ip6(8), width: KSCREEN_WIDTH - ip6(32), height: ip6(20)))
        nameLabel.text = sectionTitleArr[section]
        nameLabel.textAlignment = .left
        nameLabel.font = xj_fzFontMedium(ip6(15))
        nameLabel.textColor = black_53
        view.addSubview(nameLabel)
        
        let lineView = UIView(frame: CGRect(x: ip6(10), y: ip6(34), width: KSCREEN_WIDTH - ip6(20), height: 1))
        lineView.backgroundColor = black_e3e3e3
        view.addSubview(lineView)
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ip6(35)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return study_value_sectionHeight
        } else if indexPath.section == 1 {
            return study_aim_sectionHeight
        } else if indexPath.section == 2 {
            return study_time_sectionHeight
        } else if indexPath.section == 3 {
            return study_amount_sectionHeight
        } else if indexPath.section == 4{
            return study_distribute_sectionHeight
        } else {
            return 0
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
