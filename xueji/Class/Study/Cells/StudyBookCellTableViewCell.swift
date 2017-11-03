//
//  StudyBookCellTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2017/10/31.
//  Copyright © 2017年 lvxin. All rights reserved.
//  studyVC tableViewcell

import UIKit

class StudyBookCellTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
            imageView.kf.setImage(with:  URL(string: ""), placeholder: #imageLiteral(resourceName: "book"), options: [.transition(.fade((1)))], progressBlock: nil, completionHandler: nil)
            self.addSubview(imageView)
        }
        
    }

}
