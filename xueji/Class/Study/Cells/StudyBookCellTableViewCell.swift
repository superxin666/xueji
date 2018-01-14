//
//  StudyBookCellTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2017/10/31.
//  Copyright © 2017年 lvxin. All rights reserved.
//  studyVC tableViewcell

import UIKit

class StudyBookCellTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpUI() {
        //
        for i in 0..<5 {
            let imageH = ip6(100)
            let imageW = ip6(65)
//            let x = ip6(21)
            let appading = (KSCREEN_WIDTH - ip6(42) - imageW * 4)/3
            let Y = CGFloat((i/4)) * (imageH + ip6(16))
            let X = ip6(21) + ((appading + imageW) * CGFloat(i%4))
            let imageView = UIImageView()
            imageView.frame = CGRect(x: X, y: Y, width: imageW, height: imageH)
            imageView.setImage_kf(imageName: "", placeholderImage: #imageLiteral(resourceName: "book"))
            self.addSubview(imageView)
        }
        
    }

}
