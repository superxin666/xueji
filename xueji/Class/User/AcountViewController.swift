//
//  AcountViewController.swift
//  xueji
//
//  Created by lvxin on 2018/7/18.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class AcountViewController: BaseViewController {
    var nameLabel : UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigation_title_fontsize(name: "账号与安全", fontsize: 20)
        self.navigationBar_leftBtn_title(title: "返回")
        self.creatUI()
    }
    func creatUI() {

        let nameBackView = UIView(frame: CGRect(x: ip6(25), y: LNAVIGATION_HEIGHT +  ip6(80), width: KSCREEN_WIDTH - ip6(50), height: ip6(28)))
        nameBackView.isUserInteractionEnabled = true
        self.view.addSubview(nameBackView)

        let lineView1 = UIView(frame: CGRect(x: 0, y: ip6(27), width: nameBackView.frame.size.width, height: 0.5))
        lineView1.backgroundColor = black_ebebee
        nameBackView.addSubview(lineView1)


        nameLabel  = UILabel.getLabel(fream: CGRect(x: 0, y: 0, width: ip6(100), height: ip6(20)), fontSize: ip6(18), text: "修改密码", textColor: black_53, textAlignment: .left)
        nameBackView.addSubview(nameLabel)


        let tap = UITapGestureRecognizer(target: self, action: #selector(resitePass))
        nameBackView.addGestureRecognizer(tap)
    }


    func resitePass() {
        let vc = ReSetPassWordViewController()
        vc.hidesBottomBarWhenPushed  = true
        self.navigationController?.pushViewController(vc, animated: true)

    }



    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
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
