//
//  PersionInfoViewController.swift
//  xueji
//
//  Created by lvxin on 2018/7/10.
//  Copyright © 2018年 lvxin. All rights reserved.
//  个人资料

import UIKit
class PersionInfoViewController: BaseViewController,UITextFieldDelegate,ModifyProfileApiMangerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var alertController : UIAlertController!
    var dataModel : UserInfoModel_head!

    var iconImageView = UIImageView()
    var nameLabel : UILabel!
    var nameTextFiled : UITextField!


    var sexLabel : UILabel!
    var boyBtn : UIButton!
    var girlBtn : UIButton!


    var imageViewData : Data =  Data()
    var nameStr = ""
    var imageStr = ""


    let requestVC = ModifyProfileApiManger()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigation_title_fontsize(name: "个人资料", fontsize: 20)
        self.navigationBar_rightBtn_title(title: "保存")
        self.navigationBar_leftBtn_title(title: "取消")
        requestVC.delegate = self
        if let str =  dataModel.avatar{
            imageStr = str
        }
        if let str =  dataModel.username{
            nameStr = str
        }

        self.creatUI()
        
    }


    /// 画面
    func creatUI() {


        iconImageView = UIImageView(frame: CGRect(x: (KSCREEN_WIDTH - ip6(115))/2, y:LNAVIGATION_HEIGHT + ip6(30), width: ip6(115), height: ip6(115)))
        iconImageView.xj_makeRound()
        iconImageView.setImage_kf(imageName: dataModel.avatar, placeholderImage: #imageLiteral(resourceName: "bookLoading"))
        iconImageView.isUserInteractionEnabled = true
        self.view.addSubview(iconImageView)


        let tap = UITapGestureRecognizer(target: self, action: #selector(iconClick))
        iconImageView.addGestureRecognizer(tap)


        let nameBackView = UIView(frame: CGRect(x: ip6(25), y: iconImageView.frame.maxY + ip6(50), width: KSCREEN_WIDTH - ip6(50), height: ip6(28)))
        self.view.addSubview(nameBackView)

        let lineView1 = UIView(frame: CGRect(x: 0, y: ip6(27), width: nameBackView.frame.size.width, height: 0.5))
        lineView1.backgroundColor = black_ebebee
        nameBackView.addSubview(lineView1)


        nameLabel  = UILabel.getLabel(fream: CGRect(x: 0, y: 0, width: ip6(70), height: ip6(20)), fontSize: ip6(18), text: "姓名", textColor: black_53, textAlignment: .left)
        nameBackView.addSubview(nameLabel)

        nameTextFiled = UITextField()
        nameTextFiled.frame = CGRect(x:nameLabel.frame.maxX + ip6(10), y: 0, width: ip6(80), height: ip6(20))
        nameTextFiled.font = xj_fzFontMedium(ip6(18))
        nameTextFiled.textColor = UIColor.xj_colorFromRGB(rgbValue: 0x070707)
        nameTextFiled.adjustsFontSizeToFitWidth = true
        nameTextFiled.textAlignment = .left
        nameTextFiled.keyboardType = .default
        nameTextFiled.returnKeyType = .next
        nameTextFiled.tag = 100
        nameTextFiled.delegate = self
        nameTextFiled.text = dataModel.username
        nameBackView.addSubview(nameTextFiled)


//        let sexBackView = UIView(frame: CGRect(x: ip6(25), y: nameBackView.frame.maxY + ip6(60), width: KSCREEN_WIDTH - ip6(50), height: ip6(28)))
//        self.view.addSubview(sexBackView)
//
//        nameLabel  = UILabel.getLabel(fream: CGRect(x: 0, y: 0, width: ip6(70), height: ip6(20)), fontSize: ip6(18), text: "性别", textColor: black_53, textAlignment: .left)
//        sexBackView.addSubview(nameLabel)

//
//        boyBtn = UIButton.getBtn_titleStyle(title_normal: "男", title_selected: "男", fream: CGRect(x: 0, y: 0, width: 0, height: 0), backgroundColor:  UIColor.xj_colorFromRGB(rgbValue: 0xefefef), textColorSelectrd: .white, textColor: black_53, fontSize: 15, textAlignment: .center, selector: #selector(boyClick(sender:)), vc: self, tag: 0)
//
//        girlBtn = UIButton.getBtn_titleStyle(title_normal: "女", title_selected: "女", fream: CGRect(x: 0, y: 0, width: 0, height: 0), backgroundColor:  UIColor.xj_colorFromRGB(rgbValue: 0xefefef), textColorSelectrd: .white, textColor: black_53, fontSize: 15, textAlignment: .center, selector: #selector(boyClick(sender:)), vc: self, tag: 1)
//
//        sexBackView.addSubview(boyBtn)
//        sexBackView.addSubview(girlBtn)

//        let lineView2 = UIView(frame: CGRect(x: 0, y: ip6(27), width: nameBackView.frame.size.width, height: 0.5))
//        lineView2.backgroundColor = black_ebebee
//        sexBackView.addSubview(lineView2)
//        self.view.addSubview(sexBackView)


    }

//    func boyClick(sender : UIButton) {
//
//    }



    func textFieldDidEndEditing(_ textField: UITextField) {
        if let str = textField.text{
            nameStr = str
        }

    }

    func requestSucceed_modifyProfile() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: FLISHDATA_user), object: nil)
        self.navigationController?.popToRootViewController(animated: true)
        
    }

    func requestFail_modifyProfile() {

    }

    func iconClick() {
        alertController  = UIAlertController(title: nil, message: "添加封面", preferredStyle: .alert)
        let cancleAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            //取消
            self.alertController.dismiss(animated: true, completion: {

            })
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

    //选择图片成功后代理
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any]) {
        //查看info对象
        XJLog(message: info)

        //获取选择的编辑后的
        let  image = info[UIImagePickerControllerEditedImage] as! UIImage
        imageViewData = UIImageJPEGRepresentation(image, 0.1)!

        //图片控制器退出
        picker.dismiss(animated: true, completion: {
            () -> Void in

            //显示图片
            self.iconImageView.image = image
        })
    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }

    override func navigationRightBtnClick() {
        self.view.endEditing(true)
        if imageViewData.count > 0 {
            //有图片
            weak var weakself = self
            SVPMessageShow.showLoad(infoStr: "正在保存中~~")
            BaseApiMangerViewController.uploadfile(imgageData: imageViewData, completion: { (data) in
                let url : String = data as! String
                weakself?.imageStr = url
                weakself?.requestVC.modifyProfileRequest(name: (weakself?.nameStr)!, avatar: (weakself?.imageStr)!)
            }) { (erro) in
                SVPMessageShow.showErro(infoStr: "上传图片失败请重新尝试~")
            }

        } else {
            //无图片
            requestVC.modifyProfileRequest(name: nameStr, avatar: imageStr)

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
