//
//  ReviewModel.swift
//  xueji
//
//  Created by lvxin on 2018/4/7.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

class ReviewModel_content_review: Mappable {
    
    var id: Int!
    var step: [String] = []

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        step <- map["step"]
    }
}

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
    var review: ReviewModel_content_review = ReviewModel_content_review()
    
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
    var review_count: Int!
    var week_seq: Int!
    var content: [ReviewModel_content] = []
    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        date <- map["date"]
        review_count <- map["review_count"]
        week_seq <- map["week_seq"]
        content <- map["content"]
    }
    
    static func getTitleStr(num : Int) -> String {
        switch num  {
        case 0:
            return "星期日"
        case 1:
            return "星期一"
        case 2:
            return "星期二"
        case 3:
            return "星期三"
        case 4:
            return "星期四"
        case 5:
            return "星期五"
        case 6:
            return "星期六"
            
        default:
            return ""
        }
    }
}
