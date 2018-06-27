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


    var time : Timer!

    var timeNum : Int = 0

    var timeTuple : (timeStr : String,timeStr2 : String)!

    deinit {
        NotificationCenter.default.removeObserver(self)
        time.invalidate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.navigation_title_fontsize(name: "计时", fontsize: 20)
        self.navigationBar_leftBtn_title(title: "取消")
        self.creatUI()
        NotificationCenter.default.addObserver(self, selector: #selector(backbview), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)

//        self.addCycleTimer()
    }
    func backbview()  {
        XJLog(message: "进入后台")
        if statBtn.isSelected  {
//            statBtn.isSelected = false
//            time.fireDate = Date.distantFuture
        }
    }

//    func addCycleTimer() {
//        time = Timer(timeInterval: 1.0, target: self, selector: #selector(self.handleTimer), userInfo: nil, repeats: true)
//        RunLoop.main.add(time!, forMode:RunLoopMode.commonModes)
//    }
//
//    func handleTimer (){
//
//        let currentDate = Date(timeIntervalSinceNow: 1)
//
//        //        let currentDate = Date()
//
//        let dateFormatter = DateFormatter()
//
//        dateFormatter.dateFormat = "HH:mm:ss"
//
//        timeLabel.text = dateFormatter.string(from: currentDate)
//    }

    func creatUI()  {
        bookImageView = UIImageView(frame: CGRect(x: (KSCREEN_WIDTH - ip6(130))/2, y:LNAVIGATION_HEIGHT + ip6(40), width: ip6(130), height: ip6(200)))
        bookImageView.setImage_kf(imageName: model.cover_img, placeholderImage: #imageLiteral(resourceName: "book"))
        self.view.addSubview(bookImageView)

        timeLabel = UILabel.getLabel(fream: CGRect(x: ip6(20), y: bookImageView.frame.maxY + ip6(45), width: KSCREEN_WIDTH - ip6(40), height: ip6(90)), fontSize: 64, text: "00:00:00", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x535353), textAlignment: .center)
        self.view.addSubview(timeLabel)

        //60*60*50
        //6*60
        //45


        statBtn = UIButton.getBtn_picStyle(image_normal: #imageLiteral(resourceName: "play"), image_selected: #imageLiteral(resourceName: "pause"), fream: CGRect(x: (KSCREEN_WIDTH - CGFloat(75))/2, y: timeLabel.frame.maxY + ip6(50), width: CGFloat(75), height:  CGFloat(75)), selector: #selector(statClick(sender:)), vc: self, tag: 0)

        restTimeBtn = UIButton.getBtn_titleStyle(title_normal: "重置", title_selected: "重置", fream: CGRect(x: statBtn.frame.origin.x - ip6(65), y: statBtn.frame.midY - ip6(10), width: ip6(40), height: ip6(20)), backgroundColor: UIColor.clear, textColorSelectrd: UIColor.xj_colorFromRGB(rgbValue: 0x535353), textColor: UIColor.xj_colorFromRGB(rgbValue: 0x535353), fontSize: 19, textAlignment: .center, selector: #selector(restClick), vc: self, tag: 0)

        doneBtn = UIButton.getBtn_titleStyle(title_normal: "完成", title_selected: "完成", fream: CGRect(x: statBtn.frame.maxX + ip6(25), y: restTimeBtn.frame.origin.y, width: ip6(40), height: ip6(20)), backgroundColor: UIColor.clear, textColorSelectrd: UIColor.xj_colorFromRGB(rgbValue: 0x535353), textColor: UIColor.xj_colorFromRGB(rgbValue: 0x535353), fontSize: 19, textAlignment: .center, selector: #selector(doneClick), vc: self, tag: 0)
        self.view.addSubview(statBtn)
        self.view.addSubview(restTimeBtn)
        self.view.addSubview(doneBtn)

    }


    /// 开始播放
    func statClick(sender:UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            XJLog(message: "开始")
            time = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(timeStart), userInfo: nil, repeats: true)
        } else {
            XJLog(message: "暂定")
            time.fireDate = Date.distantFuture
        }
    }

    /// 开始计时
    func timeStart() {
        timeNum = timeNum + 1
        timeTuple = String.getCountTime(sencond: timeNum)
        timeLabel.text = timeTuple.timeStr
    }


    /// 结束
    func stopTimeimg() {
        time.fireDate = Date.distantFuture
        time.invalidate()
    }

    func restClick()  {
        //

    }


    func doneClick() {

        if timeNum < 60 {
            SVPMessageShow.showErro(infoStr: "记录最短时间为60s")
            return
        } else {

            self.stopTimeimg()
            let vc = LearnDetailViewController()
            vc.model = model
            vc.timeNum = timeNum
            vc.timeStr = timeTuple.timeStr2
            vc.noticeTimeStrTuple = String.xj_getDate_now()
            self.navigationController?.pushViewController(vc, animated: true)
        }

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
