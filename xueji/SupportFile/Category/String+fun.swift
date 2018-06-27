//
//  String+fun.swift
//  学记
//
//  Created by lvxin on 2017/10/30.
//  Copyright © 2017年 lvxin. All rights reserved.
//

import UIKit


extension String {
    
    /// 测文字的高度
    ///
    /// - parameter width: 宽度限制
    /// - parameter font:  字体
    ///
    /// - returns: 高度
    func xj_heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.height
    }
    
    
    func xj_widthWithConstrainedWidth(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width:  CGFloat.greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.width
    }
    
    
    //    由字符串获取label高度
    func xj_getLabHeight(font:UIFont,LabelWidth:CGFloat) -> CGFloat {
        let statusLabelText: NSString = self as NSString
        let size = CGSize(width:LabelWidth,height: 900)
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context: nil).size
        return strSize.height
    }
    
    //    由字符串获取label宽度
    func xj_getLabWidth(labelStr:String,font:UIFont,LabelHeight:CGFloat) -> CGFloat {
        let statusLabelText: NSString = labelStr as NSString
        let size = CGSize(width:900,height: LabelHeight)
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context: nil).size
        return strSize.width
    }
    
    // MARK: 公共部分
    /// 获取版本号
    ///
    /// - returns: 版本号
    func xj_getAppVersion() -> String  {
        let infoDict = Bundle.main.infoDictionary
        if let info = infoDict {
            let appVersion = info["CFBundleShortVersionString"] as! String!
            return ("ios" + appVersion!)
        } else {
            return ""
        }
    }
    
    
//    func getToken_RSA() -> String {
////        let token:String!  = LoginModelMapper.getToken()
//        //        KFBLog(message: "token   "+token)
//        //        let token_rsa = RSA.encryptString(token, publicKey: pubkey)
//        return token
//        //        return "eyJ0b2tlbiI6IjE0Zjk0ODU4MjI0YzQwMGZmMjQyNzY2MmY1ZjI0MTNjIiwic2VjcmV0IjoiN2FlMTcxY2NiM2M4NjIyN2E1ZGZkOGNiMTEzZDA0MmUifQ=="
//    }
    
    /// 判断是否为空字符串
    ///
    /// - parameter str: 字符串
    ///
    /// - returns: 是否
    
    static func xj_isStr(str : String?) -> Bool {
        if (str == nil)  {
            return false
        } else {
            if ((str?.count)! < 0){
                return false
            } else {
                return true
            }
        }
    }
    
    
    /// 判断是否是手机号
    ///
    /// - parameter phoneNum: 手机号
    ///
    /// - returns: 是或者不是
    static func xj_isMobileNumber(phoneNum : String) -> Bool {
        let predicateStr = "^((13[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$"
        let currObject = phoneNum
        let predicate =  NSPredicate(format: "SELF MATCHES %@" ,predicateStr)
        return predicate.evaluate(with: currObject)
    }
    
    
    
    /// 时间格式转换
    ///
    /// - Parameters:
    ///   - dateStr: 时间字符串
    ///   - style: 样式选择
    /// - Returns: 转换后的时间字符串
    static func xj_getDate_style1(dateStr : String,style:Int) -> String {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
        let date = dfmatter.date(from: dateStr)
        var  styleSty = ""
        switch style {
        case 0:
            styleSty = "MM.dd HH:mm"
        case 1:
            styleSty = "HH:mm"
        case 2:
            styleSty = "HH:mm"
        case 3:
            styleSty = "dd"
        case 4:
            styleSty = "yyyy年MM月dd日"
        default:
            styleSty = "yyyy.MM.dd HH:mm"
        }
        
        let dfmatter2 = DateFormatter()
        dfmatter2.dateFormat = styleSty
        return dfmatter2.string(from: date!)
    }

    /// 获取日期dd
    ///
    /// - Parameter dateStr: <#dateStr description#>
    /// - Returns: <#return value description#>
    static func xj_getDate_day(dateStr : String) -> String {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd"
        let date = dfmatter.date(from: dateStr)
        let dfmatter2 = DateFormatter()
        dfmatter2.dateFormat = "dd"
        return dfmatter2.string(from: date!)
    }

    /// 获取当前时间
    ///
    /// - Returns: <#return value description#>
    static func xj_getDate_now() -> (time1 : String,time2 : String) {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd"
        let str = dfmatter.string(from: Date())

        
        dfmatter.dateFormat="HH:mm"
        let str2 = dfmatter.string(from: Date())
        return (str,str2)
    }


    /// 获取月份
    ///
    /// - Parameter dateStr: <#dateStr description#>
    /// - Returns: <#return value description#>
    static func xj_getDate_month(dateStr : String) -> String {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM"
        let date = dfmatter.date(from: dateStr)
        let dfmatter2 = DateFormatter()
        dfmatter2.dateFormat = "MM"
        return dfmatter2.string(from: date!)
    }


    /// 获取月/日
    ///
    /// - Parameter dateStr: <#dateStr description#>
    /// - Returns: <#return value description#>
    static func xj_getDate_dayMonth(dateStr : String) -> String {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd"
        let date = dfmatter.date(from: dateStr)
        let dfmatter2 = DateFormatter()
        dfmatter2.dateFormat = "MM/dd"
        return dfmatter2.string(from: date!)
    }

    /// 获取月
    ///
    /// - Parameter dateStr: <#dateStr description#>
    /// - Returns: <#return value description#>
    static func xj_getDate_Month(dateStr : String) -> String {

       var index = dateStr.index(of: "-")
        index = dateStr.index(index!, offsetBy: 1)
        let str = dateStr.suffix(from: index!)
        return String(str)
//        let dfmatter = DateFormatter()
//        dfmatter.dateFormat="yyyy-MM"
//        let date = dfmatter.date(from: dateStr)
//        let dfmatter2 = DateFormatter()
//        dfmatter2.dateFormat = "MM"
//        return dfmatter2.string(from: date!)
    }
    
    
    /// 获取星期几
    ///
    /// - Returns: <#return value description#>
    static func getDayIndex()->Int {
        let currentDate = Date()
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.init(name: "Asia/Shanghai")! as TimeZone
        let components =  calendar.dateComponents([.year,.month,.day,.weekday,.weekOfMonth,.weekdayOrdinal,.yearForWeekOfYear,.era], from: currentDate)
        let weekNum : Int = components.weekday!
        XJLog(message: "adsfasdf\(weekNum)")
        if weekNum == 1 {
            return  6
        } else {
            return   weekNum - 1
        }
    }


    /// 获取一周日期
    ///
    /// - Returns: <#return value description#>
    static func getWeek() -> String {
        let currentDate = Date()
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.init(name: "Asia/Shanghai")! as TimeZone
        var components =  calendar.dateComponents([.year,.month,.day,.weekday,.weekOfMonth,.weekdayOrdinal,.yearForWeekOfYear,.era], from: currentDate)
        let weekDay : Int = components.weekday!
        let day : Int = components.day!


        XJLog(message: weekDay)
        XJLog(message: day)
        var firstDiff = 0
        var lastDiff = 0
        if weekDay == 1 {
            firstDiff = -6
            lastDiff = 0
        } else {
            firstDiff = calendar.firstWeekday - weekDay + 1;
            lastDiff = 8 - weekDay;
        }
        XJLog(message: firstDiff)
        XJLog(message: lastDiff)


        components.day = day + firstDiff
        let firstDayOfWeek = calendar.date(from: components)

        components.day = day + lastDiff
        let lastDayOfWeek = calendar.date(from: components)

        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd"
        let firstDay = dfmatter.string(from: firstDayOfWeek!)
        let lastDay = dfmatter.string(from: lastDayOfWeek!)
        let str = firstDay + "~" + lastDay
        return str
    }

    /// 时间计时器
    ///
    /// - Parameter sencond: <#sencond description#>
    /// - Returns: <#return value description#>
    static func getCountTime(sencond : Int)->(timeStr : String,timeStr2 : String) {
        let min = 60
        let hour = 60 * 6



        var timStr = ""
        var homeTimStr = "00"
        var minTimStr = "00"
        var sencondTimStr = "00"

        let num = sencond/hour
        XJLog(message: "\(num)")
        //小时
        if num >= 10 {
            homeTimStr = "\(num)"
        } else {
            homeTimStr = "0\(num)"
        }
        //分钟
        let num3 = (sencond - num * hour) / min

        XJLog(message: "\(num3)")
        if num3 > 10 {
            minTimStr = "\(num3)"
        } else {
            minTimStr = "0\(num3)"
        }

        //秒钟
        let num4 = (sencond - num * hour - num3 * min)

        XJLog(message: "\(num4)")
        if num4 >= 10 {
            sencondTimStr = "\(num4)"
        } else {
            sencondTimStr = "0\(num4)"
        }

        timStr = "\(homeTimStr):\(minTimStr):\(sencondTimStr)"
        let timeStr2 = "\(homeTimStr)h\(minTimStr)m"

        return (timStr,timeStr2)
    }


    /// 分钟转换小时
    ///
    /// - Parameter min: <#min description#>
    /// - Returns: <#return value description#>
    static func getHour(min :Int) -> Float {
        return Float(min)/Float(60)
    }

    static func getHour_more(min : Int) -> Float {
        if min < 60 {
            //一小时之内
            return 1
        } else if min < 60 * 10 {
            //10小时之内
            return Float(min/60) + 1
        } else {
            return Float(min/60) + 10
        }
    }

    static func getPage(page : Int) -> Double{
        if page  < 10 {
            return 10
        } else if page < 100 {
            return Double(page) + 10
        } else if page < 1000 {
            return Double(page) + 100
        } else {
            return Double(page)
        }
    }


    /// 将str转为attributeStr
    ///
    /// - Parameters:
    ///   - color: 字体颜色
    ///   - fontSzie: 字体
    /// - Returns: <#return value description#>
    func getAttributedStr_color(color : UIColor,fontSzie : Int) ->(NSMutableAttributedString) {
         let attributeStr = NSMutableAttributedString(string: self)
         let range : NSRange = NSRange.init(location: 0, length: self.count)
         attributeStr.addAttribute(NSForegroundColorAttributeName, value: color, range: range)
         attributeStr.addAttribute(NSFontAttributeName, value: xj_fzFontMedium(ip6(fontSzie)), range: range)
         return attributeStr
    }

    func containsEmoji() -> Bool {
        for scalar in unicodeScalars{
            switch scalar.value{
            case
            0x00A0...0x00AF,
            0x2030...0x204F,
            0x2120...0x213F,
            0x2190...0x21AF,
            0x2310...0x329F,
            0x1F000...0x1F9CF:
                return true
            default:
                continue
            }
        }
        return false
    }
    

}

