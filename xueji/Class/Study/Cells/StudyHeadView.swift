//
//  StudyHeadView.swift
//  xueji
//
//  Created by lvxin on 2018/1/22.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let StudyHeadViewH = ip6(42)

class StudyHeadView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    /// 名称
    var nameLabel : UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadView() {
        nameLabel = UILabel.getLabel(fream:CGRect(x: ip6(16), y: ip6(12), width: KSCREEN_WIDTH - ip6(32), height: ip6(20)), fontSize: 15, text: "分类", textColor: black_53, textAlignment: .left)
        self.addSubview(nameLabel)
    }
    func setUpData(nameStr : String) {
        nameLabel.text = nameStr
    }

}
