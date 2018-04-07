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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.navigation_title_fontsize(name: "计时", fontsize: 20)
        self.navigationBar_leftBtn_title(title: "取消")
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
