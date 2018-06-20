//
//  AddBookTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2017/11/14.
//  Copyright © 2017年 lvxin. All rights reserved.
//  添加资料 cell

import UIKit
let AddBookCellID = "AddBookCell_id"
let AddBook_CatCellID = "AddBook_CatCellID"
class AddBookTableViewCell: UITableViewCell,UITextFieldDelegate {
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
        
        titleLabel = UILabel.getLabel(fream: CGRect(x: ip6(39), y: ip6(16), width: ip6(60), height: ip6(25)), fontSize: 18, text: "", textColor: black_53, textAlignment: .left)
        self.contentView.addSubview(titleLabel)
        
        textTextField = UITextField(frame: CGRect(x: titleLabel.frame.maxX + ip6(30), y: ip6(17), width: KSCREEN_WIDTH - ip6(36) - titleLabel.frame.maxX  - ip6 (30), height: ip6(25)))
        textTextField.placeholder = "必填"
        textTextField.font = xj_fzFontMedium(ip6(18))
        textTextField.textColor = black_53
        textTextField.delegate = self
        self.contentView.addSubview(textTextField)
        
        let lineView : UIView = UIView(frame: CGRect(x: ip6(39), y: addBookCellHeight - 1, width: KSCREEN_WIDTH - ip6(78), height: 1))
        lineView.backgroundColor = black_e3e0e0
        self.contentView.addSubview(lineView)
    }
    
    func setData(rowNum : Int)  {
        titleLabel.text = titleNameArr[rowNum]
    }

    func setData_custom(model : BookModel,rowNum : Int) {

    }

    func setData_scan(model : BookModel,rowNum : Int) {
        titleLabel.text = titleNameArr[rowNum]
        self.textTextField.tag = rowNum

        self.isUserInteractionEnabled = false
        switch rowNum {
        case 0:
            //
            if let title = model.title {
                self.textTextField.text = title
            }
        case 1:
            //
            if let author_first = model.author_first {
                self.textTextField.text = author_first
            }
        case 2:
            //
            if let pages = model.pages {
                self.textTextField.text = "\(pages)"
            }
        case 3:
            //
            if let publisher = model.publisher {
                self.textTextField.text = publisher
            }
        default:
            XJLog(message: "暂无")
        }
    }

}
