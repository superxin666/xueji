//
//  SelectCatViewController.swift
//  xueji
//
//  Created by lvxin on 2017/11/16.
//  Copyright © 2017年 lvxin. All rights reserved.
//  添加书本 选择分类view

import UIKit
typealias SelectCatViewControllerBlock = (_ str : String)->()
let SelectedCatCellID = "SelectedCatCell_id"

class SelectCatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var mainTabelView : UITableView!//
    var dataArr : [String] = NSArray() as! [String]
    var fream :CGRect!
    
    var titleLabel:UILabel!
    var cancleBtn : UIButton!
    var compleBtn : UIButton!
    var addCat : UIButton!
    
    var selectedCatBlock : SelectCatViewControllerBlock!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.view.frame = fream
        self.creatUI()
        
    }
    func creatUI() {
        XJLog(message: "添加分类")
        for i in 1...16 {
            XJLog(message: "分类\(i)")
            dataArr.append("分类\(i)")
        }

        XJLog(message: fream)
        titleLabel = UILabel.getLabel(fream:CGRect(x: (KSCREEN_WIDTH - ip6(60))/2, y: ip6(22), width: ip6(60), height: ip6(25)), fontSize: 15, text: "选择分类", textColor: black_53, textAlignment: .left)
        self.view.addSubview(titleLabel)
        
        
        addCat = UIButton.getBtn_titleStyle(title_normal: "添加分类", title_selected: "", fream: CGRect(x: (KSCREEN_WIDTH - ip6(60))/2, y: titleLabel.frame.maxY + ip6(30), width: ip6(60), height: ip6(25)), backgroundColor: .white, textColorSelectrd: blue_0076f9, textColor: blue_0076f9, fontSize: 12, textAlignment: .center, selector: #selector(self.addCatBtn_click), vc: self,tag: 0)
        self.view.addSubview(addCat)
        
        cancleBtn = UIButton.getBtn_titleStyle(title_normal: "取消", title_selected: "", fream: CGRect(x: ip6(14), y: ip6(24) , width: ip6(28), height: ip6(20)), backgroundColor: .white, textColorSelectrd: black_53, textColor: black_53, fontSize: 12, textAlignment: .center, selector: #selector(self.cancleBtn_click), vc: self,tag: 0)
        self.view.addSubview(cancleBtn)
        
        compleBtn = UIButton.getBtn_titleStyle(title_normal: "完成", title_selected: "", fream: CGRect(x:KSCREEN_WIDTH - ip6(42), y: ip6(24) , width: ip6(28), height: ip6(20)), backgroundColor: .white, textColorSelectrd: black_53, textColor: black_53, fontSize: 12, textAlignment: .center, selector: #selector(self.compleBtn_click), vc: self,tag: 0)
        self.view.addSubview(compleBtn)
        
        
        mainTabelView = UITableView(frame: CGRect(x: 0, y: addCat.frame.maxY + ip6(30), width: fream.size.width, height: fream.size.height - addCat.frame.maxY - ip6(30)), style: .plain)
        mainTabelView.backgroundColor = UIColor.white
        mainTabelView.delegate = self;
        mainTabelView.dataSource = self;
        mainTabelView.tableFooterView = UIView()
        mainTabelView.separatorStyle = .none
        mainTabelView.showsVerticalScrollIndicator = false
        mainTabelView.showsHorizontalScrollIndicator = false
        mainTabelView.register(SelectedCatTableViewCell.self, forCellReuseIdentifier: SelectedCatCellID)
        self.view.addSubview(mainTabelView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell : SelectedCatTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: SelectedCatCellID, for: indexPath) as! SelectedCatTableViewCell
        cell.isUserInteractionEnabled = true
        cell.backgroundColor = .white
        if (cell == nil)  {
            cell = SelectedCatTableViewCell(style: .default, reuseIdentifier: SelectedCatCellID)
        }
        cell.setData(name: dataArr[indexPath.row] )
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ip6(51)
    }
    
    func compleBtn_click() {
        XJLog(message: "完成")
        if (selectedCatBlock != nil) {
            self.selectedCatBlock("你好分类")
        }
        self.cancleBtn_click()
    }
    
    func cancleBtn_click() {
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    func addCatBtn_click() {
        XJLog(message: "添加分类")
        let vc = AddCategoryViewController()
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
