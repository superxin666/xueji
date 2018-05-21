//
//  TimeDetailTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2018/5/18.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let TimeDetailTableViewCellID = "TimeDetailTableViewCell_id"
let TimeDetailTableViewCellH = ip6(47)

class TimeDetailTableViewCell: UITableViewCell {
    var bookImageView : UIImageView!
    var bookNameLabel : UILabel!
    var lineView : UIView!


    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.creatUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func creatUI() {
        let viewW = KSCREEN_WIDTH - ip6(50)

        bookImageView = UIImageView(frame: CGRect(x: ip6(25), y: ip6(10), width: ip6(23), height: ip6(37)))
        bookImageView.setImage_kf(imageName: "", placeholderImage: #imageLiteral(resourceName: "book"))

        bookNameLabel = UILabel.getLabel(fream: CGRect(x: bookImageView.frame.maxX + ip6(12), y:ip6(10), width: viewW - ip6(12) -  bookImageView.frame.size.width, height: ip6(14)), fontSize: 10, text: "母猪的产后处理", textColor: black_53, textAlignment: .left)


        lineView = UIView(frame: CGRect(x: bookNameLabel.frame.origin.x, y: bookNameLabel.frame.maxY + ip6(3), width: bookNameLabel.frame.width, height: 0.5))
        lineView.backgroundColor = .green

        self.addSubview(bookImageView)
        self.addSubview(bookNameLabel)
        self.addSubview(lineView)
    }


    func setData()  {
        let labelW = (lineView.frame.width)/7

        for i in 0..<7 {
            let label = UILabel.getLabel(fream: CGRect(x: lineView.frame.origin.x + CGFloat(i) * labelW , y: lineView.frame.maxY, width: labelW, height: ip6(18)), fontSize: 10, text: "20h23m", textColor: black_53, textAlignment: .center)
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
