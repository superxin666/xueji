//
//  TimeDetailTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2018/5/18.
//  Copyright © 2018年 lvxin. All rights reserved.
//  时间/学习量 分布cell

import UIKit
let TimeDetailTableViewCellID = "TimeDetailTableViewCell_id"
let TimeDetailTableViewCellH = ip6(47)

class TimeDetailTableViewCell: UITableViewCell {
    var bookImageView : UIImageView!
    var bookNameLabel : UILabel!
    var lineView : UIView!

    var catCirle : UIView!

    var label : UILabel!
    var labelArr : [UILabel] = []


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

        catCirle = UIView(frame: CGRect(x: ip6(19), y: ip6(28), width: ip6(10), height: ip6(10)))
        catCirle.xj_makeRound()


        bookNameLabel = UILabel.getLabel(fream: CGRect(x: bookImageView.frame.maxX + ip6(12), y:ip6(10), width: viewW - ip6(12) -  bookImageView.frame.size.width, height: ip6(14)), fontSize: 10, text: "", textColor: black_53, textAlignment: .left)


        lineView = UIView(frame: CGRect(x: bookNameLabel.frame.origin.x, y: bookNameLabel.frame.maxY + ip6(3), width: bookNameLabel.frame.width, height: 0.5))
        let labelW = (lineView.frame.width)/7
        if labelArr.count > 0 {
            labelArr.removeAll()
        }
        for i in 0..<7 {
            label = UILabel.getLabel(fream: CGRect(x: lineView.frame.origin.x + CGFloat(i) * labelW , y: lineView.frame.maxY, width: labelW, height: ip6(18)), fontSize: 10, text: "", textColor: black_53, textAlignment: .center)
            label.xj_makeBorderWithBorderWidth(width: 0.5, color: UIColor.xj_colorFromRGB(rgbValue: 0xF1F1F3))
            self.addSubview(label)
            labelArr.append(label)

        }

        self.addSubview(catCirle)
        self.addSubview(bookImageView)
        self.addSubview(bookNameLabel)
        self.addSubview(lineView)
    }



    /// 赋值
    ///
    /// - Parameter model: <#model description#>
    func setData(model : MyDetailModel_btm_list,type : String,time_dimType:String,viewType : TimeDetailViewControllerType)  {
        if type == CALC_BOOK {
            catCirle.isHidden  = true
            bookImageView.isHidden = false
            bookImageView.setImage_kf(imageName: model.pic, placeholderImage: #imageLiteral(resourceName: "bookLoading"))
        } else {
            catCirle.isHidden  = false
            bookImageView.isHidden = true
            if let str = model.color {
                catCirle.backgroundColor = UIColor.xj_colorFromString(hexColor: str)
            }
        }



        //
        bookNameLabel.text = model.name
        if let str = model.color {
            lineView.backgroundColor = UIColor.xj_colorFromString(hexColor: str)
        }

        var arr : [MyDetailModel_day] = []
        if time_dimType == "DAY" {
            arr = model.day
        } else if time_dimType == "WEEK" {
            arr = model.week
        } else {
            arr = model.month
        }
        if viewType == .time {
            for i in 0..<7 {
                let model : MyDetailModel_day = arr[i]
                let str = String.getHoreMin(min: model.time_count)
                let label1 = labelArr[i]
                label1.text = str
            }
        } else {
            for i in 0..<7 {
                let model : MyDetailModel_day = arr[i]

                let label1 = labelArr[i]
                if let str = model.page_count {
                    label1.text = "\(str)p"
                }
            }
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
