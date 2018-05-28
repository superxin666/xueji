//
//  UserInfoModel.swift
//  xueji
//
//  Created by lvxin on 2018/5/28.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

class UserInfoModel_weekgoal_timepages: Mappable {
    var goal: Int!
    var done: Int!
    var rate: Int!

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        goal <- map["goal"]
        done <- map["done"]
        rate <- map["rate"]
    }
}



class UserInfoModel_weekgoal: Mappable {
    var time: UserInfoModel_weekgoal_timepages = UserInfoModel_weekgoal_timepages()

    var pages: UserInfoModel_weekgoal_timepages = UserInfoModel_weekgoal_timepages()


    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        time <- map["time"]
        pages <- map["pages"]
    }
}

class UserInfoModel_head_week_learned_flag: Mappable {
    var date: String!
    var learned : Bool!

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        date <- map["date"]
        learned <- map["learned"]
    }
}
class UserInfoModel_head: Mappable {
    var continuous_days: Int!
    var beg_long:String!
    var latest:String!
    var latest_long:String!
    var week_learned_flag:[UserInfoModel_head_week_learned_flag] = []
    var head : [CategoryListModel_list] = []


    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        continuous_days <- map["continuous_days"]
        beg_long <- map["beg_long"]
        latest <- map["latest"]
        latest_long <- map["latest_long"]
        week_learned_flag <- map["week_learned_flag"]
        head <- map["head"]
    }
}




class UserInfoModel: Mappable {
    var count: Int!

    /// 数组 分类数据模型
    var head : UserInfoModel_head = UserInfoModel_head()
    var week_goal : UserInfoModel_weekgoal = UserInfoModel_weekgoal()

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        head <- map["head"]
        week_goal <- map["week_goal"]
    }
}
