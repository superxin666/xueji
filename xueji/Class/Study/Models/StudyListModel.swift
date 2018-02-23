//
//  StudyListModel.swift
//  xueji
//
//  Created by lvxin on 2018/2/23.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import ObjectMapper

class StudyListModel: Mappable {
    var count: Int!
    
    /// 数组 分类数据模型
    var list : [CategoryListModel_list] = []
    /// 最近学习
    var recent_learn : [CategoryListModel_list_book_list] = []
    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        count <- map["count"]
        list <- map["list"]
        recent_learn <- map["recent_learn"]
    }
}
