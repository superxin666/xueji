//
//  ReviewModel.swift
//  xueji
//
//  Created by lvxin on 2018/4/7.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper
class ReviewModel_content: Mappable {

    var bookid: Int!
    var booktitle: String!
    var bookcover_img: String!
    var learnid: Int!
    var learnreminder: String!
    var learnbeg_page: Int!
    var learnend_page: Int!
    var reviewid: Int!
    var reviewstep: Int!
    var reviewtime: String!
    var reviewhm: String!
    var review: String!
    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        bookid <- map["bookid"]
        booktitle <- map["booktitle"]
        bookcover_img <- map["bookcover_img"]
        learnid <- map["learnid"]
        learnreminder <- map["learnreminder"]
        learnbeg_page <- map["learnbeg_page"]
        learnend_page <- map["learnend_page"]
        reviewid <- map["reviewid"]
        reviewstep <- map["reviewstep"]
        reviewtime <- map["reviewtime"]
        reviewhm <- map["reviewhm"]
        review <- map["review"]

    }
}

class ReviewModel: Mappable {

    var date: String!
    var content: [ReviewModel_content] = []
    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        date <- map["date"]
        content <- map["content"]

    }
}
