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
    var bookImageView : UIButton!
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
        let bookCount_line = 4
        let boardW = ip6(21)
//        XJLog(message: "数据个数\(model.book_list.count)")
        for i in 0..<model.book_list.count {
            
            let subModel = model.book_list[i]
            let imageH = ip6(100)
            let imageW = ip6(65)
            let appading = (KSCREEN_WIDTH - boardW * CGFloat(2) - imageW * CGFloat(bookCount_line))/CGFloat((bookCount_line - 1))

            let Y = CGFloat((i/bookCount_line)) * (imageH + ip6(16))
            let X = ip6(21) + ((appading + imageW) * CGFloat(i%4))
            bookImageView = UIButton(frame: CGRect(x: X, y: Y, width: imageW, height: imageH))
            bookImageView.tag = i
            bookImageView.setImage_kf(imageName: subModel.cover_img, placeholderImage: #imageLiteral(resourceName: "book"))
            bookImageView.addTarget(self, action: #selector(bookClick(sender:)), for: .touchUpInside)

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
            let imageW = ip6(65)
            //            let x = ip6(21)
            let appading = (KSCREEN_WIDTH - ip6(42) - imageW * 4)/3
            let Y = CGFloat((i/4)) * (imageH + ip6(16))
            let X = ip6(21) + ((appading + imageW) * CGFloat(i%4))
            bookImageView = UIButton(frame: CGRect(x: X, y: Y, width: imageW, height: imageH))
            bookImageView.tag = i
            bookImageView.setImage_kf(imageName: subModel.cover_img, placeholderImage: #imageLiteral(resourceName: "book"))
            bookImageView.addTarget(self, action: #selector(bookClick_recent(sender:)), for: .touchUpInside)
            self.contentView.addSubview(bookImageView)
        }
        
    }
    func bookClick(sender : UIButton) {
        let tagNum = sender.tag
        let model : CategoryListModel_list_book_list = currectModel.book_list[tagNum]
        XJLog(message: "点击\(tagNum)"+model.title)
        self.bookClickBlock(model,currectModel)
    }
    
    func bookClick_recent(sender : UIButton) {
        XJLog(message: "点击")
        let tagNum = sender.tag
        let model : CategoryListModel_list_book_list = currectModelArr[tagNum]
        self.bookClickBlock(model,currectModel)
    }

    func longPress(ges : UILongPressGestureRecognizer) {
        let viewTag = ges.view?.tag
        let model : CategoryListModel_list_book_list = currectModel.book_list[viewTag!]
        self.bookPresBlock(model,currectModel)

    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
