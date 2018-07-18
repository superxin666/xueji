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


enum AddBookViewController_type {
    case detail//详情
    case addBook_custom//自定义添加
    case addBook_scan//扫描添加(isbn)
    case editBook_custom//编辑 自定义添加的书籍
    case editBook_scan//编辑 扫描添加(isbn)的书籍
}

class AddBookViewController: BaseTableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,BookAddApiViewControllerDelegate,AddBookTableViewCellDelegate {

    var bookImageView : UIImageView!//书封面
    var mainTabelView : UITableView!//
    var alertController : UIAlertController!
    var pickerView:UIPickerView = UIPickerView()
    var requestManger:BookAddApiViewController = BookAddApiViewController()

    var bookCell :AddBookTableViewCell!
    var catCell :AddBook_CatTableViewCell!


    /// 书籍名字
//    var titleStr: String!
    /// 默认为 详情
    var type : AddBookViewController_type = .detail
    /// 书的数据模型  扫描添加
    var bookModel : BookModel!
    /// 书籍id  查看详情
    var bookID : Int!

    /// 选择分类模型
    var catModel : CategoryListModel_list!

    /// 分类id 添加书籍（默认为0）  编辑书籍
    var catID = 0


    /// 标题名字
    var titleStr = ""

    /// 作者名字
    var publisher = ""

    /// 页数
    var pages = ""

    /// 出版社
    var publish = ""

    /// 封皮
    var bookImageData : Data = Data()

    /// 封皮url
    var bookImageUrl : String = ""

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false

    }
    
    //MARK:life circle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigation_title_fontsize(name: "添加资料", fontsize: 20)
        requestManger.delegate = self
        if self.type == .addBook_custom || self.type == .addBook_scan {
            self.navigationBar_rightBtn_title(title: "保存")
            self.navigationBar_leftBtn_title(title: "取消")
        }  else if self.type == .detail {
            self.navigationBar_leftBtn_title(title: "返回")
            self.navigationBar_rightBtn_title(title: "编辑")
            requestManger.getMyBookInfoByBookID(bookID: self.bookID)

        }
        self.creatUI()
    }

    // MARK: - 创建视图
    func creatUI() {

        mainTabelView = UITableView.init(frame: CGRect(x: 0, y: 0 , width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT), style: .grouped)
        mainTabelView.backgroundColor = .white
        mainTabelView.tableFooterView = UIView()
        mainTabelView.separatorStyle = .none
        mainTabelView.showsVerticalScrollIndicator = false
        mainTabelView.showsHorizontalScrollIndicator = false
        mainTabelView.register(AddBookTableViewCell.self, forCellReuseIdentifier: AddBookCellID)
        mainTabelView.register(AddBook_CatTableViewCell.self, forCellReuseIdentifier: AddBook_CatCellID)
        self.tableView = mainTabelView
        

    }
    // MARK: delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 4 {
            bookCell  = tableView.dequeueReusableCell(withIdentifier: AddBookCellID, for: indexPath) as! AddBookTableViewCell
            bookCell.delegate = self
            if (bookCell == nil)  {
                bookCell = AddBookTableViewCell(style: .default, reuseIdentifier: AddBookCellID)
            }
            if type == .addBook_custom {
                //手动添加
                bookCell.setData(rowNum: indexPath.row)

            } else if type == .addBook_scan {
                //扫描添加
                bookCell.setData_scan(model: bookModel, rowNum: indexPath.row)

            } else if type == .detail{
                //详情
                bookCell.setData_detail(model: requestManger.getMyBookModel(), rowNum: indexPath.row)
                bookCell.isUserInteractionEnabled = false
            } else if type == .editBook_custom {
                //手动 编辑
                bookCell.setData_detail(model: requestManger.getMyBookModel(), rowNum: indexPath.row)
                bookCell.isUserInteractionEnabled = true
            } else if type == .editBook_scan {
                //扫描 编辑
                bookCell.setData_detail(model: requestManger.getMyBookModel(), rowNum: indexPath.row)
                bookCell.isUserInteractionEnabled = false
            }
            return bookCell
        } else {
            catCell  = tableView.dequeueReusableCell(withIdentifier: AddBook_CatCellID, for: indexPath) as! AddBook_CatTableViewCell
            if (catCell == nil)  {
                catCell = AddBook_CatTableViewCell(style: .default, reuseIdentifier: AddBook_CatCellID)
            }
            if type == .detail {
                catCell.isUserInteractionEnabled = false
                if let name = self.requestManger.getMyBookModel().category.name {
                    catCell.setTitle(name: name)
                }
            } else if type == .addBook_scan {
                catCell.setTitle(name: "默认分类")
            } else if type == .editBook_scan || type == .editBook_custom {
                catCell.isUserInteractionEnabled = true
            }
            return catCell
        }

    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_HEIGHT, height: ip6(180)))
        bookImageView = UIImageView(frame: CGRect(x:(KSCREEN_WIDTH - ip6(100))/2, y: ip6(20), width: ip6(100), height: ip6(150)))
        if self.type == .addBook_scan {
            bookImageView.isUserInteractionEnabled = false
            bookImageView.setImage_kf(imageName: bookModel.cover_img, placeholderImage: #imageLiteral(resourceName: "bookLoading"))
        } else if type == .detail || type == .editBook_scan {
            bookImageView.isUserInteractionEnabled = false
            if let url = requestManger.getMyBookModel().book.cover_img {
                bookImageView.setImage_kf(imageName: url, placeholderImage: #imageLiteral(resourceName: "bookLoading"))
            }
        } else if type == .addBook_custom {
            bookImageView.isUserInteractionEnabled = true
            bookImageView.setImage_kf(imageName: "", placeholderImage: #imageLiteral(resourceName: "addbookcover"))
        } else if type == .editBook_custom{
            bookImageView.isUserInteractionEnabled = true
            if let url = requestManger.getMyBookModel().book.cover_img {
                bookImageView.setImage_kf(imageName: url, placeholderImage: #imageLiteral(resourceName: "bookLoading"))
            }
        }

        self.view.addSubview(bookImageView)

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.bookIconImageView_click))
        bookImageView.addGestureRecognizer(tap)
        view.addSubview(bookImageView)


        return view
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ip6(180)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < 4 {
            return addBookCellHeight
        } else {
           return addBook_CatCellHeight
        }
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            self.view.endEditing(true)
            XJLog(message: "选择分类")
            XJLog(message: mainTabelView.frame)
            let vc = SelectCatViewController()
            vc.fream = CGRect(x: 0, y: ip6(180), width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT - ip6(180))
            weak var weakself = self
            vc.selectedCatBlock = {(model) in
                weakself?.catModel = model
                weakself?.catID = model.id
                let cell : AddBook_CatTableViewCell = self.mainTabelView.cellForRow(at: IndexPath.init(row: 4, section: 0)) as! AddBook_CatTableViewCell
                cell.setTitle(name: model.name!)
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
        bookImageData = UIImageJPEGRepresentation(image, 0.1)!

        //图片控制器退出
        picker.dismiss(animated: true, completion: {
            () -> Void in
            
            //显示图片
            self.bookImageView.image = image
        })
    }
    //网络代理
    func requestSucceed(type : BookAddApiType) {
        if type == .add_custom {
            NotificationCenter.default.post(name: Notification.Name(rawValue: FLISHDATA), object: nil)
            self.navigationLeftBtnClick()
        } else if type == .add_isbn{
            NotificationCenter.default.post(name: Notification.Name(rawValue: FLISHDATA), object: nil)
            self.navigationLeftBtnClick()

        } else if type == .getMyBookInfo{
            if let id = self.requestManger.getMyBookModel().category.id {
                catID = id
            }

            self.mainTabelView.reloadData()
        } else {
             NotificationCenter.default.post(name: Notification.Name(rawValue: FLISHDATA), object: nil)
            self.navigationLeftBtnClick()
        }
    }
    func requestFail(type : BookAddApiType) {
        
    }

    func endInput(contentStr: String, tagNum: Int) {
        if tagNum == 0 {
            //标题
            titleStr = contentStr
            XJLog(message: titleStr)
        } else if tagNum == 1 {
            //作者
            publisher = contentStr
            XJLog(message: publisher)

        } else if tagNum == 2 {
            //页数
            pages = contentStr
            XJLog(message: pages)

        } else {
            //出版社
            publish = contentStr
            XJLog(message: publish)
        }
    }
    
    // MARK: event response
    override func navigationLeftBtnClick() {
        if self.type == .addBook_scan {
            
            self.navigationController?.popToRootViewController(animated: true)
        } else {

            self.navigationController?.popViewController(animated: true)
        }
    }
    override func navigationRightBtnClick() {
        XJLog(message: "保存")
        self.view.endEditing(true)
        if self.type == .addBook_scan {
            requestManger.addBookRequestByIsbn(isbn: bookModel.isbn, cid: catID)


        } else if self.type == .addBook_custom {
            if bookImageData.count > 0 {
                //有图片
                weak var weakself = self
                SVPMessageShow.showLoad(infoStr: "正在保存中~~")
                BaseApiMangerViewController.uploadfile(imgageData: bookImageData, completion: { (data) in
                    let url : String = data as! String
                    weakself?.bookImageUrl = url
                    weakself?.requestManger.addBookByCustom(cid: (weakself?.catID)!, title: (weakself?.titleStr)!, img: (weakself?.bookImageUrl)!, author: (weakself?.publisher)!, publisher: (weakself?.publish)!, pubdate: "", pages: (weakself?.pages)!)

                }) { (erro) in
                     SVPMessageShow.showErro(infoStr: "上传图片失败请重新尝试~")
                }
            } else {
                requestManger.addBookByCustom(cid: catID, title: titleStr, img: bookImageUrl, author: publisher, publisher: publish, pubdate: "", pages: pages)

            }


        } else if type == .detail {
            if requestManger.getMyBookModel().book.douban_id > 0 {
                //扫描（isbn）书籍
                self.type = .editBook_scan
                self.navigationBar_rightBtn_title(title: "确定")
                mainTabelView.reloadData()


            } else {
                //自定义添加
                self.type = .editBook_custom
                self.navigationBar_rightBtn_title(title: "确定")
                titleStr = requestManger.getMyBookModel().book.title!
                publisher = requestManger.getMyBookModel().book.author_first!
                publish = requestManger.getMyBookModel().book.publisher!
                pages = "\(requestManger.getMyBookModel().book.pages!)"
                catID = requestManger.getMyBookModel().category.id!
                bookImageUrl = requestManger.getMyBookModel().book.cover_img
                mainTabelView.reloadData()
            }
        } else if type == .editBook_scan {
            requestManger.editBookRequestByIsbn(bid: bookID, isbn: requestManger.getMyBookModel().book.isbn, cid: catID)

        } else if type == .editBook_custom {

            if bookImageData.count > 0 {
                //有图片
                weak var weakself = self
                SVPMessageShow.showLoad(infoStr: "正在保存中~~")
                BaseApiMangerViewController.uploadfile(imgageData: bookImageData, completion: { (data) in
                    let url : String = data as! String
                    weakself?.bookImageUrl = url
                    weakself?.requestManger.editeBookByCustom(bid: (weakself?.bookID)!,cid: (weakself?.catID)!, title: (weakself?.titleStr)!, img: (weakself?.bookImageUrl)!, author: (weakself?.publisher)!, publisher: (weakself?.publish)!, pubdate: "", pages: (weakself?.pages)!)

                }) { (erro) in
                    SVPMessageShow.showErro(infoStr: "上传图片失败请重新尝试~")
                }
            } else {
                requestManger.editeBookByCustom(bid: bookID, cid: catID, title: titleStr, img: bookImageUrl, author: publisher, publisher: publish, pubdate: "", pages: pages)
            }
        }
    }



    
    func bookIconImageView_click() {
        alertController  = UIAlertController(title: nil, message: "添加封面", preferredStyle: .alert)
        let cancleAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            //取消
            self.alertController.dismiss(animated: true, completion: {
                
            })
        }
//        let systemAction = UIAlertAction(title: "系统封面", style: .default) { (action) in
//            //系统封面
//            let vc = BookImagesViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
//
//        }
        let takePhotoAction = UIAlertAction(title: "拍照", style: .default) { (action) in
            //拍照
            self.openCamera()
        }
        let albumAction = UIAlertAction(title: "相册", style: .default) { (action) in
            //相册
            self.openAlbum()
        }
        
        alertController.addAction(cancleAction)
//        alertController.addAction(systemAction)
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
