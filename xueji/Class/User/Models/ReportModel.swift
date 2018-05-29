//
//  ReportModel.swift
//  xueji
//
//  Created by lvxin on 2018/5/29.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper
class ReportModel_date_sum: Mappable {
    var page_count: Int!
    var time_count: Int!


    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        page_count <- map["page_count"]
        time_count <- map["time_count"]
    }
}
class ReportModel_date_book: Mappable {
    var page_count: Int!
    var time_count: Int!
    var id: Int!

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        page_count <- map["page_count"]
        time_count <- map["time_count"]
        id <- map["id"]
    }
}

class ReportModel_sum: Mappable {
    var first5_time: [Int] = []
    var first5_page: [Int] = []
    var sum: ReportModel_date_sum!
    var book: [ReportModel_date_book] = []

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        first5_time <- map["first5_time"]
        first5_page <- map["first5_page"]
        sum <- map["sum"]
        book <- map["book"]
    }
}
class ReportModel_date: Mappable {
    var day: String!
    var week: String!
    var month: String!
    var sum: ReportModel_date_sum!
    var book: [ReportModel_date_book] = []

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        day <- map["day"]
        sum <- map["sum"]
        book <- map["book"]
    }
}



class ReportModel: Mappable {

    var day : [ReportModel_date] = []
    var week : [ReportModel_date] = []
    var month : [ReportModel_date] = []
    var sum : ReportModel_sum!


    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        day <- map["day"]
        week <- map["week"]
        month <- map["month"]
        sum <- map["sum"]
    }
}
