


//
//  StaudySetViewController.swift
//  xueji
//
//  Created by lvxin on 2018/7/18.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class StaudySetViewController: BaseViewController {

    var nameLabel : UILabel!

    var  switchBtn : UISwitch!

    var showNum : String!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigation_title_fontsize(name: "账号与安全", fontsize: 20)
        self.navigationBar_leftBtn_title(title: "返回")
        self.navigationBar_rightBtn_title(title: "保存")
        self.creatUI()

    }


    func creatUI() {
        let nameBackView = UIView(frame: CGRect(x: ip6(25), y: LNAVIGATION_HEIGHT +  ip6(80), width: KSCREEN_WIDTH - ip6(50), height: ip6(28)))
        nameBackView.isUserInteractionEnabled = true
        self.view.addSubview(nameBackView)

        let lineView1 = UIView(frame: CGRect(x: 0, y: ip6(27), width: nameBackView.frame.size.width, height: 0.5))
        lineView1.backgroundColor = black_ebebee
        nameBackView.addSubview(lineView1)


        nameLabel  = UILabel.getLabel(fream: CGRect(x: 0, y: 0, width: ip6(120), height: ip6(20)), fontSize: ip6(18), text: "显示最近学习", textColor: black_53, textAlignment: .left)
        nameBackView.addSubview(nameLabel)

        switchBtn = UISwitch(frame: CGRect(x: KSCREEN_WIDTH - ip6(50) - ip6(60), y: 0, width: ip6(50), height: ip6(30)))
        switchBtn.isUserInteractionEnabled = true
        switchBtn.addTarget(self, action: #selector(switchClick(sendr:)), for: .valueChanged)
        if UserDataManger.getIsShowRecentStudy() == "1" {
            switchBtn.isOn = true
        } else {
            switchBtn.isOn = false
        }
        showNum = UserDataManger.getIsShowRecentStudy()
        nameBackView.addSubview(switchBtn)

    }

    func switchClick(sendr : UISwitch) {
//        sendr.isOn = !sendr.isOn
        showNum = "\(sendr.isOn.hashValue)"
        XJLog(message: showNum!)
    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }

    override func navigationRightBtnClick() {
        XJLog(message: "保存")
        UserDataManger.setShowRecentStudy(value: showNum!) { (data) in
            let str : String = data as! String
            if str == "1" {
                NotificationCenter.default.post(name: Notification.Name(rawValue: FLISHDATA), object: nil)
                self.navigationLeftBtnClick()
            } else {

            }
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
