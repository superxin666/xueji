//
//  AddCategoryViewController.swift
//  xueji
//
//  Created by lvxin on 2017/11/2.
//  Copyright © 2017年 lvxin. All rights reserved.
//  添加分类

import UIKit

class AddCategoryViewController: BaseViewController,UITextFieldDelegate,CategoryAddApiViewControllerDelegate {
    var nameLabel :UILabel!
    var requestManger:CategoryAddApiViewController!
    var cateStr :String = ""
    var txtField :UITextField!

    // MARK: lifeCircle


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.navigation_title_fontsize(name: "新增分类", fontsize: 20)
        self.navigationBar_rightBtn_title(title: "确定")
        self.navigationBar_leftBtn_title(title: "取消")
        requestManger = CategoryAddApiViewController()
        self.creatUI()
    }
    

    // MARK: UI
    func creatUI() {
        let backView : UIView = UIView(frame: CGRect(x: ip6(40), y:LNAVIGATION_HEIGHT + ip6(60), width: KSCREEN_WIDTH - ip6(80), height: ip6(27)))
        self.view.addSubview(backView)
        
        nameLabel = UILabel.getLabel(fream:CGRect(x: 0, y: 0, width: ip6(54), height: ip6(25)), fontSize: 18, text: "标 题", textColor: black_53, textAlignment: .left)
        backView.addSubview(nameLabel)
        
        txtField = UITextField(frame: CGRect(x: nameLabel.frame.maxX + ip6(20), y: 0, width: backView.frame.size.width - nameLabel.frame.maxX - ip6(20), height: ip6(25)))
        backView.addSubview(txtField)
        txtField.placeholder = "请输入标题（最多8个字）"
        txtField.delegate = self
        txtField.returnKeyType = .done
        txtField.font = xj_fzFontMedium(ip6(16))
        backView.addSubview(txtField)
        
        let lineview = UIView(frame: CGRect(x: 0, y: 26, width: KSCREEN_WIDTH - ip6(80), height: 1))
        lineview.backgroundColor = black_e3e0e0
        backView.addSubview(lineview)
        
    }
    // MARK: delegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        cateStr = textField.text!
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {

    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.resignFirstResponder()
        }
        return true
    }
    //net
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
        if txtField.isFirstResponder {
            txtField.resignFirstResponder()
        }
        XJLog(message: cateStr)
        requestManger.delegate = self 
        requestManger.addCategoryRequest(name: cateStr)
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
