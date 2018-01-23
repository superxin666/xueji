//
//  StudyBookCellTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2017/10/31.
//  Copyright © 2017年 lvxin. All rights reserved.
//  studyVC tableViewcell

import UIKit

class StudyBookCellTableViewCell: UITableViewCell {
    var bookImageView : UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.creatUI()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func creatUI() {
        
        
    }

    func setUpUI(model : CategoryListModel_list) {
        //
        for i in 0..<model.book_list.count {
            let subModel = model.book_list[i]
            let imageH = ip6(100)
            let imageW = ip6(65)
//            let x = ip6(21)
            let appading = (KSCREEN_WIDTH - ip6(42) - imageW * 4)/3
            let Y = CGFloat((i/4)) * (imageH + ip6(16))
            let X = ip6(21) + ((appading + imageW) * CGFloat(i%4))
            bookImageView = UIImageView()
            bookImageView.frame = CGRect(x: X, y: Y, width: imageW, height: imageH)
            bookImageView.setImage_kf(imageName: subModel.cover_img, placeholderImage: #imageLiteral(resourceName: "book"))
            self.contentView.addSubview(bookImageView)
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
