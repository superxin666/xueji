//
//  EditCategoryViewController.swift
//  xueji
//
//  Created by lvxin on 2017/11/2.
//  Copyright © 2017年 lvxin. All rights reserved.
//  编辑分类

import UIKit
let EditCatyCellID = "EditCatyCell_ID"

class EditCategoryViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{
    var mainTabelView : UITableView!//
    var dataArr : [String] = NSArray() as! [String]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.navigation_title_fontsize(name: "分类", fontsize: 20)
        self.navigationBar_rightBtn_image(image: #imageLiteral(resourceName: "study_plus"))
        self.navigationBar_leftBtn_title(title: "返回")
        for i in 1...16 {
            dataArr.append("分类\(i)")
        }
        self.creatTableView()
    
    }
    
    override func navigationRightBtnClick() {

    }
    func creatTableView()  {
        mainTabelView = UITableView.init(frame: CGRect(x: 0, y:LNAVIGATION_HEIGHT + ip6(25) , width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT - ip6(25) - LNAVIGATION_HEIGHT), style: .plain)
        mainTabelView.backgroundColor = UIColor.clear
        mainTabelView.delegate = self;
        mainTabelView.dataSource = self;
        mainTabelView.tableFooterView = UIView()
        mainTabelView.separatorStyle = .none
        mainTabelView.showsVerticalScrollIndicator = false
        mainTabelView.showsHorizontalScrollIndicator = false
        mainTabelView.setEditing(true, animated: true)
        mainTabelView.register(EditCatyTableViewCell.self, forCellReuseIdentifier: EditCatyCellID)
        self.view.addSubview(mainTabelView)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : EditCatyTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: EditCatyCellID, for: indexPath) as! EditCatyTableViewCell
        if (cell == nil)  {
            cell = EditCatyTableViewCell(style: .default, reuseIdentifier: EditCatyCellID)
        }
        cell.setData(name: dataArr[indexPath.row] )
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ip6(51)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        XJLog(message: "样式")
        return UITableViewCellEditingStyle.none
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        return
//    }
    

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        XJLog(message: "起始位置\(sourceIndexPath)")
        XJLog(message: "重点位置\(destinationIndexPath)")
    }
    
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
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
