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

class AddBookViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,AddBook_customViewControllerDelegate {

    var bookImageView : UIImageView!//书封面
    var mainTabelView : UITableView!//
    var alertController : UIAlertController!
    var pickerView:UIPickerView = UIPickerView()
    var requestManger:AddBook_customViewController = AddBook_customViewController()

    
    /// 书籍名字
    var titleStr: String!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    //MARK:life circle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigation_title_fontsize(name: "添加资料", fontsize: 20)
        self.navigationBar_rightBtn_title(title: "保存")
        self.navigationBar_leftBtn_title(title: "取消")
        self.creatUI()
    }

    // MARK: - 创建视图
    func creatUI() {
        bookImageView = UIImageView(frame: CGRect(x:(KSCREEN_WIDTH - ip6(100))/2, y: LNAVIGATION_HEIGHT + ip6(20), width: ip6(100), height: ip6(150)))
        bookImageView.setImage_kf(imageName: "", placeholderImage: #imageLiteral(resourceName: "book"))
        bookImageView.isUserInteractionEnabled = true
        self.view.addSubview(bookImageView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.bookIconImageView_click))
        bookImageView.addGestureRecognizer(tap)
        
        
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
    // MARK: delegate
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
            XJLog(message: mainTabelView.frame)
            let vc = SelectCatViewController()
            vc.fream = mainTabelView.frame
            vc.selectedCatBlock = {(catName) in
                let cell : AddBook_CatTableViewCell = self.mainTabelView.cellForRow(at: IndexPath.init(row: 4, section: 0)) as! AddBook_CatTableViewCell
                cell.catLabel.text = catName
            }
            self.addChildViewController(vc)
            self.view.addSubview(vc.view)
        }
    }
    //选择图片成功后代理
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any]) {
        //查看info对象
        XJLog(message: info)
        
        //获取选择的编辑后的
        let  image = info[UIImagePickerControllerEditedImage] as! UIImage
        //图片控制器退出
        picker.dismiss(animated: true, completion: {
            () -> Void in
            
            //显示图片
            self.bookImageView.image = image
            
        })
    }
    //网络代理
    func requestSucceed() {
        self.navigationLeftBtnClick()
    }
    func requestFail() {
        
    }
    
    // MARK: event response
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        XJLog(message: "保存")
        requestManger.delegate = self
        requestManger.addBook(title:"", cid: 0, img: "", author: "", publisher: "", pubdate: "", pages: 1)
    }
    
    func bookIconImageView_click() {
        alertController  = UIAlertController(title: nil, message: "添加封面", preferredStyle: .alert)
        let cancleAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            //取消
            self.alertController.dismiss(animated: true, completion: {
                
            })
        }
        let systemAction = UIAlertAction(title: "系统封面", style: .default) { (action) in
            //系统封面
            let vc = BookImagesViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        let takePhotoAction = UIAlertAction(title: "拍照", style: .default) { (action) in
            //拍照
            self.openCamera()
        }
        let albumAction = UIAlertAction(title: "相册", style: .default) { (action) in
            //相册
            self.openAlbum()
        }
        
        alertController.addAction(cancleAction)
        alertController.addAction(systemAction)
        alertController.addAction(takePhotoAction)
        alertController.addAction(albumAction)
        self.present((alertController)!, animated: true, completion: nil)
    }
    func openAlbum() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //初始化图片控制器
            let picker = UIImagePickerController()
            //设置代理
            picker.delegate = self
            //指定图片控制器类型
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            //设置是否允许编辑
            picker.allowsEditing = true
            
            //弹出控制器，显示界面
            self.present(picker, animated: true, completion: {
                () -> Void in
            })
        }else{
            XJLog(message: "读取相册错误")
        }
        
    }
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            //创建图片控制器
            let picker = UIImagePickerController()
            //设置代理
            picker.delegate = self
            //设置来源
            picker.sourceType = UIImagePickerControllerSourceType.camera
            //允许编辑
            picker.allowsEditing = true
            //打开相机
            self.present(picker, animated: true, completion: { () -> Void in
                
            })
        }else{
            XJLog(message: "找不到相机")
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
