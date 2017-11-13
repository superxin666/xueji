//
//  ReviewTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2017/11/13.
//  Copyright © 2017年 lvxin. All rights reserved.
//  复习 cell

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    /// 书 图片
    var bookImageView : UIImageView!
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        self.backgroundColor  = .white
        bookImageView = UIImageView()
        bookImageView.frame = CGRect(x: ip6(12), y: ip6(5), width: ip6(67), height: ip6(100))
        bookImageView.setImage_kf(imageName: "", placeholderImage: #imageLiteral(resourceName: "book"))
        self.contentView.addSubview(bookImageView)
        
        let lineView = UIView(frame: CGRect(x: ip6(12), y: ip6(110), width: KSCREEN_WIDTH - ip6(24), height: ip6(1)))
        lineView.backgroundColor = black_e3e3e3
        self.contentView.addSubview(lineView)
    }

}
