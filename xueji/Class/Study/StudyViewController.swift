//
//  StudyViewController.swift
//  学记
//
//  Created by lvxin on 2017/8/29.
//  Copyright © 2017年 lvxin. All rights reserved.
//  学习页面

import UIKit
let headHeight = ip6(140)
let itemWidth :CGFloat = ip6(65)
let itemHeight :CGFloat = ip6(100)
let StudyBookCellID = "StudyBookCell_ID"
let FLISHDATA = "flishdata"
class StudyViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource,StudyApiMangerViewControllerDelegate,BookDelApiMangerDelegate{
    let headBackView : UIView = UIView()//头部视图
    var colletionView : UICollectionView!//图片浏览
    var mainTabelView : UITableView!//
    var alertController : UIAlertController!
    var isEdit : Bool = false//是否为编辑状态
    
    var bottomBtn : UIButton!//底部编辑按钮
    /// 分类数据请求管理
    var requestManger : StudyApiMangerViewController = StudyApiMangerViewController()

    /// 删除书籍请求
    var delBookReuqestManger : BookDelApiManger = BookDelApiManger()
    var catModel_del : CategoryListModel_list!
    var bookModel_del : CategoryListModel_list_book_list!




    // MARK: - lifeCirlce
    override func viewWillDisappear(_ animated: Bool) {
        requestManger.resetPage()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationbar_transparency()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(reflishData), name: NSNotification.Name(rawValue: FLISHDATA), object: nil)
        self.setUpNavigation_normal()
        self.creatTableView()
        requestManger.delegate = self
        delBookReuqestManger.delegate = self
        self.getData()
    }
    
    // MARK: - view
    func setUpNavigation_normal() {
        self.navigation_title_fontsize(name: "学习", fontsize: 20)
//        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "study_setup"))
        self.navigationBar_rightBtn_image(image: #imageLiteral(resourceName: "study_scan"))
    }
    
    func setUpNavigation_edit()  {
        self.navigation_title_fontsize(name: "资料编辑", fontsize: 20)
        self.navigationBar_rightBtn_title(title: "确定")
        self.navigationBar_leftBtn_title(title: "取消")
    }
    
 

    // MARK: - TableView视图
    func creatTableView()  {
        mainTabelView = UITableView.init(frame: CGRect(x: 0, y: LNAVIGATION_HEIGHT , width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT - headBackView.frame.maxY - LNAVIGATION_HEIGHT), style: .grouped)
        mainTabelView.backgroundColor = UIColor.clear
        mainTabelView.delegate = self;
        mainTabelView.dataSource = self;
        mainTabelView.tableFooterView = UIView()
        mainTabelView.separatorStyle = .none
        mainTabelView.showsVerticalScrollIndicator = false
        mainTabelView.showsHorizontalScrollIndicator = false
        self.view.addSubview(mainTabelView)
    }

    // MARK: - TableViewdelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return requestManger.getListArrCount();
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        weak var weakSelf = self
        if requestManger.getRecentListCount() > 0 {
            //有最近学习
            if indexPath.section == 0 {
                let cell  = StudyBookCellTableViewCell(style: .default, reuseIdentifier: StudyBookCellID)
                cell.setUpUI_recent(arr: requestManger.recent_learnListArr)
                cell.bookClickBlock = {model,catModel in
                    let vc = LearnViewController()
                    vc.model = model
                    vc.hidesBottomBarWhenPushed = true
                    weakSelf?.navigationController?.pushViewController(vc, animated: true)
                }
                cell.bookPresBlock = {model,catModel in
                    weakSelf?.showBookAleart(model: model, catModel: catModel)
                }
                return cell

            } else {
                let cell  = StudyBookCellTableViewCell(style: .default, reuseIdentifier: StudyBookCellID)
                let model  = requestManger.getModel(index:indexPath.section - 1)
                cell.setUpUI(model: model, indexPath: indexPath)
                
                cell.bookClickBlock = {model,catModel in
                    let vc = LearnViewController()
                    vc.model = model
                    vc.hidesBottomBarWhenPushed = true
                    weakSelf?.navigationController?.pushViewController(vc, animated: true)
                }
                cell.bookPresBlock = {model,catModel in
                    weakSelf?.showBookAleart(model: model, catModel: catModel)
                }
                return cell

            }

        } else {
            let cell  = StudyBookCellTableViewCell(style: .default, reuseIdentifier: StudyBookCellID)
            let model  = requestManger.getModel(index:indexPath.section)
            cell.setUpUI(model: model, indexPath: indexPath)
            cell.bookClickBlock = {model,catModel in
                let vc = LearnViewController()
                vc.model = model
                vc.hidesBottomBarWhenPushed = true
                weakSelf?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        }

    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = StudyHeadView()
        if requestManger.getRecentListCount() > 0 {
            if section == 0 {
                view.setUpData(nameStr: "最近学习")
            } else {
                let model = requestManger.getModel(index: section - 1)
                let name = model.getCatName()
                view.setUpData(nameStr: name)
            }
        } else {
            let model = requestManger.getModel(index: section)
            let name = model.getCatName()
            view.setUpData(nameStr: name)
        }

        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return StudyHeadViewH
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return requestManger.getRecentRowHeight()
        } else {
            return requestManger.getRowHeight(section: indexPath.section - 1)
        }

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    //网络代理
    func requestSucceed() {
        self.mainTabelView.reloadData()
    }
    func requestFail() {
        
    }
    func requestSucceed_BookDelApi() {
        requestManger.reflishData()
    }
    
    func requestFail_BookDelApi() {

    }
    // MARK: - net
    func getData() {
        requestManger.listRequest()
    }

    /// 刷新页面
    func reflishData() {
        requestManger.reflishData()
    }
    
    
    // MARK: - EvenResponse
    //添加书籍
    override func navigationRightBtnClick() {
        let login = UserDataManger.getLoginIdAndTokenInUD().isHaveLogin
        print("login\(login)")
        if login == "0" {
            //去登录注册
            self.login()
            return
        }
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
        let login = UserDataManger.getLoginIdAndTokenInUD().isHaveLogin
        print("login\(login)")
        if login == "0" {
            //去登录注册
            self.login()
            return
        }
        XJLog(message: "继续")

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

    func showEditView() {
        self.tabBarController?.tabBar.isHidden = true
        mainTabelView.frame.size.height = KSCREEN_HEIGHT - headBackView.frame.maxY - ip6(57)
        bottomBtn = UIButton.getBtn_title_imageStyle(title_normal: "分类设置", image_normal: #imageLiteral(resourceName: "study_setup"), fream: CGRect(x: 0, y: KSCREEN_HEIGHT - ip6(57) , width: KSCREEN_WIDTH, height: ip6(57)), imageEdgeInsets: UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0), backgroundColor: UIColor.xj_colorFromRGB(rgbValue: 0xf7f7f9), textColor: black_53, fontSize: 19, textAlignment: .center, selector: #selector(self.set_categary_click), vc: self, tag: 0)
        self.view.addSubview(bottomBtn)
    }
    func remoEditeView() {
        bottomBtn.removeFromSuperview()
        self.tabBarController?.tabBar.isHidden = false
        mainTabelView.frame.size.height = KSCREEN_HEIGHT - headBackView.frame.maxY
        
    }


    /// 长按书籍
    ///
    /// - Parameter model: <#model description#>
    func showBookAleart(model : CategoryListModel_list_book_list,catModel : CategoryListModel_list) {

        weak var weakSelf = self
        alertController  = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancleAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            //取消
            weakSelf?.alertController.dismiss(animated: true, completion: {

            })
        }
        let delAction = UIAlertAction(title: "删除此书", style: .default) { (action) in
            //删除此书
            weakSelf?.delBookReuqestManger.delRequest(id: model.id)


        }
        let lookAction = UIAlertAction(title: "查看详情", style: .default) { (action) in
            //查看详情
            let vc : AddBookViewController = AddBookViewController()
            vc.type = .detail
            vc.bookID = model.id
            vc.hidesBottomBarWhenPushed = true
            weakSelf?.navigationController?.pushViewController(vc, animated: true)

        }

        self.alertController.addAction(cancleAction)
        self.alertController.addAction(delAction)
        self.alertController.addAction(lookAction)
        self.present((weakSelf?.alertController)!, animated: true, completion: nil)
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
            let vc : ScanViewController = ScanViewController()
//            let nv = UINavigationController(rootViewController: vc)
            vc.hidesBottomBarWhenPushed = true
            weakSelf?.navigationController?.pushViewController(vc, animated: true)
//            self.present(nv, animated: true, completion: {
//
//            })

        }
        let selfAction = UIAlertAction(title: "手动添加", style: .default) { (action) in
            //手动添加
            let vc : AddBookViewController = AddBookViewController()
            vc.hidesBottomBarWhenPushed = true
            vc.type = .addBook_custom
            weakSelf?.navigationController?.pushViewController(vc, animated: true)
            
        }
        weakSelf?.alertController.addAction(cancleAction)
        weakSelf?.alertController.addAction(scanAction)
        weakSelf?.alertController.addAction(selfAction)
        self.present((weakSelf?.alertController)!, animated: true, completion: nil)
    }
    // 分类设置 点击
    func set_categary_click() {
        XJLog(message: "分类设置点击")
        let vc = EditCategoryViewController()
        self.navigationController?.pushViewController(vc, animated: true)


    }

    func login() {
        let vc = LogViewController()
        let na = UINavigationController(rootViewController: vc)
        self.present(na, animated: true) {

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
