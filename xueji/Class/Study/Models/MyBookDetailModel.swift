//
//  MyBookDetailModel.swift
//  xueji
//
//  Created by lvxin on 2018/6/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import ObjectMapper

class MyBookDetailModel: Mappable {

    /// 分类
    var category : CategoryMolde = CategoryMolde()
    /// 书籍
    var book : BookModel = BookModel()

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        category <- map["category"]
        book <- map["book"]

    }
}
