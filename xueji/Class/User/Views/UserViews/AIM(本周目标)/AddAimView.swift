//
//  AddAimView.swift
//  xueji
//
//  Created by lvxin on 2018/5/18.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class AddAimView: UIView,UITextFieldDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var titleLabel : UILabel!

    var timeBackView : UIView!
    var timeLabel : UILabel!
    var timeLabel2 : UILabel!
    var timeField : UITextField!

    var amountBackView : UIView!
    var amountLabel : UILabel!
    var amountLabel2 : UILabel!
    var amountField : UITextField!



    override init(frame: CGRect) {
        super.init(frame: frame)
        self.creatUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func creatUI() {

        let tittlStr = String.getWeek()

        titleLabel = UILabel.getLabel(fream: CGRect(x: ip6(10), y: ip6(60), width: KSCREEN_WIDTH - ip6(20), height: ip6(20)), fontSize: 17, text: tittlStr, textColor: black_53, textAlignment: .center)
        self.addSubview(titleLabel)

        timeBackView = UIView(frame: CGRect(x: ip6(20), y: titleLabel.frame.maxY + ip6(10), width: KSCREEN_WIDTH - ip6(40), height: ip6(50)))
        timeLabel = UILabel.getLabel(fream: CGRect(x: 0, y: ip6(22), width: ip6(80), height: ip6(25)), fontSize: 18, text: "学习时间", textColor: black_53, textAlignment: .center)

        timeField = UITextField(frame: CGRect(x: timeLabel.frame.maxX + ip6(10), y: ip6(22), width: KSCREEN_WIDTH - ip6(40) - timeLabel.frame.maxX - ip6(100), height:  ip6(25)))
        timeField.delegate = self
        timeField.font = xj_fzFontMedium(18)
        timeField.textColor = black_e3e0e0
        timeField.placeholder = "必填"
        timeField.tag = 10
        timeField.keyboardType = .numberPad

        timeLabel2 = UILabel.getLabel(fream: CGRect(x: timeField.frame.maxX, y: ip6(22), width: ip6(100), height: ip6(25)), fontSize: 18, text: "小时（h）", textColor: black_53, textAlignment: .center)

        let lineView = UIView(frame: CGRect(x: ip6(23), y: ip6(49), width:  timeField.frame.maxX - ip6(23), height: 0.5))
        lineView.backgroundColor = black_e3e3e3

        amountBackView = UIView(frame: CGRect(x:  ip6(20), y: timeBackView.frame.maxY, width: KSCREEN_WIDTH - ip6(40), height: ip6(50)))
        amountLabel = UILabel.getLabel(fream: CGRect(x: 0, y: ip6(22), width: ip6(80), height: ip6(25)), fontSize: 18, text: "学习量", textColor: black_53, textAlignment: .center)

        amountField = UITextField(frame: CGRect(x: timeLabel.frame.maxX + ip6(10), y: ip6(22), width: KSCREEN_WIDTH - ip6(40) - timeLabel.frame.maxX - ip6(100), height:  ip6(25)))
        amountField.delegate = self
        amountField.font = xj_fzFontMedium(18)
        amountField.textColor = black_e3e0e0
        amountField.placeholder = "非必填"
        amountField.tag = 100


        amountLabel2 = UILabel.getLabel(fream: CGRect(x: amountField.frame.maxX, y: ip6(22), width: ip6(80), height: ip6(25)), fontSize: 18, text: "页（p）", textColor: black_53, textAlignment: .center)

        let lineView2 = UIView(frame: CGRect(x: ip6(23), y: ip6(49), width: amountField.frame.maxX - ip6(23), height: 0.5))
        lineView2.backgroundColor = black_e3e3e3


        self.addSubview(titleLabel)
        timeBackView.addSubview(timeLabel)
        timeBackView.addSubview(timeLabel2)
        timeBackView.addSubview(timeField)
        timeBackView.addSubview(lineView)
        self.addSubview(timeBackView)

        amountBackView.addSubview(amountLabel)
        amountBackView.addSubview(amountField)
        amountBackView.addSubview(amountLabel2)
        amountBackView.addSubview(lineView2)
        self.addSubview(amountBackView)

    }

    func textFieldDidEndEditing(_ textField: UITextField) {

        if textField.tag == 10 {
            XJLog(message: "时间" + textField.text!)
        } else {
            XJLog(message: "学习量" + textField.text!)
        }
    }

}
