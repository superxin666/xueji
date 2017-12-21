//
//  StudyView.swift
//  xueji
//
//  Created by lvxin on 2017/12/21.
//  Copyright © 2017年 lvxin. All rights reserved.
//  登录view

import UIKit

class LoginView: UIView {

    /// 标题
    var titleLabel : UILabel!
    /// 副标题
    var titleLabel_sub : UILabel!
    /// 手机号 UITextField
    var phoneTextFiled : UITextField!
    /// 密码 UITextField
    var passWorldTextFiled : UITextField!
    /// 登录  button
    var loginBtn : UIButton!
    /// 忘记密码  button
    var forgetBtn : UIButton!
    /// 微信  button
    var weCharBtn : UIButton!
    /// 微博 button
    var weiboBtn : UIButton!
    /// qq  button
    var qqBtn : UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadViews() {
        titleLabel = UILabel.getLabel(fream: CGRect(x: 0, y: 0, width: 0, height: 0), fontSize: ip6(31), text: "学记", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x070707), textAlignment: .center)

        titleLabel_sub = UILabel.getLabel(fream: CGRect(x: 0, y: 0, width: 0, height: 0), fontSize: ip6(31), text: "加入学记，精细化管理学习", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x070707), textAlignment: .center)


        self.addSubview(titleLabel)
        self.addSubview(titleLabel_sub)
    }
    func loadFream() {

    }
}
