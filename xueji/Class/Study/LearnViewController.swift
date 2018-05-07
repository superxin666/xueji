//
//  LearnViewController.swift
//  xueji
//
//  Created by lvxin on 2018/4/7.
//  Copyright © 2018年 lvxin. All rights reserved.
//  学习页面

import UIKit

class LearnViewController: BaseViewController {

    var model  : CategoryListModel_list_book_list!


    /// 图书
    var bookImageView : UIImageView!

    /// 时间
    var timeLabel : UILabel!

    /// 时间重置
    var restTimeBtn : UIButton!

    /// 完成
    var doneBtn : UIButton!

    /// 开始按钮
    var statBtn : UIButton!




    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.navigation_title_fontsize(name: "计时", fontsize: 20)
        self.navigationBar_leftBtn_title(title: "取消")
        self.creatUI()
    }

    func creatUI()  {
        bookImageView = UIImageView(frame: CGRect(x: (KSCREEN_WIDTH - ip6(130))/2, y:LNAVIGATION_HEIGHT + ip6(40), width: ip6(130), height: ip6(200)))
        bookImageView.setImage_kf(imageName: model.cover_img, placeholderImage: #imageLiteral(resourceName: "book"))
        self.view.addSubview(bookImageView)

        timeLabel = UILabel.getLabel(fream: CGRect(x: ip6(20), y: bookImageView.frame.maxY + ip6(45), width: KSCREEN_WIDTH - ip6(40), height: ip6(90)), fontSize: 64, text: "00:00", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x535353), textAlignment: .center)
        self.view.addSubview(timeLabel)

        statBtn = UIButton.getBtn_picStyle(image_normal: #imageLiteral(resourceName: "play"), image_selected: #imageLiteral(resourceName: "pause"), fream: CGRect(x: (KSCREEN_WIDTH - CGFloat(75))/2, y: timeLabel.frame.maxY + ip6(50), width: CGFloat(75), height:  CGFloat(75)), selector: #selector(statClick(sender:)), vc: self, tag: 0)

        restTimeBtn = UIButton.getBtn_titleStyle(title_normal: "重置", title_selected: "重置", fream: CGRect(x: statBtn.frame.origin.x - ip6(65), y: statBtn.frame.midY - ip6(10), width: ip6(40), height: ip6(20)), backgroundColor: UIColor.clear, textColor: UIColor.xj_colorFromRGB(rgbValue: 0x535353), fontSize: 19, textAlignment: .center, selector: #selector(restClick), vc: self, tag: 0)

        doneBtn = UIButton.getBtn_titleStyle(title_normal: "完成", title_selected: "完成", fream: CGRect(x: statBtn.frame.maxX + ip6(25), y: restTimeBtn.frame.origin.y, width: ip6(40), height: ip6(20)), backgroundColor: UIColor.clear, textColor: UIColor.xj_colorFromRGB(rgbValue: 0x535353), fontSize: 19, textAlignment: .center, selector: #selector(doneClick), vc: self, tag: 0)
        self.view.addSubview(statBtn)
        self.view.addSubview(restTimeBtn)
        self.view.addSubview(doneBtn)

    }


    /// 开始播放
    func statClick(sender:UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            XJLog(message: "开始")
        } else {
            XJLog(message: "暂定")
        }
    }

    func restClick()  {

    }
    func doneClick() {
        let vc = LearnDetailViewController()
        vc.model = model

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
