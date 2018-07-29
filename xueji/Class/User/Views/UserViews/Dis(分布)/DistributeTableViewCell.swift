//
//  DistributeTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2018/5/22.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let DistributeTableViewCellH = ip6(55)
let DistributeTableViewCellID = "DistributeTableViewCell_id"

class DistributeTableViewCell: UITableViewCell {
    var bookImageView : UIImageView!
    var bookNameLabel : UILabel!
    var lineView : UIView!
    var label : UILabel!
    var labelArr : [UILabel]! = []
    var label1 : UILabel!
    var label2 : UILabel!



    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.creatUI()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func creatUI() {
        let viewW = KSCREEN_WIDTH - ip6(50)

        bookImageView = UIImageView(frame: CGRect(x: ip6(25), y: ip6(10), width: ip6(23), height: ip6(37)))


        bookNameLabel = UILabel.getLabel(fream: CGRect(x: bookImageView.frame.maxX + ip6(12), y:ip6(10), width: viewW - ip6(12) -  bookImageView.frame.size.width, height: ip6(14)), fontSize: 10, text: "", textColor: black_53, textAlignment: .left)


        lineView = UIView(frame: CGRect(x: bookNameLabel.frame.origin.x, y: bookNameLabel.frame.maxY + ip6(3), width: bookNameLabel.frame.width, height: 1))


        let labelW = (lineView.frame.width)/2

        for i in 0..<2 {
            label = UILabel.getLabel(fream: CGRect(x: lineView.frame.origin.x + CGFloat(i) * labelW , y: lineView.frame.maxY, width: labelW, height: ip6(22)), fontSize: 10, text: "", textColor: black_53, textAlignment: .center)
            label.xj_makeBorderWithBorderWidth(width: 1, color: UIColor.xj_colorFromRGB(rgbValue: 0xF1F1F3))
            if i == 0 {
                label1 = label
            } else {
                label2 = label
            }

            self.addSubview(label)
        }

        self.addSubview(bookImageView)
        self.addSubview(bookNameLabel)
        self.addSubview(lineView)
        
    }

    func setData(model : MyDetailModel_btm_list,viewType : TimeDistributeViewControllerType)  {

        if let str  = model.pic{
            bookImageView.setImage_kf(imageName: str, placeholderImage: #imageLiteral(resourceName: "bookLoading"))
        }

        if let str  = model.name{
            bookNameLabel.text = str
        }

        if let str = model.color {
            lineView.backgroundColor = UIColor.xj_colorFromString(hexColor: str)
        }
        
        if viewType == .time {
            if let str = model.timeTotla {
                let str1 = String.getHoreMin(min: str)
                label1.text = str1
            }
            if let str = model.timePre {
                label2.text = "\(str)%"
            }


        } else {
            if let str = model.pageTotla {
                label1.text = "\(str)p"
            }
            if let str = model.pagePre {
                label2.text = "\(str)%"
            }
        }
    }

}
