//
//  RegistView.swift
//  xueji
//
//  Created by lvxin on 2018/1/7.
//  Copyright © 2018年 lvxin. All rights reserved.
//  注册

import UIKit

class RegistView: UIView {
    /// 标题
    var titleLabel : UILabel!
    /// 副标题
    var titleLabel_sub : UILabel!
    /// 手机号 UITextField
    var phoneTextFiled : UITextField!
    /// 验证码 UITextField
    var codeWorldTextFiled : UITextField!
    /// 密码 UITextField
    var passWorldTextFiled : UITextField!
    /// 注册  button
    var registBtn : UIButton!
    /// 获取验证码
    var getCodeLabel : UILabel!
    /// 提示
    var noticeLabel : UILabel!
    /// 时间器
    var time : Timer!
    /// 倒计时 时间
    var timeNum  = 60
    /// 手机号 背景
    var phoneBackView  : UIView!
    /// 密码 背景
    var scrBackView : UIView!
    /// 验证码 背景
    var codeBackView : UIView!

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
        phoneBackView = UIView(frame: CGRect(x: backViewX, y: titleLabel_sub.frame.maxY + ip6(70), width: backViewWidth, height: backViewHeight))

        let phoneNameLabel  = UILabel.getLabel(fream: CGRect(x: 0, y: 0, width: ip6(60), height: ip6(15)), fontSize: ip6(15), text: "手机号", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x9a9a9a), textAlignment: .left)
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

        //验证码
        codeBackView = UIView(frame: CGRect(x: backViewX, y: phoneBackView.frame.maxY + ip6(20), width: backViewWidth, height: backViewHeight))

        let codeNameLabel = UILabel.getLabel(fream: CGRect(x: 0, y: 0, width: ip6(45), height: ip6(15)), fontSize: 15, text: "验证码", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x9a9a9a), textAlignment: .left)
        codeBackView.addSubview(codeNameLabel)


        codeWorldTextFiled = UITextField()
        codeWorldTextFiled.frame = CGRect(x: codeNameLabel.frame.maxX + ip6(20), y: 0, width: backViewWidth - ip6(80) - ip6(50), height: ip6(15))
        codeWorldTextFiled.font = xj_fzFontMedium(ip6(15))
        codeWorldTextFiled.textColor = UIColor.xj_colorFromRGB(rgbValue: 0x070707)
        codeWorldTextFiled.adjustsFontSizeToFitWidth = true
        codeWorldTextFiled.textAlignment = .left
        codeWorldTextFiled.keyboardType = .numberPad
        codeWorldTextFiled.returnKeyType = .next
        codeWorldTextFiled.tag = 100
        codeBackView.addSubview(codeWorldTextFiled)

        //获取验证码
        getCodeLabel = UILabel.getLabel(fream: CGRect(x: backViewWidth - ip6(50), y: 0, width: ip6(50), height: ip6(22)), fontSize: 10, text: "获取验证码", textColor: .white, textAlignment: .center)
        getCodeLabel.backgroundColor = UIColor.xj_colorFromRGB(rgbValue: 0x6C9CE2)
        getCodeLabel.xj_makeRadius(radius: 4)
        codeBackView.addSubview(getCodeLabel)


        let lineView2 = UIView()
        let lineViewY2 = codeBackView.frame.size.height - 0.5
        lineView2.frame = CGRect(x: 0, y: lineViewY2, width: backViewWidth, height: 0.5)
        lineView2.backgroundColor =  UIColor.xj_colorFromRGB(rgbValue: 0xaaaaaa)
        codeBackView.addSubview(lineView2)


        //账号密码
        scrBackView = UIView(frame: CGRect(x: backViewX, y: codeBackView.frame.maxY + ip6(20), width: backViewWidth, height: backViewHeight))

        let scrNameLabel = UILabel.getLabel(fream: CGRect(x: 0, y: 0, width: ip6(30), height: ip6(15)), fontSize: 15, text: "密码", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x9a9a9a), textAlignment: .left)
        scrBackView.addSubview(scrNameLabel)


        passWorldTextFiled = UITextField()
        passWorldTextFiled.frame = CGRect(x: scrNameLabel.frame.maxX + ip6(20), y: ip6(3), width: backViewWidth - ip6(60) - ip6(40), height: ip6(15))
        passWorldTextFiled.adjustsFontSizeToFitWidth = true
        passWorldTextFiled.textAlignment = .left
        passWorldTextFiled.returnKeyType = .done
        passWorldTextFiled.isSecureTextEntry = true
        passWorldTextFiled.tag = 101
        passWorldTextFiled.font =  xj_fzFontMedium(ip6(15))
        passWorldTextFiled.adjustsFontSizeToFitWidth = true
        passWorldTextFiled.textColor = UIColor.xj_colorFromRGB(rgbValue: 0x070707)
        scrBackView.addSubview(passWorldTextFiled)

        let lineView3 = UIView()
        let lineViewY3 = scrBackView.frame.size.height - 0.5
        lineView3.frame = CGRect(x: 0, y: lineViewY3, width: backViewWidth, height: 0.5)
        lineView3.backgroundColor =  UIColor.xj_colorFromRGB(rgbValue: 0xaaaaaa)
        scrBackView.addSubview(lineView3)

        registBtn = UIButton.getBtn_titleStyle(title_normal: "注册", title_selected: "注册", fream: CGRect(x: backViewX, y: scrBackView.frame.maxY + ip6(20), width: backViewWidth, height: ip6(35)), backgroundColor: UIColor.xj_colorFromRGB(rgbValue: 0x6C9CE2), textColorSelectrd: .white, textColor: .white, fontSize: 15, textAlignment: .center, selector: #selector(registClick), vc: self, tag: 1)
        registBtn.xj_makeRadius(radius: 4)

        let str = "点击“注册”即表示您同意并愿意遵守学记".getAttributedStr_color(color: UIColor.xj_colorFromRGB(rgbValue: 0x9a9a9a), fontSzie: 10)
        let str2 = "\n用户协议".getAttributedStr_color(color: UIColor.xj_colorFromRGB(rgbValue: 0x6C9CE2), fontSzie: 10)
        let str3 = "和".getAttributedStr_color(color: UIColor.xj_colorFromRGB(rgbValue: 0x9a9a9a), fontSzie: 10)
        let str4 = "隐私政策".getAttributedStr_color(color: UIColor.xj_colorFromRGB(rgbValue: 0x6C9CE2), fontSzie: 10)
        str.append(str2)
        str.append(str3)
        str.append(str4)

        noticeLabel = UILabel.getLabel_AttributedTitle(fream: CGRect(x: backViewX, y: registBtn.frame.maxY + ip6(13), width: KSCREEN_WIDTH - backViewX * 2, height: ip6(35)), fontSize: 14, text: str, textColor: UIColor.xj_colorFromRGB(rgbValue: 0x9a9a9a), textAlignment: .center)
        noticeLabel.numberOfLines = 0

        self.addSubview(titleLabel)
        self.addSubview(titleLabel_sub)
        self.addSubview(phoneBackView)
        self.addSubview(codeBackView)
        self.addSubview(scrBackView)
        self.addSubview(registBtn)
        self.addSubview(noticeLabel)
    }

    func registClick() {
        XJLog(message: "注册")
    }
}
