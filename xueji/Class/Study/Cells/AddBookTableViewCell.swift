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

protocol AddBookTableViewCellDelegate : NSObjectProtocol {
    func endInput(contentStr : String,tagNum : Int)
}


class AddBookTableViewCell: UITableViewCell,UITextFieldDelegate {
    weak var delegate: AddBookTableViewCellDelegate!
    var titleLabel : UILabel!
    var textTextField : UITextField!
    var textStr : String!
    let titleNameArr : [String] = ["标 题","作 者","页 数","出版社"]

//    /// 标题名字
//    var titleStr = ""
//
//    /// 作者名字
//    var publisher = ""
//
//    /// 页数
//    var pages = ""
//
//    /// 出版社
//    var publish = ""


    
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
        textTextField.font = xj_fzFontMedium(ip6(18))
        textTextField.textColor = black_53
        textTextField.delegate = self
        self.contentView.addSubview(textTextField)
        
        let lineView : UIView = UIView(frame: CGRect(x: ip6(39), y: addBookCellHeight - 1, width: KSCREEN_WIDTH - ip6(78), height: 1))
        lineView.backgroundColor = black_e3e0e0
        self.contentView.addSubview(lineView)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (delegate != nil) {
            if let ste = textField.text {
                self.delegate.endInput(contentStr: textField.text!, tagNum: textField.tag)
            } else {
                self.delegate.endInput(contentStr: "", tagNum: textField.tag)
            }

        }
//        if textTextField.tag == 0 {
//            //标题
//            if let str = textTextField.text {
//                titleStr = str
//            }
//            XJLog(message: titleStr)
//        } else if textTextField.tag == 1 {
//            //作者
//            if let str = textTextField.text {
//                publisher = str
//            }
//            XJLog(message: publisher)
//
//        } else if textTextField.tag == 2 {
//            //页数
//            if let str = textTextField.text {
//                pages = str
//            }
//            XJLog(message: pages)
//
//        } else {
//            //出版社
//            if let str = textTextField.text {
//                publish = str
//            }
//            XJLog(message: publish)
//        }

    }



    func setData(rowNum : Int)  {
        titleLabel.text = titleNameArr[rowNum]
        textTextField.tag = rowNum
        if rowNum == 0 {
            textTextField.placeholder = "必填"
            textTextField.keyboardType = .default
        } else if rowNum == 2 {
            textTextField.keyboardType = .numberPad
        } else {
            textTextField.keyboardType = .default
        }
    }
    /// 详情
    ///
    /// - Parameters:
    ///   - model: <#model description#>
    ///   - rowNum: <#rowNum description#>
    func setData_detail(model : MyBookDetailModel,rowNum : Int) {
        titleLabel.text = titleNameArr[rowNum]
        self.textTextField.tag = rowNum
        switch rowNum {
        case 0:
            //
            if let title = model.book.title {
                self.textTextField.text = title
            }
        case 1:
            //
            if let author_first = model.book.author_first {
                self.textTextField.text = author_first
            }
        case 2:
            //
            if let pages = model.book.pages {
                self.textTextField.text = "\(pages)"
            }
        case 3:
            //
            if let publisher = model.book.publisher {
                self.textTextField.text = publisher
            }
        default:
            XJLog(message: "暂无")
        }
    }

    /// 扫描
    ///
    /// - Parameters:
    ///   - model: <#model description#>
    ///   - rowNum: <#rowNum description#>
    func setData_scan(model : BookModel,rowNum : Int) {
        titleLabel.text = titleNameArr[rowNum]
        self.textTextField.tag = rowNum
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
