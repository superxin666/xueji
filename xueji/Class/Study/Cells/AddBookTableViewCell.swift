//
//  AddBookTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2017/11/14.
//  Copyright © 2017年 lvxin. All rights reserved.
//  添加资料 cell

import UIKit

class AddBookTableViewCell: UITableViewCell {
    var titleLabel : UILabel!
    var textTextField : UITextField!
    var textStr : String!
    
    let titleNameArr : [String] = ["标 题","作 者","页 数","出版社"]
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.creatUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatUI()  {
        titleLabel = UILabel(frame: CGRect(x: ip6(39), y: ip6(16), width: ip6(60), height: ip6(25)))
        titleLabel.font = xj_fzFontMedium(ip6(18))
        titleLabel.textColor = black_53
        titleLabel.textAlignment = .left
        self.contentView.addSubview(titleLabel)
        
        textTextField = UITextField(frame: CGRect(x: titleLabel.frame.maxX + ip6(30), y: ip6(17), width: KSCREEN_WIDTH - ip6(36) - titleLabel.frame.maxX  - ip6 (30), height: ip6(25)))
        textTextField.placeholder = "必填"
        textTextField.font = xj_fzFontMedium(ip6(18))
        textTextField.textColor = black_53
        self.contentView.addSubview(textTextField)
        
        let lineView : UIView = UIView(frame: CGRect(x: ip6(39), y: addBookCellHeight - 1, width: KSCREEN_WIDTH - ip6(78), height: 1))
        lineView.backgroundColor = black_e3e0e0
        self.contentView.addSubview(lineView)
    }
    
    func setData(rowNum : Int)  {
        titleLabel.text = titleNameArr[rowNum]
    }

}
