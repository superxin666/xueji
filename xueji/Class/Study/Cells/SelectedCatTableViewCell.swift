//
//  SelectedCatTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2017/11/17.
//  Copyright © 2017年 lvxin. All rights reserved.
//  添加书--选择分类cell

import UIKit

class SelectedCatTableViewCell: UITableViewCell {
    /// 分类名字标签
    var nameLabel : UILabel!
    
    /// 个数标签
    var numLabel : UILabel!
    
    var selectedBtn : UIButton!
    
    
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
        nameLabel = UILabel()
        nameLabel.frame  = CGRect(x: ip6(28), y: ip6(7), width: KSCREEN_WIDTH - ip6(56), height: ip6(25));
        nameLabel.font = xj_fzFontMedium(ip6(18))
        nameLabel.text = "分类"
        nameLabel.textColor = black_53
        nameLabel.textAlignment = .left
        self.addSubview(nameLabel)
        
        numLabel = UILabel()
        numLabel.frame  = CGRect(x: ip6(28), y: nameLabel.frame.maxY, width: KSCREEN_WIDTH - ip6(85), height: ip6(13));
        numLabel.font = xj_fzFontMedium(ip6(9))
        numLabel.text = "资料数：3"
        numLabel.textColor = black_8c8484
        numLabel.textAlignment = .left
        self.addSubview(numLabel)
        
        selectedBtn = UIButton.getBtn_picStyle(image_normal: #imageLiteral(resourceName: "study_Circle_normal"), image_selected: #imageLiteral(resourceName: "study_Circle_selected"), fream: CGRect(x: KSCREEN_WIDTH - ip6(28) - ip6(25), y: ip6(13) , width: ip6(25), height: ip6(25)), selector: #selector(self.selectedBtn_click(sender:)), vc: self, tag: 0)
         self.addSubview(selectedBtn)
        
        let lineView = UIView(frame: CGRect(x: ip6(26), y: ip6(50), width: KSCREEN_WIDTH - ip6(52), height:1))
        lineView.backgroundColor = black_97
        self.addSubview(lineView)
    }
    
    func setData(name : String)  {
        nameLabel.text = name
    }
    
    func selectedBtn_click(sender : UIButton) {
        sender.isSelected = !sender.isSelected
    }
}
