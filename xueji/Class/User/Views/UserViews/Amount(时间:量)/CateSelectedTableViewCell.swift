//
//  CateSelectedTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2018/5/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//  分类选择

import UIKit
let CateSelectedTableViewCellH = ip6(60)
let CateSelectedTableViewCellID = "CateSelectedTableViewCell_id"
let itemW :CGFloat = ip6(58)
let itemH :CGFloat = ip6(26)
protocol cateSelectedTableViewCellDelegate : NSObjectProtocol {

    func catClick(_ model : MyDetailModel_category_list)
}
class CateSelectedTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {
    var colletionView : UICollectionView!

    var dataArr : [MyDetailModel_category_list] = []
    var lastCell : CateCollectionViewCell!

    var delegate : cateSelectedTableViewCellDelegate!

    /// 上次点击tag
    var selectedCellTage = 0


    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.creatUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    func creatUI() {
        //图片
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = ip6(10)
        layout.minimumLineSpacing = ip6(10)

        colletionView = UICollectionView(frame: CGRect(x: ip6(20), y: ip6(34), width: KSCREEN_WIDTH - ip6(20), height: itemH), collectionViewLayout: layout)
        colletionView.register(CateCollectionViewCell.self, forCellWithReuseIdentifier: CateCollectionViewCellID)
        colletionView.backgroundColor = .clear
        colletionView.delegate = self
        colletionView.dataSource = self
        colletionView.showsVerticalScrollIndicator = false
        colletionView.showsHorizontalScrollIndicator = false
        colletionView.contentSize = CGSize(width: itemWidth * 10, height: itemHeight)
        self.addSubview(colletionView)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell :CateCollectionViewCell  = collectionView.dequeueReusableCell(withReuseIdentifier: CateCollectionViewCellID, for: indexPath) as! CateCollectionViewCell
        cell.tag = indexPath.row
        if dataArr.count > 0 {
            let model:MyDetailModel_category_list = self.dataArr[indexPath.row]
            cell.setData(title: model.name)
        }
//        if lastCell == nil {
//            if indexPath.row  == 0 {
//                lastCell = cell
//                cell.setSlected()
//            }
//
//        } else {
//            lastCell.setSlected()
//            cell.setNormal()
//        }

        if indexPath.row ==  selectedCellTage{
            cell.setSlected()
        } else {
            cell.setNormal()
        }


        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        XJLog(message: indexPath.row)
        if dataArr.count > 0 {
            let model:MyDetailModel_category_list = self.dataArr[indexPath.row]
            XJLog(message: model.name)
            if delegate != nil {
                self.delegate.catClick(model)
            }
            selectedCellTage = indexPath.row
        }
    }


    func setData(arr:[MyDetailModel_category_list]) {
        dataArr = arr
        colletionView.reloadData()
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
