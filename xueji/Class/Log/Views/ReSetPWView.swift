//
//  ReSetPWView.swift
//  xueji
//
//  Created by lvxin on 2018/1/7.
//  Copyright © 2018年 lvxin. All rights reserved.
//  重置密码

import UIKit

class ReSetPWView: UIView,UITextFieldDelegate,SmsCodeApiMangerDelegate,ResetPasswordApiMangerDelegate {
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

  

    var codeRequest = SmsCodeApiManger()
    var registRequest = ResetPasswordApiManger()


    var codeSt = ""
    var phoneStr = ""
    var keyStr = ""

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        self.loadViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func loadViews() {
        let backViewX = ip6(35)
        let backViewWidth = KSCREEN_WIDTH - backViewX * 2
        let backViewHeight = ip6(25)
        //手机号码
        phoneBackView = UIView(frame: CGRect(x: backViewX, y: ip6(70), width: backViewWidth, height: backViewHeight))

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
        phoneTextFiled.delegate = self
        phoneBackView.addSubview(phoneTextFiled)

        let lineView = UIView()
        let lineViewY = phoneBackView.frame.size.height - 0.5
        lineView.frame = CGRect(x: 0, y: lineViewY, width: backViewWidth, height: 0.5)
        lineView.backgroundColor =  UIColor.xj_colorFromRGB(rgbValue: 0xaaaaaa)
        phoneBackView.addSubview(lineView)

        //验证码
        codeBackView = UIView(frame: CGRect(x: backViewX, y: phoneBackView.frame.maxY + ip6(20), width: backViewWidth, height: backViewHeight))

        let codeNameLabel = UILabel.getLabel(fream: CGRect(x: 0, y: 0, width: ip6(45), height: ip6(21)), fontSize: 15, text: "验证码", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x9a9a9a), textAlignment: .left)
        codeBackView.addSubview(codeNameLabel)


        codeWorldTextFiled = UITextField()
        codeWorldTextFiled.frame = CGRect(x: codeNameLabel.frame.maxX + ip6(20), y: 0, width: backViewWidth - ip6(80), height: ip6(15))
        codeWorldTextFiled.font = xj_fzFontMedium(ip6(15))
        codeWorldTextFiled.textColor = UIColor.xj_colorFromRGB(rgbValue: 0x070707)
        codeWorldTextFiled.adjustsFontSizeToFitWidth = true
        codeWorldTextFiled.textAlignment = .left
        codeWorldTextFiled.keyboardType = .numberPad
        codeWorldTextFiled.returnKeyType = .next
        codeWorldTextFiled.tag = 101
        codeWorldTextFiled.delegate = self
        codeBackView.addSubview(codeWorldTextFiled)

        //获取验证码
        getCodeLabel = UILabel.getLabel(fream: CGRect(x: backViewWidth - ip6(50), y: 0, width: ip6(50), height: ip6(22)), fontSize: 10, text: "获取验证码", textColor: .white, textAlignment: .center)
        getCodeLabel.backgroundColor = UIColor.xj_colorFromRGB(rgbValue: 0x6C9CE2)
        getCodeLabel.xj_makeRadius(radius: 4)
        codeBackView.addSubview(getCodeLabel)

        getCodeLabel.isUserInteractionEnabled = true
        let ges : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(getCode))
        getCodeLabel.addGestureRecognizer(ges)

        let lineView2 = UIView()
        let lineViewY2 = codeBackView.frame.size.height - 0.5
        lineView2.frame = CGRect(x: 0, y: lineViewY2, width: backViewWidth, height: 0.5)
        lineView2.backgroundColor =  UIColor.xj_colorFromRGB(rgbValue: 0xaaaaaa)
        codeBackView.addSubview(lineView2)


        //账号密码
        scrBackView = UIView(frame: CGRect(x: backViewX, y: codeBackView.frame.maxY + ip6(20), width: backViewWidth, height: backViewHeight))

        let scrNameLabel = UILabel.getLabel(fream: CGRect(x: 0, y: 0, width: ip6(30), height: ip6(21)), fontSize: 15, text: "密码", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x9a9a9a), textAlignment: .left)
        scrBackView.addSubview(scrNameLabel)


        passWorldTextFiled = UITextField()
        passWorldTextFiled.frame = CGRect(x: scrNameLabel.frame.maxX + ip6(20), y: ip6(3), width: backViewWidth - ip6(60) - ip6(40), height: ip6(15))
        passWorldTextFiled.adjustsFontSizeToFitWidth = true
        passWorldTextFiled.textAlignment = .left
        passWorldTextFiled.delegate = self
        passWorldTextFiled.returnKeyType = .done
        passWorldTextFiled.isSecureTextEntry = true
        passWorldTextFiled.tag = 102
        passWorldTextFiled.font =  xj_fzFontMedium(ip6(15))
        passWorldTextFiled.adjustsFontSizeToFitWidth = true
        passWorldTextFiled.textColor = UIColor.xj_colorFromRGB(rgbValue: 0x070707)
        scrBackView.addSubview(passWorldTextFiled)


        let lineView3 = UIView()
        let lineViewY3 = scrBackView.frame.size.height - 0.5
        lineView3.frame = CGRect(x: 0, y: lineViewY3, width: backViewWidth, height: 0.5)
        lineView3.backgroundColor =  UIColor.xj_colorFromRGB(rgbValue: 0xaaaaaa)
        scrBackView.addSubview(lineView3)

        registBtn = UIButton.getBtn_titleStyle(title_normal: "完成", title_selected: "完成", fream: CGRect(x: backViewX, y: scrBackView.frame.maxY + ip6(20), width: backViewWidth, height: ip6(35)), backgroundColor: UIColor.xj_colorFromRGB(rgbValue: 0x6C9CE2), textColorSelectrd: .white, textColor: .white, fontSize: 15, textAlignment: .center, selector: #selector(doneClick), vc: self, tag: 1)
        registBtn.xj_makeRadius(radius: 4)


        self.addSubview(phoneBackView)
        self.addSubview(codeBackView)
        self.addSubview(scrBackView)
        self.addSubview(registBtn)

    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 100 {
            //手机号
            if let str = textField.text {
                phoneStr = str
            }

        } else if textField.tag == 101  {
            //验证码
            if let str = textField.text {
                codeSt = str
            }

        } else {
            //密码
            if let str = textField.text {
                keyStr = str
            }
        }


    }

    func getCode() {
        if self.phoneTextFiled.isFirstResponder {
            self.phoneTextFiled.resignFirstResponder()
        }
        if let str = phoneTextFiled.text {
            if  !(String.xj_isMobileNumber(phoneNum: str)) {
                SVPMessageShow.showErro(infoStr: "请输入正确的手机号~")
                return
            }
            codeRequest.delegate = self
            codeRequest.getCode(phone: str)

            time = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(timeCount), userInfo: nil, repeats: true)
            getCodeLabel.isUserInteractionEnabled = false


        } else {
            SVPMessageShow.showErro(infoStr: "输入手机号")
        }
    }

    func doneClick() {
        XJLog(message: "完成")
        XJLog(message: "注册")
        if phoneTextFiled.isFirstResponder {
            phoneTextFiled.resignFirstResponder()
        }
        if codeWorldTextFiled.isFirstResponder {
            codeWorldTextFiled.resignFirstResponder()
        }
        if passWorldTextFiled.isFirstResponder {
            passWorldTextFiled.resignFirstResponder()
        }

        if !(String.xj_isMobileNumber(phoneNum: phoneStr)) {
            SVPMessageShow.showErro(infoStr: "请输入正确的手机号")
            return
        }
        if !(codeSt.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入验证码")
            return
        }
        if !(keyStr.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输新密码入密码")
            return
        }
        registRequest.delegate = self
        registRequest.resetRequest(phone: phoneStr, sms_code: codeSt, key: keyStr)
    

    }

    func requestSucceed_reset() {
        let dele :AppDelegate = UIApplication.shared.delegate as! AppDelegate
        SVPMessageShow.showSucess(infoStr: "修改成功")
        dele.showLogin()
    }

    func requestFail_reset() {
        getCodeLabel.isUserInteractionEnabled = true
        SVPMessageShow.showErro(infoStr: "发送失败")
        timeNum = 60
        getCodeLabel.text = "重新获取"

    }


    func requestSucceed_code() {
        SVPMessageShow.showSucess(infoStr: "已发送")

    }

    func requestFail_code() {
        getCodeLabel.isUserInteractionEnabled = true
        SVPMessageShow.showErro(infoStr: "发送失败")
        timeNum = 60
        getCodeLabel.text = "重新获取"

    }

    func timeCount() {
        timeNum = timeNum - 1
        if timeNum == 0 {
            timeNum = 60
            time.invalidate()
            getCodeLabel.isUserInteractionEnabled = true
            getCodeLabel.text = "重新发送"
        } else {
            getCodeLabel.text = "\(timeNum)"
        }
    }

}
