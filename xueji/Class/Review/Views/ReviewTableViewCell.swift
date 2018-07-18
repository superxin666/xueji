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

    ///
    var titleLabel : UILabel!

    var subTitleLabel : UILabel!

    var noteTitleLabel : UILabel!

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
        
        
        titleLabel  = UILabel.getLabel(fream: CGRect(x: bookImageView.frame.maxX + ip6(5), y: ip6(5), width: KSCREEN_WIDTH - bookImageView.frame.maxX - ip6(10), height: ip6(12)), fontSize: 12, text: "", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x535353), textAlignment: .left)

        subTitleLabel  = UILabel.getLabel(fream: CGRect(x: bookImageView.frame.maxX + ip6(5), y: titleLabel.frame.maxY + ip6(5), width: KSCREEN_WIDTH - bookImageView.frame.maxX - ip6(20), height: ip6(25)), fontSize: 10, text: "", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x535353), textAlignment: .left)
        subTitleLabel.numberOfLines = 0

        noteTitleLabel  = UILabel.getLabel(fream: CGRect(x: bookImageView.frame.maxX + ip6(5) , y: subTitleLabel.frame.maxY , width: KSCREEN_WIDTH - bookImageView.frame.maxX - ip6(20), height: ip6(25)), fontSize: 10, text: "", textColor: UIColor.xj_colorFromRGB(rgbValue: 0x8E8E93), textAlignment: .left)
        noteTitleLabel.numberOfLines = 0

        let lineView = UIView(frame: CGRect(x: ip6(12), y: ip6(110), width: KSCREEN_WIDTH - ip6(24), height: ip6(1)))
        lineView.backgroundColor = black_e3e3e3


        self.contentView.addSubview(bookImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(subTitleLabel)
        self.contentView.addSubview(noteTitleLabel)
        self.contentView.addSubview(lineView)
    }
    
    func setData(model : ReviewModel_content) {
        bookImageView.setImage_kf(imageName: model.bookcover_img, placeholderImage: #imageLiteral(resourceName: "bookLoading"))
        if let reviewstep = model.reviewstep,let reviewtime = model.reviewtime {
            titleLabel.text = "记忆阶段 \(reviewstep)  复习时间\(reviewtime)"
        }
        if let learnbeg_page = model.learnbeg_page,let learnend_page = model.learnend_page {
            subTitleLabel.text = model.booktitle + "（\(learnbeg_page)-\(learnend_page)）"
        }

        if let learnbeg_page = model.learnbeg_page,let learnend_page = model.learnend_page {
            subTitleLabel.text = model.booktitle + "（\(learnbeg_page)-\(learnend_page)）"
        }
        if let learnreminder = model.learnreminder {
            noteTitleLabel.text = learnreminder
        }
    }

}
