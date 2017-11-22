//
//  EditCatyTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2017/11/2.
//  Copyright © 2017年 lvxin. All rights reserved.
//   编辑分类cell

import UIKit

class EditCatyTableViewCell: UITableViewCell {

    /// 分类名字标签
    var nameLabel : UILabel!
    
    /// 个数标签
    var numLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.creatUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatUI() {
        
        nameLabel = UILabel.getLabel(fream: CGRect(x: ip6(28), y: ip6(7), width: KSCREEN_WIDTH - ip6(56), height: ip6(25)), fontSize: 18, text: "分类", textColor: black_53, textAlignment: .left)
        self.addSubview(nameLabel)
        
        numLabel = UILabel.getLabel(fream: CGRect(x: ip6(28), y: nameLabel.frame.maxY, width: KSCREEN_WIDTH - ip6(85), height: ip6(13)), fontSize: 9, text: "资料数：3", textColor: black_8c8484, textAlignment: .left)
        self.addSubview(numLabel)
        
        let lineView = UIView(frame: CGRect(x: ip6(26), y: ip6(50), width: KSCREEN_WIDTH - ip6(26) - ip6(26), height:1))
        lineView.backgroundColor = black_97
        self.addSubview(lineView)
    }
    
    func setData(name : String)  {
        nameLabel.text = name
    }
}
