//
//  DateStepTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2018/5/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//  日期选择器

import UIKit
let DateStepTableViewCellH = ip6(40)
let DateStepTableViewCellID = "DateStepTableViewCell_id"

class DateStepTableViewCell: UITableViewCell {
    var titleBtn : UIButton!
    var leftBtn : UIButton!
    var rightBtn : UIButton!


    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.creatUI()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func creatUI()  {
        titleBtn = UIButton.getBtn_titleStyle(title_normal: "2017-10", title_selected: "2017-10", fream: CGRect(x: ip6(20), y:  ip6(15), width: KSCREEN_WIDTH - ip6(40), height: ip6(25)), backgroundColor: .white, textColorSelectrd: black_53, textColor: black_53, fontSize: 14, textAlignment: .center, selector: #selector(click(sender:)), vc: self, tag: 0)
        titleBtn.xj_makeBorderWithBorderWidth(width: 1, color: black_53)
        titleBtn.xj_makeRadius(radius: 3)
        self.addSubview(titleBtn)

        leftBtn = UIButton.getBtn_picStyle(image_normal: #imageLiteral(resourceName: "base_left"), image_selected: #imageLiteral(resourceName: "base_left"), fream: CGRect(x: 0, y: 0, width: titleBtn.frame.size.width/2, height: titleBtn.frame.size.height), selector: #selector(click(sender:)), vc: self, tag: 1)
        leftBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -(titleBtn.frame.size.width/2 - 20), bottom: 0, right: 0)

        self.titleBtn.addSubview(leftBtn)
        rightBtn = UIButton.getBtn_picStyle(image_normal: #imageLiteral(resourceName: "base_right"), image_selected: #imageLiteral(resourceName: "base_right"), fream: CGRect(x: titleBtn.frame.size.width/2, y: 0, width: titleBtn.frame.size.width/2, height: titleBtn.frame.size.height), selector: #selector(click(sender:)), vc: self, tag: 2)
        rightBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: titleBtn.frame.size.width/2 - 20, bottom: 0, right: 0)
        self.titleBtn.addSubview(rightBtn)
    }
    func click(sender:UIButton) {
        if sender.tag == 1 {
            XJLog(message: "左")
        } else if sender.tag == 2 {
            XJLog(message: "右")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
