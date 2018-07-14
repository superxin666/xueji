//
//  MyDetailModel.swift
//  xueji
//
//  Created by lvxin on 2018/7/14.
//  Copyright © 2018年 lvxin. All rights reserved.
//  统计详情数据模型

import UIKit
import ObjectMapper
class MyDetailModel_category_list: Mappable {

    var id : Int!
    var name : String = String()

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
class MyDetailModel_day: Mappable {

    var time_count : Int!
    var page_count : Int!

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        time_count <- map["time_count"]
        page_count <- map["page_count"]
    }
}

class MyDetailModel_btm_list: Mappable {

    var category_id : Int!
    var book_id : Int!
    var color : String!
    var day : [MyDetailModel_day] = []


    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        category_id <- map["category_id"]
        book_id <- map["book_id"]
        color <- map["color"]
        day <- map["day"]
    }
}

class MyDetailModel_max: Mappable {

    var time : Int!
    var page : Int!

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        time <- map["time"]
        page <- map["page"]
    }
}

class MyDetailModel_report: Mappable {

    var day : String!
    var sum : ReportModel_date_sum = ReportModel_date_sum()
    var category : [ReportModel_date_book] = []
    var book : [ReportModel_date_book] = []


    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        day <- map["day"]
        sum <- map["sum"]
        category <- map["category"]
        book <- map["book"]
    }
}



class MyDetailModel: Mappable {

    var report : [MyDetailModel_report] = []
    var max : MyDetailModel_max = MyDetailModel_max()

    var btm_list : [MyDetailModel_btm_list] = []
    var category_list : [MyDetailModel_category_list] = []


    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        report <- map["report"]
        btm_list <- map["btm_list"]
        max <- map["max"]
        category_list <- map["category_list"]
    }
}
