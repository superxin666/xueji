//
//  StudyViewController.swift
//  学记
//
//  Created by lvxin on 2017/8/29.
//  Copyright © 2017年 lvxin. All rights reserved.
//

import UIKit
let headHeight = ip6(140)
let itemWidth :CGFloat = ip6(65)
let itemHeight :CGFloat = ip6(100)
let StudyBookCellID = "StudyBookCell_ID"
class StudyViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource ,UITableViewDelegate,UITableViewDataSource{
    let headBackView : UIView = UIView()//头部视图
    var colletionView : UICollectionView!//图片浏览
    var mainTabelView : UITableView!//
    var alertController : UIAlertController!
    var isEdit : Bool = false//是否为编辑状态
    
    let bottomBtn : UIButton = UIButton()//底部编辑按钮
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.setUpNavigation_normal()
        self.creatHeadView()
        self.creatTableView()
    }
    // MARK: - 导航栏按钮
    
    func setUpNavigation_normal() {
        self.navigation_title_fontsize(name: "学习", fontsize: 20)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "study_setup"))
        self.navigationBar_rightBtn_image(image: #imageLiteral(resourceName: "study_scan"))
    }
    
    func setUpNavigation_edit()  {
        self.navigation_title_fontsize(name: "资料编辑", fontsize: 20)
        self.navigationBar_rightBtn_title(title: "确定")
        self.navigationBar_leftBtn_title(title: "取消")
    }
    
    //添加书籍
    override func navigationRightBtnClick() {
        if isEdit {
            //编辑状态 确定
            XJLog(message: "确定")
        } else {
            //正常状态 添加书籍
            self.addBookAleart()
        }

    }
    //编辑分类
    override func navigationLeftBtnClick() {
        if isEdit {
            //编辑分类 取消
            isEdit = false
            self.setUpNavigation_normal()
            self.remoEditeView()
        } else {
            //正常状态 编辑分类
            isEdit = true
            self.setUpNavigation_edit()
            self.showEditView()
        }
    }
    
    //添加书籍提示
    func addBookAleart() {
        weak var weakSelf = self
        alertController  = UIAlertController(title: nil, message: "添加学习资料", preferredStyle: .actionSheet)
        let cancleAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            //取消
            weakSelf?.alertController.dismiss(animated: true, completion: {
                
            })
        }
        let scanAction = UIAlertAction(title: "扫码添加", style: .default) { (action) in
            //扫码添加
            
        }
        let selfAction = UIAlertAction(title: "手动添加", style: .default) { (action) in
            //手动添加
            
        }
        weakSelf?.alertController.addAction(cancleAction)
        weakSelf?.alertController.addAction(scanAction)
        weakSelf?.alertController.addAction(selfAction)
        self.present((weakSelf?.alertController)!, animated: true, completion: nil)
    }
     // MARK: - 编辑页面
    func showEditView() {
        self.tabBarController?.tabBar.isHidden = true
        mainTabelView.frame.size.height = KSCREEN_HEIGHT - headBackView.frame.maxY - ip6(57)
        bottomBtn.frame = CGRect(x: 0, y: KSCREEN_HEIGHT - ip6(57) , width: KSCREEN_WIDTH, height: ip6(57))
        //
        bottomBtn.setTitle("分类设置", for: .normal)
        bottomBtn.setTitleColor(black_53, for: .normal)
        bottomBtn.backgroundColor = UIColor.xj_colorFromRGB(rgbValue: 0xf7f7f9)
        bottomBtn.setImage(#imageLiteral(resourceName: "study_setup"), for: .normal)
        bottomBtn.titleLabel?.font = xj_fzFontMedium(ip6(19))
        bottomBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        bottomBtn.addTarget(self, action: #selector(self.set_categary_click), for: .touchUpInside)
        self.view.addSubview(bottomBtn)
    }
    func remoEditeView() {
        bottomBtn.removeFromSuperview()
        self.tabBarController?.tabBar.isHidden = false
        mainTabelView.frame.size.height = KSCREEN_HEIGHT - headBackView.frame.maxY
        
    }
    // 分类设置 点击
    func set_categary_click() {
        XJLog(message: "分类设置点击")
        let vc = EditCategoryViewController()
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    // MARK: - 头部视图
    func creatHeadView() {
        headBackView.frame = CGRect(x: 0, y: LNAVIGATION_HEIGHT + ip6(5), width: KSCREEN_WIDTH, height: headHeight)
        self.view.addSubview(headBackView)
        
        //名字
        let headTitleLabel : UILabel = UILabel(frame: CGRect(x: ip6(16), y: ip6(10), width: ip6(80), height: ip6(20)))
        headTitleLabel.text = "最近学习"
        headTitleLabel.textColor = black_53
        headTitleLabel.textAlignment = .left
        headTitleLabel.font = xj_fzFontMedium(ip6(15))
        headBackView.addSubview(headTitleLabel)
        
        //图片
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = ip6(23)
        layout.minimumLineSpacing = ip6(23)
//        layout.sectionInset = UIEdgeInsetsMake(0, ip6(10), 0, ip6(10))
        colletionView = UICollectionView(frame: CGRect(x: ip6(21), y:  headTitleLabel.frame.maxY + ip6(10), width: KSCREEN_WIDTH - ip6(21), height: itemHeight), collectionViewLayout: layout)
        colletionView.register(HeadBookCollectionViewCell.self, forCellWithReuseIdentifier: "HeadBookCollectionViewCell_id")
        colletionView.backgroundColor = .clear
        colletionView.delegate = self
        colletionView.dataSource = self
        colletionView.contentSize = CGSize(width: itemWidth * 10, height: itemHeight)
        headBackView.addSubview(colletionView)
        
        
    }
    // MARK: - UICollectionViewDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if indexPath.row < imageArr.count {
            let cell :HeadBookCollectionViewCell  = collectionView.dequeueReusableCell(withReuseIdentifier: "HeadBookCollectionViewCell_id", for: indexPath) as! HeadBookCollectionViewCell
            //            var nameStr : String = ""
            //            var picStr :String = ""

//            cell.setUI(image: imageArr[indexPath.row], name: "")
            return cell
//        } else {
//            return UIView() as! UICollectionViewCell
//        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    // MARK: - TableView视图
    func creatTableView()  {
        mainTabelView = UITableView.init(frame: CGRect(x: 0, y: headBackView.frame.maxY , width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT - headBackView.frame.maxY), style: .plain)
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
    // MARK: - TableViewdelegate

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : StudyBookCellTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: StudyBookCellID, for: indexPath) as! StudyBookCellTableViewCell
        if (cell == nil)  {
            cell = StudyBookCellTableViewCell(style: .default, reuseIdentifier: StudyBookCellID)
        }
        cell.setUpUI()
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view : UIView = UIView()
        let nameLabel : UILabel = UILabel(frame: CGRect(x: ip6(16), y: ip6(12), width: KSCREEN_WIDTH - ip6(32), height: ip6(20)))
        nameLabel.text = "分类"
        nameLabel.textAlignment = .left
        nameLabel.font = xj_fzFontMedium(ip6(15))
        nameLabel.textColor = black_53
        view.addSubview(nameLabel)
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ip6(42)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ip6(216)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
