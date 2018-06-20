//
//  BookModel.swift
//  xueji
//
//  Created by lvxin on 2018/6/17.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import ObjectMapper

class BookModel: Mappable {
    var author_all: String!
    var author_first: String!
    var cover_img: String!
    var created_by: Int!
    var ctime: String!
    var douban_id: Int!
    var id: Int!
    var isbn: Int!
    var pages: Int!
    var pubdate: String!
    var publisher: String!
    var title: String!

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        author_all <- map["author_all"]
        author_first <- map["author_first"]
        cover_img <- map["cover_img"]
        created_by <- map["created_by"]
        ctime <- map["ctime"]
        douban_id <- map["douban_id"]
        id <- map["id"]
        isbn <- map["isbn"]
        pages <- map["pages"]
        pubdate <- map["pubdate"]
        publisher <- map["publisher"]
        title <- map["title"]

    }

}
