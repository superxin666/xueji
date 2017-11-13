//
//  ReviewViewController.swift
//  学记
//
//  Created by lvxin on 2017/8/29.
//  Copyright © 2017年 lvxin. All rights reserved.
//

import UIKit

class ReviewViewController: BaseViewController {
    
    /// 头部视图
    var headBackView : UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigation_title_fontsize(name: "复习", fontsize: 20)
        self.navigationBar_rightBtn_image(image: #imageLiteral(resourceName: "review_more"))
        self.creatHeadView()
        
    }
    // MARK: -头部视图
    func creatHeadView() {
        headBackView = UIView(frame: CGRect(x: 0, y: LNAVIGATION_HEIGHT, width: KSCREEN_WIDTH, height: ip6(46)))
        self.view.addSubview(headBackView)
        
        let topLine : UIView = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: ip6(2)))
        topLine.backgroundColor = black_22
        headBackView.addSubview(topLine)
        
        let bottomLine : UIView = UIView(frame: CGRect(x: 0, y: ip6(42), width: KSCREEN_WIDTH, height: ip6(2)))
        bottomLine.backgroundColor = black_22
        headBackView.addSubview(bottomLine)
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
