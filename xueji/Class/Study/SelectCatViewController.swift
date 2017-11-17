//
//  SelectCatViewController.swift
//  xueji
//
//  Created by lvxin on 2017/11/16.
//  Copyright © 2017年 lvxin. All rights reserved.
//  添加书本 选择分类view

import UIKit
typealias SelectCatViewControllerBlock = (_ str : String)->()

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
        titleLabel = UILabel(frame: CGRect(x: (KSCREEN_WIDTH - ip6(60))/2, y: ip6(22), width: ip6(60), height: ip6(25)))
        titleLabel.font = xj_fzFontMedium(ip6(15))
        titleLabel.textColor = black_53
        titleLabel.text = "选择分类"
        titleLabel.textAlignment = .left
        self.view.addSubview(titleLabel)
        
        addCat = UIButton(type: .custom)
        addCat.frame = CGRect(x: (KSCREEN_WIDTH - ip6(60))/2, y: titleLabel.frame.maxY + ip6(30), width: ip6(60), height: ip6(25))
        addCat.setTitle("添加分类", for: .normal)
        addCat.setTitleColor(blue_0076f9, for: .normal)
        addCat.titleLabel?.font = xj_fzFontMedium(ip6(12))
        addCat.addTarget(self, action: #selector(self.addCatBtn_click), for: .touchUpInside)
        self.view.addSubview(addCat)
        
        cancleBtn = UIButton(type: .custom)
        cancleBtn.frame = CGRect(x: ip6(14), y: ip6(24) , width: ip6(28), height: ip6(20))
        cancleBtn.setTitle("取消", for: .normal)
        cancleBtn.setTitleColor(black_53, for: .normal)
        cancleBtn.titleLabel?.font = xj_fzFontMedium(ip6(12))
        cancleBtn.addTarget(self, action: #selector(self.cancleBtn_click), for: .touchUpInside)
        self.view.addSubview(cancleBtn)
        
        compleBtn = UIButton(type: .custom)
        compleBtn.frame = CGRect(x:KSCREEN_WIDTH - ip6(42), y: ip6(24) , width: ip6(28), height: ip6(20))
        compleBtn.setTitle("完成", for: .normal)
        compleBtn.setTitleColor(black_53, for: .normal)
        compleBtn.titleLabel?.font = xj_fzFontMedium(ip6(12))
        compleBtn.addTarget(self, action: #selector(self.compleBtn_click), for: .touchUpInside)
        self.view.addSubview(compleBtn)
        
        
        mainTabelView = UITableView(frame: CGRect(x: 0, y: addCat.frame.maxY + ip6(30), width: fream.size.width, height: fream.size.height - addCat.frame.maxY - ip6(30)), style: .plain)
        mainTabelView.backgroundColor = UIColor.white
        mainTabelView.delegate = self;
        mainTabelView.dataSource = self;
        mainTabelView.tableFooterView = UIView()
        mainTabelView.separatorStyle = .none
        mainTabelView.showsVerticalScrollIndicator = false
        mainTabelView.showsHorizontalScrollIndicator = false
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
        cell.isUserInteractionEnabled = true
        cell.backgroundColor = .white
        if (cell == nil)  {
            cell = EditCatyTableViewCell(style: .default, reuseIdentifier: EditCatyCellID)
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