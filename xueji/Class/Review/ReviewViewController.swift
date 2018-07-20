//
//  ReviewViewController.swift
//  学记
//
//  Created by lvxin on 2017/8/29.
//  Copyright © 2017年 lvxin. All rights reserved.
//

import UIKit
let  ReviewCellID = "ReviewCell_id"

class ReviewViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,ReviewApiMangerViewControllerDelegate,ReviewTopViewDelegate ,ReviewDoneViewControllerDelegate{
    
    /// 头部视图
    var headBackView : ReviewTopView!
    var mainTabelView : UITableView!//
    
    let request : ReviewApiMangerViewController = ReviewApiMangerViewController()
    let doneRequest : ReviewDoneViewController = ReviewDoneViewController()

    /// 当前星期几
    let weekNum = String.getDayIndex()
    
    /// 目前头部选项
    var currectWeekNum : Int = String.getDayIndex()

    /// 具体步骤
    var stepView : StepView!

    /// 具体步骤数组
    var stepArr : [String] = []
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        self.navigationController?.setNavigationBarHidden(false, animated: animated)

        self.navigationbar_transparency()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigation_title_fontsize(name: "复习", fontsize: 20)
//        self.navigationBar_rightBtn_image(image: #imageLiteral(resourceName: "review_more"))
        self.creatHeadView()
        self.creatTableView()
        request.delegate = self
        doneRequest.delegate = self
        request.listRequest()
    }
    // MARK: -头部视图
    func creatHeadView() {
        headBackView = ReviewTopView(frame: CGRect(x: 0, y: LNAVIGATION_HEIGHT, width: KSCREEN_WIDTH, height: ip6(46)))
        headBackView.delegate = self
        self.view.addSubview(headBackView)
        

    }
    
    func creatTableView()  {
        mainTabelView = UITableView.init(frame: CGRect(x: 0, y: headBackView.frame.maxY , width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT - headBackView.frame.maxY), style: .grouped)
        mainTabelView.backgroundColor = UIColor.clear
        mainTabelView.delegate = self;
        mainTabelView.dataSource = self;
        mainTabelView.tableFooterView = UIView()
        mainTabelView.separatorStyle = .none
        mainTabelView.showsVerticalScrollIndicator = false
        mainTabelView.showsHorizontalScrollIndicator = false
        mainTabelView.setEditing(false, animated: true)
        mainTabelView.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewCellID)
        self.view.addSubview(mainTabelView)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return request.getListCount_day(dayNum: currectWeekNum)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : ReviewTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: ReviewCellID, for: indexPath) as! ReviewTableViewCell
        cell.isUserInteractionEnabled = true
        if (cell == nil)  {
            cell = ReviewTableViewCell(style: .default, reuseIdentifier: ReviewCellID)
        }
        cell.setData(model: request.getModel(rowNum: indexPath.row, currectDay: currectWeekNum))
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view : UIView = UIView()
        let nameLabel = UILabel.getLabel(fream: CGRect(x: ip6(10), y: ip6(16), width: KSCREEN_WIDTH - ip6(10), height: ip6(20)), fontSize: 15, text: "任务列表", textColor: black_53, textAlignment: .left)
        view.addSubview(nameLabel)
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ip6(50)
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        XJLog(message: "点击")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ReviewTableViewCellH
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let aciton1 :UITableViewRowAction = UITableViewRowAction(style: .default, title: "全部复习阶段") { (action, indexpath) in
            XJLog(message: "全部")
            self.stepArr = self.request.getReviewStep(rowNum: indexPath.row, currectDay: self.currectWeekNum)
            XJLog(message: self.stepArr)
            self.stepView = StepView(frame: CGRect(x: 0, y: self.headBackView.frame.maxY, width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT - self.headBackView.frame.maxY))
            self.stepView.setData(arr: self.stepArr)
            self.view.addSubview(self.stepView)
        }
        aciton1.backgroundColor = purple_5657CE

        let aciton2 :UITableViewRowAction = UITableViewRowAction(style: .default, title: "完成") { (action, indexpath) in
            XJLog(message: "完成")
            let model : ReviewModel_content = self.request.getModel(rowNum: indexPath.row, currectDay: self.currectWeekNum)
            self.doneRequest.doneRequest(id: model.reviewid, step: model.reviewstep)

        }
        aciton1.backgroundColor = purple_5657CE
        return [aciton2,aciton1]
    }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        XJLog(message: "删除")
    }
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func requestSucceed() {
        headBackView.creatUI(arr: request.getListArr())
        self.mainTabelView.reloadData()
    }
    
    func requestFail() {
        
    }
    func reviewDoneRequestSucceed() {
        self.request.reloadRequest()
    }
    func reviewDoneRequestFail() {

    }
    //MARK: event reponse
    
    /// 头部点击
    ///
    /// - Parameter num: <#num description#>
    func headDateClick(num: Int) {
        self.currectWeekNum = num - 1
        self.mainTabelView.reloadData()
    }
    
    
    /// 展示具体复习步骤
    func showSteps()  {
        
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
