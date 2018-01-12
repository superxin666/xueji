//
//  CategoryListModel.swift
//  xueji
//
//  Created by lvxin on 2018/1/12.
//  Copyright © 2018年 lvxin. All rights reserved.
//  分类列表模型


import ObjectMapper


class CategoryListModel_list: Mappable {
    var id: Int!
    var name: String!
    var ctime: String!
    var utime: String!
    var is_deleted: Int!
    var book_count: Int!
    

    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        ctime <- map["ctime"]
        utime <- map["utime"]
        is_deleted <- map["is_deleted"]
        book_count <- map["book_count"]
    }
    
    func getBookNum()->String {
        
        return "资料数：\(self.book_count!)"
    }
}

class CategoryListModel: Mappable {
    var count: Int!
    var list : [CategoryListModel_list] = []

    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        count <- map["count"]
        list <- map["list"]
    }
}




