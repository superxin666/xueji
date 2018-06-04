


//
//  WeekAimDetailModel.swift
//  xueji
//
//  Created by lvxin on 2018/6/4.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

class WeekAimDetailModel_report: Mappable {

    var beg_date : String!
    var end_date : String!

    var time_goal : Int!
    var time_done : Int!
    var time_rate : Int!

    var page_goal : Int!
    var page_done : Int!
    var page_rate : Int!


    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        beg_date <- map["beg_date"]
        end_date <- map["end_date"]
        time_goal <- map["time_goal"]
        time_done <- map["time_done"]
        time_rate <- map["time_rate"]
        page_goal <- map["page_goal"]
        page_done <- map["page_done"]
        page_rate <- map["page_rate"]
    }

    func getTimedone() -> NSMutableAttributedString{
        guard let done = self.time_done else { return  NSMutableAttributedString(string: "")}
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

        guard let goal = self.time_goal else { return  NSMutableAttributedString(string: "")}
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
        guard let goal = self.page_goal else { return  NSMutableAttributedString(string: "")}
        let str = "\(goal)".getAttributedStr_color(color: black_53, fontSzie: 12)
        str.append(" 页 ".getAttributedStr_color(color: black_53, fontSzie: 8))
        return str
    }
    func getPagedone()-> NSMutableAttributedString {

        guard let done = self.page_done else { return  NSMutableAttributedString(string: "")}
        let str = "\(done)".getAttributedStr_color(color: green_84B53E, fontSzie: 12)
        str.append(" 页 ".getAttributedStr_color(color: black_53, fontSzie: 8))
        return str
    }
}

class WeekAimDetailModel: Mappable {

    var month : String!
    var report : [WeekAimDetailModel_report] = []


    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        month <- map["month"]
        report <- map["report"]
    }
}
