//
//  CategoryListModel.swift
//  xueji
//
//  Created by lvxin on 2018/1/12.
//  Copyright © 2018年 lvxin. All rights reserved.
//  分类列表模型


import ObjectMapper
class CategoryListModel_list_book_list: Mappable {
    
    /// 书籍id
    var id: Int!
    
    ///名字
    var title: String!
    
    /// 书籍封面
    var cover_img: String!

    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        cover_img <- map["cover_img"]

    }
}

class CategoryListModel_list: Mappable {
    
    /// 分类id
    var id: Int!
    
    /// 分类名称
    var name: String!
    
    /// 创建该条分类的时间
    var ctime: String!
    
    /// 该条目的最后更新时间
    var utime: String!
    
    /// 0:未删除,1:已删除
    var is_deleted: Int!
    
    /// 当前分类下所含书籍合计数目
    var book_count: Int!
    
    /// 数组 当前分类下包含的书籍模型
    var book_list : [CategoryListModel_list_book_list] = []

    
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
        book_list <- map["book_list"]
    }
    
    /// 获取资料个数  分类UI
    ///
    /// - Returns: <#return value description#>
    func getBookNum()->String {
        if let count = self.book_count{
            return "资料数：\(count)"
        } else {
            return ""
        }
    }
    
    /// 获取分类名字
    ///
    /// - Returns: <#return value description#>
    func getCatName() -> String {
        if let name  = self.name {
            return name
        } else {
            return ""
        }
    }
}

class CategoryListModel: Mappable {
    var count: Int!
    
    /// 数组 分类数据模型
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




