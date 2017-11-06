//
//  HeadBookCollectionViewCell.swift
//  学记
//
//  Created by lvxin on 2017/10/30.
//  Copyright © 2017年 lvxin. All rights reserved.
//  studyVC collectioncell

import UIKit

class HeadBookCollectionViewCell: UICollectionViewCell {
    let imageView : UIImageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.creatUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatUI()  {
        imageView.frame = CGRect(x: 0, y: 0, width: itemWidth, height: itemHeight)
        imageView.setImage_kf(imageName: "", placeholderImage: #imageLiteral(resourceName: "book"))
        self.addSubview(imageView)
    }
}
