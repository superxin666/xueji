//
//  AddBookViewController.swift
//  xueji
//
//  Created by lvxin on 2017/11/14.
//  Copyright © 2017年 lvxin. All rights reserved.
//  添加资料

import UIKit
let addBookCellHeight = ip6(42)
let addBook_CatCellHeight = ip6(72)
let AddBookCellID = "AddBookCell_id"
let AddBook_CatCellID = "AddBook_CatCellID"

class AddBookViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var bookImageView : UIImageView!//书封面
    var mainTabelView : UITableView!//

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigation_title_fontsize(name: "添加资料", fontsize: 20)
        self.navigationBar_rightBtn_title(title: "保存")
        self.navigationBar_leftBtn_title(title: "取消")
        self.creatUI()
    }

     // MARK: - 导航栏
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        XJLog(message: "保存")
    }
    // MARK: - 创建视图
    func creatUI() {
        bookImageView = UIImageView(frame: CGRect(x:(KSCREEN_WIDTH - ip6(100))/2, y: LNAVIGATION_HEIGHT + ip6(20), width: ip6(100), height: ip6(150)))
        bookImageView.setImage_kf(imageName: "", placeholderImage: #imageLiteral(resourceName: "book"))
        self.view.addSubview(bookImageView)
        
        mainTabelView = UITableView.init(frame: CGRect(x: 0, y: bookImageView.frame.maxY + ip6(30) , width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT - bookImageView.frame.maxY - ip6(30)), style: .plain)
        mainTabelView.backgroundColor = UIColor.clear
        mainTabelView.delegate = self;
        mainTabelView.dataSource = self;
        mainTabelView.tableFooterView = UIView()
        mainTabelView.separatorStyle = .none
        mainTabelView.showsVerticalScrollIndicator = false
        mainTabelView.showsHorizontalScrollIndicator = false
        mainTabelView.register(AddBookTableViewCell.self, forCellReuseIdentifier: AddBookCellID)
        mainTabelView.register(AddBook_CatTableViewCell.self, forCellReuseIdentifier: AddBook_CatCellID)
        
        self.view.addSubview(mainTabelView)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 4 {
            var cell : AddBookTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: AddBookCellID, for: indexPath) as! AddBookTableViewCell
            if (cell == nil)  {
                cell = AddBookTableViewCell(style: .default, reuseIdentifier: AddBookCellID)
            }
            cell.setData(rowNum: indexPath.row)
            return cell
        } else {
            var cell : AddBook_CatTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: AddBook_CatCellID, for: indexPath) as! AddBook_CatTableViewCell
            if (cell == nil)  {
                cell = AddBook_CatTableViewCell(style: .default, reuseIdentifier: AddBook_CatCellID)
            }
            return cell
        }

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < 4 {
            return addBookCellHeight
        } else {
           return addBook_CatCellHeight
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            XJLog(message: "选择分类")
            let vc = SelectCatViewController()
            vc.view.frame = mainTabelView.frame
            self.addChildViewController(vc)
            self.view.addSubview(vc.view)
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
