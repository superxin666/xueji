//
//  StudyBookCellTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2017/10/31.
//  Copyright © 2017年 lvxin. All rights reserved.
//  studyVC tableViewcell

import UIKit
typealias StudyBookCellTableViewCellBlock = (_ model : CategoryListModel_list_book_list,_ catModel:CategoryListModel_list)->()
typealias DelBookCellTableViewCellBlock = (_ tag : Int,_ indexPath:IndexPath)->()


class StudyBookCellTableViewCell: UITableViewCell {

    var bookImageView : UIButton_title!
    var bookImageView_recent : UIButton!

    var bookClickBlock : StudyBookCellTableViewCellBlock!
    var bookPresBlock : StudyBookCellTableViewCellBlock!
    var currectModel : CategoryListModel_list!
    var currectModelArr : [CategoryListModel_list_book_list]!


    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.creatUI()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func creatUI() {
        
        
    }

    /// 分类列表
    ///
    /// - Parameter model: <#model description#>
    func setUpUI(model: CategoryListModel_list,indexPath : IndexPath) {
        //
        currectModel = model
        let bookCount_line = 3
        for i in 0..<model.book_list.count {
            
            let subModel = model.book_list[i]
            let imageH = ip6(132 + 14 + 7)
            let imageW = ip6(100)
            let appading = (KSCREEN_WIDTH - imageW * CGFloat(3))/4

            let Y = CGFloat((i/bookCount_line)) * (imageH + ip6(10))
            let X = appading + ((appading + imageW) * CGFloat(i%3))
            bookImageView = UIButton_title(frame: CGRect(x: X, y: Y, width: imageW, height: imageH))
            bookImageView.tag = i
            bookImageView.setImage_kf(imageName: subModel.cover_img, placeholderImage: #imageLiteral(resourceName: "bookLoading"))
            bookImageView.addTarget(self, action: #selector(bookClick(sender:)), for: .touchUpInside)
            bookImageView.setTitle(subModel.title, for: .normal)
            bookImageView.titleLabel?.font = xj_fontThin(ip6(10))
            bookImageView.titleLabel?.textAlignment = .center
            bookImageView.setTitleColor(black_53, for: .normal)



            let tap = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(ges:)))
            bookImageView.addGestureRecognizer(tap)

            
            self.contentView.addSubview(bookImageView)
        }
        
    }
    
    
    
    /// 最近学习
    ///
    /// - Parameter arr: <#arr description#>
    func setUpUI_recent(arr : Array<CategoryListModel_list_book_list>)  {
        currectModelArr = arr



        for i in 0..<arr.count {
            let subModel = arr[i]
            let imageH = ip6(100)
            let imageW = ip6(67)
//            let appading = ip6(20)

            let appading = (KSCREEN_WIDTH - imageW * 4)/5
            let Y = CGFloat((i/4)) * (imageH + ip6(10))
            let X = appading + ((appading + imageW) * CGFloat(i%4))
            bookImageView_recent = UIButton(frame: CGRect(x: X, y: Y, width: imageW, height: imageH))
            bookImageView_recent.tag = i
            bookImageView_recent.setImage_kf(imageName: subModel.cover_img, placeholderImage: #imageLiteral(resourceName: "bookLoading"))
            bookImageView_recent.addTarget(self, action: #selector(bookClick_recent(sender:)), for: .touchUpInside)

            let tap = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress_recent(ges:)))
            bookImageView_recent.addGestureRecognizer(tap)

            self.contentView.addSubview(bookImageView_recent)
        }
        
    }
    func bookClick(sender : UIButton) {
        let tagNum = sender.tag
        let model : CategoryListModel_list_book_list = currectModel.book_list[tagNum]
        XJLog(message: "点击\(tagNum)"+model.title)
        self.bookClickBlock(model,currectModel)
    }

    func longPress(ges : UILongPressGestureRecognizer) {
        let viewTag = ges.view?.tag
        let model : CategoryListModel_list_book_list = currectModel.book_list[viewTag!]
        self.bookPresBlock(model,currectModel)

    }

    func bookClick_recent(sender : UIButton) {
        XJLog(message: "点击")
        let tagNum = sender.tag
        let model : CategoryListModel_list_book_list = currectModelArr[tagNum]
        self.bookClickBlock(model,CategoryListModel_list())
    }

    func longPress_recent(ges : UILongPressGestureRecognizer) {
         XJLog(message: "长按~~~")
        let viewTag = ges.view?.tag
        let model : CategoryListModel_list_book_list = currectModelArr[viewTag!]
        self.bookPresBlock(model,CategoryListModel_list())

    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
