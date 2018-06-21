//
//  CategoryMolde.swift
//  xueji
//
//  Created by lvxin on 2018/6/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//
import ObjectMapper

class CategoryMolde: Mappable {


    var id: Int!
    var user_id: Int!
    var is_deleted: Int!
    var sort: Int!
    var name: String!
    var ctime: String!
    var utime: String!
    var color: String!

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        user_id <- map["user_id"]
        is_deleted <- map["is_deleted"]
        sort <- map["sort"]
        name <- map["name"]
        ctime <- map["ctime"]
        utime <- map["utime"]
        color <- map["color"]
    }
}
