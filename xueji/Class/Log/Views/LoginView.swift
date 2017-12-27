//
//  StudyView.swift
//  xueji
//
//  Created by lvxin on 2017/12/21.
//  Copyright © 2017年 lvxin. All rights reserved.
//  登录view

import UIKit

class LoginView: UIView ,UITextFieldDelegate{

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
        
        titleLabel = UILabel.getLabel(fream: CGRect(x: ip6(28), y: ip6(35), width: ip6(80), height: ip6(31)), fontSize: ip6(31), text: "学记", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x070707), textAlignment: .left)

        titleLabel_sub = UILabel.getLabel(fream: CGRect(x: ip6(28), y: titleLabel.frame.maxY + ip6(10), width: KSCREEN_WIDTH - ip6(56), height: ip6(15)), fontSize: ip6(15), text: "加入学记，精细化管理学习", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x9a9a9a), textAlignment: .left)

        let backViewWidth = KSCREEN_WIDTH - ip6(56)
        let backViewHeight = ip6(25)
        
        //手机号码
        let phoneBackView = UIView(frame: CGRect(x: ip6(28), y: titleLabel_sub.frame.maxY + ip6(70), width: backViewWidth, height: backViewHeight))

        
        let phoneNameLabel : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: ip6(60), height: ip6(15)))
        phoneNameLabel.text = "手机号码"
        phoneNameLabel.font = xj_fzFontMedium(ip6(15))
        phoneNameLabel.textColor  = UIColor.xj_colorFromRGB(rgbValue: 0x9a9a9a)
        phoneNameLabel.textAlignment = .left
        phoneNameLabel.adjustsFontSizeToFitWidth = true
        phoneBackView.addSubview(phoneNameLabel)
        
        
        phoneTextFiled = UITextField()
        phoneTextFiled.frame = CGRect(x: phoneNameLabel.frame.maxX + ip6(20), y: 0, width: backViewWidth - ip6(80), height: ip6(15))
        phoneTextFiled.font = xj_fzFontMedium(ip6(15))
        phoneTextFiled.textColor = UIColor.xj_colorFromRGB(rgbValue: 0x070707)
        phoneTextFiled.adjustsFontSizeToFitWidth = true
        phoneTextFiled.textAlignment = .left
        phoneTextFiled.keyboardType = .numberPad
        phoneTextFiled.returnKeyType = .next
        phoneTextFiled.delegate = self;
        phoneTextFiled.tag = 100
        phoneBackView.addSubview(phoneTextFiled)
        
        let lineView = UIView()
        let lineViewY = phoneBackView.frame.size.height - 0.5
        lineView.frame = CGRect(x: 0, y: lineViewY, width: phoneBackView.frame.size.width, height: 0.5)
        lineView.backgroundColor =  UIColor.xj_colorFromRGB(rgbValue: 0xaaaaaa)
        phoneBackView.addSubview(lineView)
        
        //账号密码
        let scrBackView = UIView(frame: CGRect(x: ip6(28), y: phoneBackView.frame.maxY + ip6(20), width: backViewWidth, height: backViewHeight))

        
        let scrNameLabel : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: ip6(30), height: ip6(21)))
        scrNameLabel.text = "密码"
        scrNameLabel.font = xj_fzFontMedium(ip6(15))
        scrNameLabel.textColor  = UIColor.xj_colorFromRGB(rgbValue: 0x9a9a9a)
        scrNameLabel.textAlignment = .left
        scrNameLabel.adjustsFontSizeToFitWidth = true
        scrBackView.addSubview(scrNameLabel)
        
        
        passWorldTextFiled = UITextField()
        passWorldTextFiled.frame = CGRect(x: scrNameLabel.frame.maxX + ip6(20), y: ip6(3), width: backViewWidth - ip6(60) - ip6(40), height: ip6(15))
        let str = "密码（6-18位数字或字母组合）".getAttributedStr_color(color: UIColor.xj_colorFromRGB(rgbValue: 0x9a9a9a), fontSzie: 10)
        passWorldTextFiled.attributedPlaceholder = str
        passWorldTextFiled.adjustsFontSizeToFitWidth = true
        passWorldTextFiled.textAlignment = .left
        passWorldTextFiled.returnKeyType = .done
        passWorldTextFiled.isSecureTextEntry = true
        passWorldTextFiled.delegate = self
        passWorldTextFiled.tag = 101
        passWorldTextFiled.font =  xj_fzFontMedium(ip6(15))
        passWorldTextFiled.adjustsFontSizeToFitWidth = true
        passWorldTextFiled.textColor = UIColor.xj_colorFromRGB(rgbValue: 0x070707)
        scrBackView.addSubview(passWorldTextFiled)

        let lineView2 = UIView()
        let lineViewY2 = scrBackView.frame.size.height - 0.5
        lineView2.frame = CGRect(x: 0, y: lineViewY2, width: scrBackView.frame.size.width, height: 0.5)
        lineView2.backgroundColor =  UIColor.xj_colorFromRGB(rgbValue: 0xaaaaaa)
        scrBackView.addSubview(lineView2)
        
        //登陆按钮
        
        let logBtn = UIButton(type: .custom)
        logBtn.frame = CGRect(x: 100, y: 200, width: 50, height: 50)
        logBtn.setTitle("登陆", for: .normal)
        logBtn.backgroundColor = .red
        logBtn.addTarget(self, action: #selector(logInClick), for: UIControlEvents.touchUpInside)
        self.addSubview(logBtn)
        
        self.addSubview(titleLabel)
        self.addSubview(titleLabel_sub)
        self.addSubview(phoneBackView)
        self.addSubview(scrBackView)
        
    }
    
    func logInClick() {
        
    }

}
