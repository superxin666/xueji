//
//  LearnDetailReviewTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2018/5/9.
//  Copyright © 2018年 lvxin. All rights reserved.
//  复习备注

import UIKit
protocol LearnDetailReviewTableViewCellDelegate {
    func endText_LearnDetailReview(contentStr : String,tagNum : Int)
}

let LearnDetailReviewTableViewCellID = "LearnDetailReviewTableViewCell_id"
let LearnDetailReviewTableViewCellH = CGFloat(152)
class LearnDetailReviewTableViewCell: UITableViewCell,UITextViewDelegate {
    var delegate : LearnDetailReviewTableViewCellDelegate!

    /// 标题
    var titleLabel : UILabel!

    /// 输入
    var textView : UITextView!

    var conTent :String = ""


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
        self.selectionStyle  = .none
        self.creatUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatUI() {
        let X = ip6(20)
        let viewW = KSCREEN_WIDTH - ip6(40)
        let viewH = ip6(32)

        let backView = UIView(frame: CGRect(x: X, y: 0, width: viewW, height: LearnDetailReviewTableViewCellH))
        backView.backgroundColor = .white
        self.addSubview(backView)

        titleLabel = UILabel.getLabel(fream: CGRect(x: 0, y: ip6(10), width: ip6(100), height: ip6(20)), fontSize: 15, text: "", textColor: UIColor.xj_colorFromRGB(rgbValue: 0xE7E5E5), textAlignment: .left)
        backView.addSubview(titleLabel)

        textView = UITextView(frame: CGRect(x: 0, y: titleLabel.frame.maxY + ip6(10), width: viewW, height: ip6(100)))
        textView.isUserInteractionEnabled = true
        textView.isEditable = true
        textView.delegate = self
        textView.textColor = black_53
        textView.font = xj_fontThin(15)
        textView.xj_makeRadius(radius: 2)
        textView.xj_makeBorderWithBorderWidth(width: 1, color: UIColor.xj_colorFromRGB(rgbValue: 0xE7E5E5))
        backView.addSubview(textView)

    }

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if let str = textView.text {
            conTent = str
            if let delgate = self.delegate {
                delgate.endText_LearnDetailReview(contentStr: conTent, tagNum: self.textView.tag)
            }
        }
    }


    func setData_notice(contentStr : String) {
        self.titleLabel.text = "复习备注"
        self.textView.text = contentStr

    }
    func setData_notice_enble() {
        textView.isUserInteractionEnabled = true
        self.titleLabel.textColor = UIColor.xj_colorFromRGB(rgbValue: 0x535353)
    }
    func setData_notice_unenble() {
        textView.isUserInteractionEnabled = false
        self.titleLabel.textColor = UIColor.xj_colorFromRGB(rgbValue: 0xE7E5E5)
    }

}
