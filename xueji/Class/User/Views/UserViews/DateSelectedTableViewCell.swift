//
//  DateSelectedTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2018/5/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//  日周月

import UIKit
let DateSelectedTableViewCellH = ip6(60-17)
let DateSelectedTableViewCellID = "DateSelectedTableViewCell_ID"
class DateSelectedTableViewCell: UITableViewCell {
    var leftBtn : UIButton!
    var midBtn : UIButton!
    var rightdBtn : UIButton!
    var lastBtn : UIButton!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.creatUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func creatUI()  {
        let btnViewW = (KSCREEN_WIDTH - ip6(40) - 2)/3
        let btnNameArr = ["日","周","月",]

        for i in 0..<btnNameArr.count {

            let btn = UIButton.getBtn_titleStyle(title_normal: btnNameArr[i], title_selected: btnNameArr[i], fream: CGRect(x: ip6(20) + (btnViewW + 1) * CGFloat(i), y: ip6(20) , width: btnViewW, height: ip6(23)), backgroundColor: .white, textColorSelectrd: .white, textColor: black_53, fontSize: 14, textAlignment: .center, selector: #selector(self.btnClick(sender:)), vc: self, tag: i)
            btn.xj_makeBorderWithBorderWidth(width: 1, color: black_53)
            btn.xj_makeRadius(radius: 3)
            self.addSubview(btn)
            if i == 0 {
                leftBtn = btn
                leftBtn.isSelected = true
                lastBtn = leftBtn
                btn.backgroundColor = black_8c8484
            } else if i == 1{
                midBtn = btn
            } else{
                rightdBtn = btn
            }
        }
    }

    func btnClick(sender:UIButton) {
        if sender.isSelected {
            return
        }
        let tagNum : Int = sender.tag
        sender.backgroundColor = black_8c8484
        lastBtn.backgroundColor = .white
        lastBtn.isSelected = sender.isSelected
        sender.isSelected = !sender.isSelected
        lastBtn = sender
        XJLog(message: tagNum)

//        if tagNum == 0 {
//
//            midBtn.backgroundColor = .white
//            rightdBtn.backgroundColor = .white
//        } else if tagNum == 1 {
//            leftBtn.backgroundColor = .white
//            rightdBtn.backgroundColor = .white
//        } else {
//            leftBtn.backgroundColor = .white
//            midBtn.backgroundColor = .white
//        }
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
