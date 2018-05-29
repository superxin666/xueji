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

    func getTimedone() -> NSMutableAttributedString{
        guard let done = self.done else { return  NSMutableAttributedString(string: "")}
        if done < 60 {

            let strH = "00".getAttributedStr_color(color: green_84B53E, fontSzie: 12)
            strH.append(" h ".getAttributedStr_color(color: UIColor.xj_colorFromRGB(rgbValue: 0xFE3E3E3), fontSzie: 8))

            let str = "\(done)".getAttributedStr_color(color: green_84B53E, fontSzie: 12)
            str.append(" m ".getAttributedStr_color(color: UIColor.xj_colorFromRGB(rgbValue: 0xFE3E3E3), fontSzie: 8))

            strH.append(str)
            return strH
        } else {
            let h = done/60
            let strH = "\(h)".getAttributedStr_color(color: green_84B53E, fontSzie: 12)
            strH.append(" h ".getAttributedStr_color(color: UIColor.xj_colorFromRGB(rgbValue: 0xFE3E3E3), fontSzie: 8))

            let M = done%60
            let strM = "\(M)".getAttributedStr_color(color: green_84B53E, fontSzie: 12)
            strM.append(" m ".getAttributedStr_color(color: UIColor.xj_colorFromRGB(rgbValue: 0xFE3E3E3), fontSzie: 8))

            strH.append(strM)
            return strH
        }
    }


    func getTimegoal() -> NSMutableAttributedString {

        guard let goal = self.goal else { return  NSMutableAttributedString(string: "")}
        if goal < 60 {

            let strH = "00".getAttributedStr_color(color: black_53, fontSzie: 12)
            strH.append(" h ".getAttributedStr_color(color: black_53, fontSzie: 8))

            let str = "\(goal)".getAttributedStr_color(color: black_53, fontSzie: 12)
            str.append(" m ".getAttributedStr_color(color: black_53, fontSzie: 8))

            strH.append(str)
            return strH
        } else {
            let h = goal/60
            let strH = "\(h)".getAttributedStr_color(color: black_53, fontSzie: 12)
            strH.append(" h ".getAttributedStr_color(color: black_53, fontSzie: 8))

            let M = goal%60
            let strM = "\(M)".getAttributedStr_color(color: black_53, fontSzie: 12)
            strM.append(" m ".getAttributedStr_color(color: black_53, fontSzie: 8))

            strH.append(strM)
            return strH
        }
    }


    func getPagegoal()-> NSMutableAttributedString {
        guard let goal = self.goal else { return  NSMutableAttributedString(string: "")}
        let str = "\(goal)".getAttributedStr_color(color: black_53, fontSzie: 12)
        str.append(" 页 ".getAttributedStr_color(color: black_53, fontSzie: 8))
        return str
    }
    func getPagedone()-> NSMutableAttributedString {

        guard let done = self.done else { return  NSMutableAttributedString(string: "")}
        let str = "\(done)".getAttributedStr_color(color: green_84B53E, fontSzie: 12)
        str.append(" 页 ".getAttributedStr_color(color: black_53, fontSzie: 8))
        return str
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

    var head : UserInfoModel_head = UserInfoModel_head()
    var week_goal : UserInfoModel_weekgoal = UserInfoModel_weekgoal()
    var report : ReportModel = ReportModel()
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        head <- map["head"]
        week_goal <- map["week_goal"]
        report <- map["report"]
    }
}
