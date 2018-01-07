//
//  StudyView.swift
//  xueji
//
//  Created by lvxin on 2017/12/21.
//  Copyright © 2017年 lvxin. All rights reserved.
//  登录view

import UIKit

protocol LoginViewDelegate: NSObjectProtocol{
    func login() ->Void
    func forgetPassword() ->Void
}

class LoginView: UIView {

    var delegate : LoginViewDelegate!
    
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

    /// 提示
    var noticeLabel : UILabel!
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
        self.isUserInteractionEnabled = true
        self.loadViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadViews() {
        
        titleLabel = UILabel.getLabel(fream: CGRect(x: ip6(28), y: ip6(35), width: ip6(80), height: ip6(31)), fontSize: 31, text: "学记", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x070707), textAlignment: .left)

        titleLabel_sub = UILabel.getLabel(fream: CGRect(x: ip6(28), y: titleLabel.frame.maxY + ip6(10), width: KSCREEN_WIDTH - ip6(56), height: ip6(15)), fontSize: 15, text: "加入学记，精细化管理学习", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x9a9a9a), textAlignment: .left)

        let backViewX = ip6(35)
        let backViewWidth = KSCREEN_WIDTH - backViewX * 2
        let backViewHeight = ip6(25)
        
        
        //手机号码
        let phoneBackView = UIView(frame: CGRect(x: backViewX, y: titleLabel_sub.frame.maxY + ip6(70), width: backViewWidth, height: backViewHeight))

        let phoneNameLabel  = UILabel.getLabel(fream: CGRect(x: 0, y: 0, width: ip6(60), height: ip6(15)), fontSize: ip6(15), text: "手机号码", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x9a9a9a), textAlignment: .left)
        phoneBackView.addSubview(phoneNameLabel)
        
        
        phoneTextFiled = UITextField()
        phoneTextFiled.frame = CGRect(x: phoneNameLabel.frame.maxX + ip6(20), y: 0, width: backViewWidth - ip6(80), height: ip6(15))
        phoneTextFiled.font = xj_fzFontMedium(ip6(15))
        phoneTextFiled.textColor = UIColor.xj_colorFromRGB(rgbValue: 0x070707)
        phoneTextFiled.adjustsFontSizeToFitWidth = true
        phoneTextFiled.textAlignment = .left
        phoneTextFiled.keyboardType = .numberPad
        phoneTextFiled.returnKeyType = .next
        phoneTextFiled.tag = 100
        phoneBackView.addSubview(phoneTextFiled)
        
        let lineView = UIView()
        let lineViewY = phoneBackView.frame.size.height - 0.5
        lineView.frame = CGRect(x: 0, y: lineViewY, width: backViewWidth, height: 0.5)
        lineView.backgroundColor =  UIColor.xj_colorFromRGB(rgbValue: 0xaaaaaa)
        phoneBackView.addSubview(lineView)
        
        //账号密码
        let scrBackView = UIView(frame: CGRect(x: backViewX, y: phoneBackView.frame.maxY + ip6(20), width: backViewWidth, height: backViewHeight))

        let scrNameLabel = UILabel.getLabel(fream: CGRect(x: 0, y: 0, width: ip6(30), height: ip6(21)), fontSize: 15, text: "密码", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x9a9a9a), textAlignment: .left)
        scrBackView.addSubview(scrNameLabel)
        
        
        passWorldTextFiled = UITextField()
        passWorldTextFiled.frame = CGRect(x: scrNameLabel.frame.maxX + ip6(20), y: ip6(3), width: backViewWidth - ip6(60) - ip6(40), height: ip6(15))
        let str = "（6-18位数字或字母组合）".getAttributedStr_color(color: UIColor.xj_colorFromRGB(rgbValue: 0x9a9a9a), fontSzie: 10)
        passWorldTextFiled.attributedPlaceholder = str
        passWorldTextFiled.adjustsFontSizeToFitWidth = true
        passWorldTextFiled.textAlignment = .left
        passWorldTextFiled.returnKeyType = .done
        passWorldTextFiled.isSecureTextEntry = true
        passWorldTextFiled.tag = 101
        passWorldTextFiled.font =  xj_fzFontMedium(ip6(15))
        passWorldTextFiled.adjustsFontSizeToFitWidth = true
        passWorldTextFiled.textColor = UIColor.xj_colorFromRGB(rgbValue: 0x070707)
        scrBackView.addSubview(passWorldTextFiled)

        let lineView2 = UIView()
        let lineViewY2 = scrBackView.frame.size.height - 0.5
        lineView2.frame = CGRect(x: 0, y: lineViewY2, width: backViewWidth, height: 0.5)
        lineView2.backgroundColor =  UIColor.xj_colorFromRGB(rgbValue: 0xaaaaaa)
        scrBackView.addSubview(lineView2)
        
  
        loginBtn = UIButton.getBtn_titleStyle(title_normal: "登陆", title_selected: "登陆", fream: CGRect(x: backViewX, y: scrBackView.frame.maxY + ip6(20), width: backViewWidth, height: ip6(35)), backgroundColor: UIColor.xj_colorFromRGB(rgbValue: 0x6C9CE2), textColor: .white, fontSize: 15, textAlignment: .center, selector: #selector(logInClick), vc: self, tag: 1)
        loginBtn.xj_makeRadius(radius: 4)
        
        forgetBtn = UIButton.getBtn_titleStyle(title_normal: "忘记密码？", title_selected: "忘记密码？", fream: CGRect(x: KSCREEN_WIDTH - ip6(35) - ip6(100), y: loginBtn.frame.maxY + ip6(10), width: ip6(100), height: ip6(14)), backgroundColor: .clear, textColor: UIColor.xj_colorFromRGB(rgbValue: 0x9a9a9a), fontSize: 15, textAlignment: .right, selector: #selector(logInClick), vc: self, tag: 1)

        //其他
        let leftViewWidth = (KSCREEN_WIDTH - ip6(210))/2
        let leftView = UIView(frame: CGRect(x: ip6(50), y: loginBtn.frame.maxY + ip6(141), width: leftViewWidth, height: 1))
        leftView.backgroundColor = UIColor.xj_colorFromRGB(rgbValue: 0xaaaaaa)

        noticeLabel = UILabel.getLabel(fream: CGRect(x: (KSCREEN_WIDTH - ip6(90))/2, y: loginBtn.frame.maxY + ip6(135), width: ip6(90), height: ip6(15)), fontSize: 15, text: "其他方式登录", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x9a9a9a), textAlignment: .center)

        let rightView = UIView(frame: CGRect(x: noticeLabel.frame.maxX + ip6(10), y: loginBtn.frame.maxY + ip6(141), width: leftViewWidth, height: 1))
        rightView.backgroundColor = UIColor.xj_colorFromRGB(rgbValue: 0xaaaaaa)

        //其他方式登录
        let imageArr = [#imageLiteral(resourceName: "base_wechart"),#imageLiteral(resourceName: "base_weibo"),#imageLiteral(resourceName: "base_qq")]
        let imageW = ip6(35)
        let imageH = ip6(30)
        let x = ip6(50)
        let appad = (KSCREEN_WIDTH - x * 2 - imageW * 3)/2


        for i in 0..<3 {
            let btn = UIButton.getBtn_picStyle(image_normal: imageArr[i], image_selected: imageArr[i], fream: CGRect(x: x + CGFloat(i) * (imageW + appad), y: noticeLabel.frame.maxY + ip6(30), width: imageW, height: imageH), selector: #selector(otherClick(sender:)), vc: self, tag: i)
            if i == 0 {
                weCharBtn = btn
            } else if i == 1 {
                weiboBtn = btn
            } else {
                qqBtn = btn
            }
            self.addSubview(btn)
        }

        self.addSubview(titleLabel)
        self.addSubview(titleLabel_sub)
        self.addSubview(phoneBackView)
        self.addSubview(scrBackView)
        self.addSubview(loginBtn)
        self.addSubview(forgetBtn)
        self.addSubview(leftView)
        self.addSubview(noticeLabel)
        self.addSubview(rightView)
    }
    
    func logInClick() {
        if self.delegate != nil {
            self.delegate.login()
        }
    }
    func forgetClick() {
        if self.delegate != nil {
            self.delegate.forgetPassword()
        }
    }
    func otherClick(sender : UIButton) {
        let btnTag = sender.tag
        if btnTag == 0 {
            XJLog(message: "微信")
        } else if btnTag == 1 {
            XJLog(message: "微博")
        }else {
            XJLog(message: "qq")
        }

    }
    
}
