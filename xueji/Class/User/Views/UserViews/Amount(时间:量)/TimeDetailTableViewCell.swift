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


        lineView = UIView(frame: CGRect(x: bookNameLabel.frame.origin.x, y: bookNameLabel.frame.maxY + ip6(3), width: bookNameLabel.frame.width, height: 0.5))


        self.addSubview(bookImageView)
        self.addSubview(bookNameLabel)
        self.addSubview(lineView)
    }



    /// 赋值
    ///
    /// - Parameter model: <#model description#>
    func setData(model : MyDetailModel_btm_list)  {

        //缺少名字 色值返回不对 图片链接
        let labelW = (lineView.frame.width)/7
        bookImageView.setImage_kf(imageName: "", placeholderImage: #imageLiteral(resourceName: "book"))
        bookNameLabel.text = "123"
        if let str = model.color {
           lineView.backgroundColor = UIColor.xj_colorFromString(hexColor: str)
        }

        let arr = model.day
        for i in 0..<arr.count {
            let model : MyDetailModel_day = arr[i]
            let str = String.getHoreMin(min: model.time_count)
            let label = UILabel.getLabel(fream: CGRect(x: lineView.frame.origin.x + CGFloat(i) * labelW , y: lineView.frame.maxY, width: labelW, height: ip6(18)), fontSize: 10, text: str, textColor: black_53, textAlignment: .center)
            label.xj_makeBorderWithBorderWidth(width: 0.5, color: black_53)
            self.addSubview(label)
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
