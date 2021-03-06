//
//  AddBook_CatTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2017/11/14.
//  Copyright © 2017年 lvxin. All rights reserved.
//  添加资料 添加分类cell

import UIKit
typealias AddBook_CatTableViewCellBlock = () -> ()

class AddBook_CatTableViewCell: UITableViewCell {
    var backView : UIView!
    
    var titleLabel : UILabel!
    var catLabel : UILabel!
    var textStr : String!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.creatUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatUI()  {
        let viewW = KSCREEN_WIDTH - ip6(72)
        backView = UIView(frame: CGRect(x: ip6(36), y: ip6(30), width: viewW, height: addBookCellHeight))
        self.contentView.addSubview(backView)
        
        titleLabel = UILabel.getLabel(fream: CGRect(x: 0, y: ip6(16), width: ip6(60), height: ip6(25)), fontSize: 18, text: "分 类", textColor: black_53, textAlignment: .left)
        backView.addSubview(titleLabel)
        
        let arroImageView = UIImageView(frame: CGRect(x: viewW - ip6(7), y: ip6(24), width: ip6(7), height: ip6(12)))
        arroImageView.image = #imageLiteral(resourceName: "study_shape_>")
        backView.addSubview(arroImageView)
//
        
        catLabel = UILabel.getLabel(fream: CGRect(x: titleLabel.frame.maxX, y: ip6(16), width: viewW - titleLabel.frame.maxX - ip6(10), height: ip6(25)), fontSize: 18, text: "", textColor: black_53, textAlignment: .right)
        backView.addSubview(catLabel)
        

        let lineView : UIView = UIView(frame: CGRect(x: 0, y: addBookCellHeight - 1, width: viewW, height: 1))
        lineView.backgroundColor = black_e3e0e0
        backView.addSubview(lineView)
    }


    /// 分类名字赋值
    ///
    /// - Parameter name: <#name description#>
    func setTitle(name : String) {
        catLabel.text = name
    }

}
